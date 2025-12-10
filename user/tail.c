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

    if (nlines < 0) {
        printf("tail: nlines can't be negative \n");
        return -1;
    }

    char *path = flagIdx == 1 ? argv[3] : argv[1];

    int fd = open(path, O_RDONLY);
    if (fd < 0) {
        printf("tail: cannot open %s\n", argv[1]);
        return -1;
    }

    char buf[600];
    int nread = read(fd, buf, sizeof(buf));
    int lines = 0;

    int i;
    for (i = nread - 1; i >= 0; --i) {
        if (buf[i] == '\n')
            ++lines;

        if (lines > nlines) {
            ++i;
            break;
        }
    }

    write(1, buf + i, nread - i);
    close(fd);

    return 0;
}
