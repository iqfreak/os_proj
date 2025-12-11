#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("sleep: incorrect usage, sleep <ticks>\n");
        return -1;
    }

    if (argv[1][0] == '?') {
        printf("sleep <ticks>\n");
        return 0;
    }

    if (!is_valid_int(argv[1])) {
        printf("%s is not a valid integer\n", argv[1]);
        return -1;
    }

    sleep(atoi(argv[1]));
    exit(0);
}
