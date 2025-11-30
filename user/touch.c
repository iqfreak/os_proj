#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
    if (argc == 2 && argv[1][0] == '?' && argv[1][1] == '\0') {
        printf("Usage: touch <filename>\n");
        return 0;
    }

    if(argc != 2) {
        printf("Incorrect usage, touch <filename>");
    }


    char *path = argv[1];
    int fd;

    fd = open(path, 0);
    if(fd >= 0) {
        close(fd);
        printf("error: file '%s' already exists\n", path);
    }

    fd = open(path, O_CREATE | O_RDWR);
    if(fd < 0) {
        printf("error: failed to create file '%s'\n", path);
    }

    printf("created file '%s'\n", path);
    close(fd);
    exit(0);
}
