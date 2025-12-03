#include "kernel/fs.h"
#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/proc.h"

// mkdir a; mkdir b; touch a/a_file.txt
int main(int argc, char *argv[]) {
    // static char *states[] = {
    //     [UNUSED] "unused",
    //     [USED] "used",
    //     [SLEEPING] "sleep ",
    //     [RUNNABLE] "runble",
    //     [RUNNING] "run   ",
    //     [ZOMBIE] "zombie",
    // };

    printf("PID   PPID   State     Name   Size\n");
    int nproc = getptable();

    // printf("%d      %d     %s    %s     %d\n",
    //    p->pid,
    //    p->parent ? p->parent->pid : 0,
    //    states[p->state],
    //    p->name,
    //    (int)p->sz);

    printf("displaying %d processes\n", nproc);
    return 0;
}
