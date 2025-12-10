#include "kernel/fcntl.h"
#include "kernel/fs.h"
#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
    if (argc == 2 && argv[1][0] == '?' && argv[1][1] == '\0') {
        printf("Usage: tail file1 ?-n <nlines>\n");
        return 0;
    }

    int nlines = 10;
    (void)nlines;  // To avoid unused variable warning
    int flagIdx = -1;
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-n") == 0) {
            char *targetInt = argv[i + 1];
            if (!is_valid_int(targetInt)) {
                printf("tail: %s is not a valid integer\n", argv[i + 1]);
                return -1;
            }

            flagIdx = i;
            nlines = atoi(targetInt);
        }
    }

    char *path = flagIdx == 1 ? argv[3] : argv[1];

    int fd = open(path, O_RDONLY);
    if (fd < 0) {
        printf("tail: cannot open %s\n", argv[1]);
        return -1;
    }
    // lseek


    close(fd);

    return 0;
}
