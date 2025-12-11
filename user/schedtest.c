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
        // sleep(2);

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

    int avg_turnaround = 0;

    for (k = 0; k < nprocess; k++) {

        struct proc_time pt;
        wait((int*)&pt);  // Pass address, not 0

        avg_turnaround += pt.turnaround_time;

        printf("PID %d (priority %d): started at tick %d, ran for %d ticks (%d cycles)\n",
               (int)pt.pid, (int)pt.priority, (int)pt.start_ticks,
               (int)pt.turnaround_time, (int)pt.total_cycles);
    }

    avg_turnaround /= nprocess;

    exit(0);
}
