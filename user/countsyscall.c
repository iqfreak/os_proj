#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

int main() {
    int count = countsyscall();
    printf("%d\n", count);

    return 0;
}
