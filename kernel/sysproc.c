#include "defs.h"
#include "memlayout.h"
#include "param.h"
#include "proc.h"
#include "riscv.h"
#include "spinlock.h"
#include "types.h"

uint64
sys_exit(void) {
    int n;
    argint(0, &n);
    exit(n);
    return 0; // not reached
}

uint64
sys_getpid(void) {
    return myproc()->pid;
}

uint64
sys_fork(void) {
    return fork();
}

uint64 sys_wait(void) {
    uint64 p;
    argaddr(0, &p);
    return wait(p);
}

uint64
sys_sbrk(void) {
    uint64 addr;
    int n;

    argint(0, &n);
    addr = myproc()->sz;
    if (growproc(n) < 0)
        return -1;
    return addr;
}

uint64
sys_sleep(void) {
    int n;
    uint ticks0;

    argint(0, &n);
    if (n < 0)
        n = 0;
    acquire(&tickslock);
    ticks0 = ticks;
    while (ticks - ticks0 < n) {
        if (killed(myproc())) {
            release(&tickslock);
            return -1;
        }
        sleep(&ticks, &tickslock);
    }
    release(&tickslock);
    return 0;
}

uint64
sys_kill(void) {
    int pid;

    argint(0, &pid);
    return kill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void) {
    uint xticks;

    acquire(&tickslock);
    xticks = ticks;
    release(&tickslock);
    return xticks;
}

uint64
sys_shutdown(void) {
    volatile uint32 *qemu_shutdown = (volatile uint32 *)0x100000;
    *qemu_shutdown = 0x5555;
    return 0;
}

uint64 sys_countsyscall(void) {
    extern uint64 syscallCount;
    extern struct spinlock syscallLock;

    int count;
    acquire(&syscallLock);
    count = syscallCount;
    release(&syscallLock);

    return count;
}

uint64 sys_getptable(void) {
    struct pinfo {
        int pid;
        int ppid;
        int state;
        char name[16];
        uint64 sz;
    };

    extern struct proc proc[NPROC];
    struct proc *p;

    struct pinfo ptable[NPROC];
    int count = 0;

    uint64 addr;
    argaddr(0, &addr);

    for (p = proc; p < &proc[NPROC]; p++) {
        acquire(&p->lock);

        if (p->state == UNUSED) {
            release(&p->lock);
            continue;
        }

        ptable[count].pid = p->pid;
        ptable[count].ppid = proc_parent_pid(p);
        ptable[count].state = p->state;
        safestrcpy(ptable[count].name, p->name, sizeof(ptable[count].name));
        ptable[count].sz = p->sz;

        ++count;
        release(&p->lock);
    }

    if (copyout(myproc()->pagetable, addr, (char *)ptable, count * sizeof(struct pinfo)) < 0)
        return -1;

    return count;
}

uint64
sys_get_proc_time(void) {
    int pid;
    uint64 addr;
    extern struct proc proc[NPROC];
    struct proc *p;
    struct proc_time pt;

    // Extract arguments
    argint(0, &pid);
    argaddr(1, &addr);

    // Find the process
    for (p = proc; p < &proc[NPROC]; p++) {
        acquire(&p->lock);
        if (p->pid == pid && p->state != UNUSED) {
            // Fill the struct
            pt.pid = p->pid;
            // pt.start_time = p->start_time;
            pt.fixed_start_time = p->fixed_start_time;
            pt.turnaround_time = p->turnaround_time;
            pt.priority = p->priority;
            pt.wait_time = p->wait_time;

            // Copy to user space
            if (copyout(myproc()->pagetable, addr, (char *)&pt, sizeof(pt)) < 0) {
                release(&p->lock);
                return -1;
            }

            release(&p->lock);
            return 0;
        }
        release(&p->lock);
    }

    return -1;
}

uint64
sys_set_priority(void) {
    int pid, priority;
    struct proc *p;

    extern struct proc proc[NPROC]; // Add this declaration

    // Use argint for both parameters since they're integers
    argint(0, &pid);
    argint(1, &priority);

    if (priority < 0 || priority > 20)
        return -1;

    for (p = proc; p < &proc[NPROC]; p++) {
        acquire(&p->lock);
        if (p->pid == pid && p->state != UNUSED) {
            p->priority = priority;
            release(&p->lock);
            return 0;
        }
        release(&p->lock);
    }

    return -1; // Process not found
}

uint64
sys_getppid(void) {
    struct proc *p = myproc();
    acquire(&p->lock);
    int ppid = proc_parent_pid(p);
    release(&p->lock);

    return ppid;
}

uint64
sys_datetime(void) {
    uint64 addr;
    argaddr(0, &addr);

    struct rtcdate datetime;
    get_datetime(&datetime);

    if (copyout(myproc()->pagetable, addr, (char *)&datetime, sizeof(datetime)) < 0)
        return -1;

    return 0;
}
static uint64 rand_seed = 1;

uint64
sys_randd(void) {
    struct proc *p = myproc();

    // Mix in the pid to avoid identical sequences from multiple processes
    rand_seed ^= (p->pid * 0x9e3779b97f4a7c15ULL);

    rand_seed = rand_seed * 1103515245 + 12345;
    return (rand_seed >> 16) & 0x7FFF;
}
