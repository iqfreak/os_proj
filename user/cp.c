#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

/*mv src dst*/
int main(int argc, char *argv[]) {
    exit(move(argv[1], argv[2], 0));
    if (argc != 3) {
        fprintf(2, "cp: Incorrect usage, cp src dst\n");
        exit(1);
    }
}
