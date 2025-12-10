#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

// fact x     [x!]
int main(int argc, char *argv[]) {
    if (argc == 2 && argv[1][0] == '?' && argv[1][1] == '\0') {
        printf("Usage: fact <num>\n");
        return 0;
    }

    if (argc != 2) {
        fprintf(2, "fact: incorrect usage, fact <num>\n");
        return -1;
    }

    if (!is_valid_int(argv[1])) {
        fprintf(2, "add: '%s' is not a valid integer\n", argv[1]);
        return -1;
    }

    int n = atoi(argv[1]);
    if (n < 0) {
        fprintf(2, "cannot take in a negative value \n");
        return -1;
    }

    for (int i = n - 1; i > 1; i--) {
        n = n * i;
    }
    fprintf(2, "%d\n", n);
    return 0;
}
