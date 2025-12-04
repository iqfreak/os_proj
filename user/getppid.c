#include "kernel/types.h"
#include "user/user.h"

int main() {
    printf("my ppid = %d\n", getppid());
    exit(0);
}
