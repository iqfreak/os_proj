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
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-n") == 0) {
            char *targetInt = argv[i + 1];
            if (!is_valid_int(targetInt)) {
                printf("tail: %s is not a valid integer\n", argv[i + 1]);
                return -1;
            }

            nlines = atoi(targetInt);
        }
    }

    if (nlines < 0) {
        printf("tail: nlines can't be negative \n");
        return -1;
    }

    char *path = 0;
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-n") == 0) { i++; continue; }
        path = argv[i];
        break;
    }

    int fd;
    int close_fd = 0;
    if (!path) {
        fd = 0; /* stdin */
    } else {
        fd = open(path, O_RDONLY);
        if (fd < 0) {
            printf("tail: cannot open %s\n", path);
            return -1;
        }
        close_fd = 1;
    }

    char buf[600];
    int nread = read(fd, buf, sizeof(buf));

    // empty file or read err
    if (nread <= 0) {
        if (close_fd) close(fd);
        return 0;
    }

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

    if (i < 0) i = 0;
    int len = nread - i;
    if (len > 0)
        write(1, buf + i, len);

    if (close_fd) close(fd);

    return 0;
}
