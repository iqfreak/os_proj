#include "kernel/fs.h"
#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
    if (argc == 2 && argv[1][0] == '?' && argv[1][1] == '\0') {
        printf("Usage: tail file1 file2 ?-n <nlines>\n");
        return 0;
    }

    // Flags Parsing
    struct opt options[] = {
        {.opt = 'n', .has_arg = 1},
    };
    int nopts = sizeof(options) / sizeof(options[0]);

    parse_flags(argc, argv, options, nopts);

    int nlines = 10;
    if (options[0].seen) {
        int val = parse_nonneg_int(options[0].arg);
        if (val <= 0) {
            printf("Bad usage, n liens can't be a zero or less");
            return -1;
        }

        nlines = val;
    }
    // End Flags Parsing

    strip_flags(argc, argv, "n");

    if (argc != 2) {
        printf("Incorrect usage, tail file ?-n <nlines>");
    }

    printf("\n--%s, nlines: %d\n", argv[1], nlines); // this should be the file path

    printf("lol\n");
    return 0;
}
