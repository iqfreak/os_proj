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
        return -1;
    }

    if (!is_valid_int(argv[1])) {
        fprintf(2, "add: '%s' is not a valid integer\n", argv[1]);
        return -1;
    }

    if (!is_valid_int(argv[2])) {
        fprintf(2, "add: '%s' is not a valid integer\n", argv[2]);
        return -1;
    }

    int a = atoi(argv[1]);
    int b = atoi(argv[2]);
    printf("%d\n", a + b);

    return 0;
}
