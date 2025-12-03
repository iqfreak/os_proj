#include "kernel/fcntl.h"
#include "kernel/proc.h"
#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[]) {

    int pid;
    int k, nprocess = 10;
    int z, steps = 10000;
    char buffer_src[1024], buffer_dst[1024];

    for (k = 0; k < nprocess; k++) {
        // ensure different creation times (proc->ctime)
        // needed for properly testing FCFS scheduling
        sleep(2);

        pid = fork();
        if (pid < 0) {
            printf("%d failed in fork!\n", getpid());
            exit(0);

        } else if (pid == 0) {
            // child
            printf("[pid=%d] created\n", getpid());

            for (z = 0; z < steps; z += 1) {
                // copy buffers one inside the other and back
                // used for wasting cpu time
                memmove(buffer_dst, buffer_src, 1024);
                memmove(buffer_src, buffer_dst, 1024);
            }
            exit(0);
        }
    }

    for (k = 0; k < nprocess; k++) {
        struct proc_time pt;
        if (get_proc_time(pid, &pt) == 0) {
            printf("PID %d: started at tick %d, ran for %d ticks (%d cycles)\n",
                   (int)pt.pid, (int)pt.start_ticks, (int)pt.total_ticks, (int)pt.total_cycles);
        }
    }

    exit(0);
}

// #include "kernel/types.h"
// #include "kernel/stat.h"
// #include "user/user.h"

// int main() {
//     int pid = fork();
//     if(pid == 0) {
//         // Child process - runs to completion
//         for(int i = 0; i < 100; i++) {
//             printf("Child: %d\n", i);
//         }
//         exit(0);
//     } else {
//         // Parent process
//         for(int i = 0; i < 100; i++) {
//             printf("Parent: %d\n", i);
//         }
//         wait(0);
//     }
//     exit(0);
// }
