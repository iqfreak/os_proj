#include "kernel/fs.h"
#include "kernel/proc.h"
#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

// mkdir a; mkdir b; touch a/a_file.txt
int main(int argc, char *argv[]) {
    static char *states[] = {
        [UNUSED] "unused",
        [USED] "used",
        [SLEEPING] "sleep ",
        [RUNNABLE] "runble",
        [RUNNING] "run   ",
        [ZOMBIE] "zombie",
    };

    struct pinfo ptable[NPROC];
    int nproc = getptable(ptable);

    printf("PID   PPID   State     Name   Size\n");
    for (int i = 0; i < nproc; ++i) {
        printf("%d      %d     %s    %s     %d\n",
               ptable[i].pid,
               ptable[i].ppid,
               states[ptable[i].state],
               ptable[i].name,
               (int)ptable[i].sz);
    }

    printf("displaying %d processes\n", nproc);
    return 0;
}
