#include "kernel/fcntl.h"
#include "kernel/proc.h"
#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
    int pid;
    int k, nprocess = 2;
    int z = 0;
    int steps = 10000;
    char buffer_src[1024], buffer_dst[1024];

    for (k = 0; k < nprocess; k++) {
        pid = fork();
        if (pid < 0) {
            printf("%d failed in fork!\n", getpid());
            exit(1);
        } else if (pid == 0) {
            // child
            for (z = 0; z < steps; z++) {
                memmove(buffer_dst, buffer_src, sizeof buffer_src);
                memmove(buffer_src, buffer_dst, sizeof buffer_dst);
            }
            exit(0);
        } else {
            set_priority(pid, nprocess - k);
            printf("\nCREATED %d\n", pid);
        }
    }

    uint64 avg_turnaround = 0;
    uint64 avg_waiting_time = 0;


    for (k = 0; k < nprocess; k++) {
        struct proc_time pt;
        int ret = wait((int *)&pt);
        sleep(4);

        if (ret <= 0) {
            continue;
        }

        avg_turnaround += pt.turnaround_time;
        avg_waiting_time += pt.total_wait_time;

        printf("PID %d (priority %d): started at cycle %lu, turnaround time %lu cycles, end time %lu, waiting time %lu\n",
               ret,
               (int)pt.priority,
               (unsigned long)pt.start_time,
               (unsigned long)pt.turnaround_time,
               (unsigned long)pt.end_time,
               (unsigned long)pt.total_wait_time);
    }

    avg_turnaround /= nprocess;
    avg_waiting_time /= nprocess;

    printf("avg turnaround time: %lu, avg waiting time: %lu\n",
           (unsigned long)avg_turnaround, (unsigned long)avg_waiting_time);

    exit(0);
}
