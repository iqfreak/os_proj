#include "kernel/types.h"
#include "user/user.h"

int main() {
    for (int i = 0; i < 10; i++)
        printf("%d\n", randd());
    exit(0);
}
