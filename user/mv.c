#include "kernel/fs.h"
#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

// mkdir a; mkdir b; touch a/a_file.txt
int main(int argc, char *argv[]) {
    if (argc == 2 && argv[1][0] == '?' && argv[1][1] == '\0') {
        printf("Usage: mv <src> <dst>\n");
        return 0;
    }

    if (argc != 3) {
        fprintf(2, "mv: Incorrect usage, mv src dst\n");
        exit(1);
    }

    exit(move(argv[1], argv[2], 1));
}
