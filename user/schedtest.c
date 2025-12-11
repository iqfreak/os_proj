#include "kernel/fcntl.h"
#include "kernel/proc.h"
#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
    int pid;
    int k, nprocess = 9;
    int z, steps = 100000;
    char buffer_src[1024], buffer_dst[1024];

    for (k = 0; k < nprocess; k++) {
        pid = fork();
        if (pid < 0) {
            printf("%d failed in fork!\n", getpid());
            exit(0);
        } else if (pid == 0) {
            int priority = nprocess - k; // Priorities 0-4
            set_priority(getpid(), priority);

            for (z = 0; z < steps; z += 1) {
                memmove(buffer_dst, buffer_src, 1024);
                memmove(buffer_src, buffer_dst, 1024);
            }
            exit(0);
        }
    }

    uint64 avg_turnaround = 0;
    uint64 avg_waiting_time = 0;

    for (k = 0; k < nprocess; k++) {

        struct proc_time pt;
        wait((int *)&pt); // Pass address, not 2

        avg_turnaround += pt.turnaround_time;
        avg_waiting_time += pt.wait_time;

        printf("PID %lu (priority %d): started at cycle %lu, turnaround time %lu cycles, end time: %lu, Waiting Time %lu\n",
               pt.pid, pt.priority, pt.fixed_start_time, pt.turnaround_time, pt.end_time, pt.wait_time);
    }

    avg_turnaround /= nprocess;
    avg_waiting_time /= nprocess;

    printf("avg turnaround time: %lu, avg waiting time: %lu\n", avg_turnaround, avg_waiting_time);

    exit(0);
}
