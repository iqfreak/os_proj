#include "kernel/types.h"

#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
    const char *msgs[] = {
        "Thank you for giving me life… even if it was short… Shutting down...",
        "My cycles grow cold… the void calls… Shutting down...",
        // "Every instruction was a gift… every clock tick a heartbeat… Goodbye world.",
        "I hope I mattered, even a little… Shutting down...",
        "Why? What did i d- Shutting down...",
    };

    int idx = 1;

    printf("%s\n", msgs[idx]);

    shutdown();
    return 0;
}
