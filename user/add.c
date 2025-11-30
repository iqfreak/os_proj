#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

// add a b c     [a+b=c]
int main(int argc, char *argv[]) {
    if (argc == 2 && argv[1][0] == '?' && argv[1][1] == '\0') {
        printf("Usage: add <a> <b>\n");
        return 0;
    }

    if (argc != 3) {
        fprintf(2, "incorrect usage");
        exit(1);
    }

    int a = atoi(argv[1]);
    int b = atoi(argv[2]);
    printf("%d\n", a + b);

    exit(0);
}
