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

    for (p = proc; p < &proc[NPROC]; p++) {
        acquire(&p->lock);

        if (p->state == UNUSED) {
            release(&p->lock);
            continue;
        }

        ptable[count].pid = p->pid;
        ptable[count].ppid = p->parent ? p->parent->pid : 0;
        ptable[count].state = p->state;
        safestrcpy(ptable[count].name, p->name, sizeof(ptable[count].name));
        ptable[count].sz = p->sz;

        ++count;
        release(&p->lock);
    }

    return count;
}
