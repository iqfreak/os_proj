#include "kernel/fcntl.h"
#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

char buf[512];

int flag_l = 0;
int flag_w = 0;
int flag_c = 0;
int flag_L = 0;

void wc(int fd, char *name) {
    int i, n;
    int l, w, c, inword;
    int L = 0;
    l = w = c = 0;
    int oldc = 0;
    inword = 0;

    while ((n = read(fd, buf, sizeof(buf))) > 0) {
        for (i = 0; i < n; i++) {
            char ch = buf[i];
            c++;


            if (strchr(" \r\t\n\v\f", ch))
                inword = 0;
            else if (!inword) {
                w++;
                inword = 1;
            }


            if (ch == '\n') {
                l++;

                if ((c - oldc) > L) {
                    L = c - oldc;
                }

                oldc = c;
            }
        }
    }

    if (n < 0) {
        printf("wc: read error\n");
        exit(1);
    }


    if ((c - oldc) > L) {
        L = c - oldc;
    }


    if (!flag_l && !flag_w && !flag_c && !flag_L) {
        if (name && name[0])
            printf("line count is %d word count is %d char count is %d the longest line length is %d %s\n", l, w, c, L, name);
        else
            printf("line count is %d word count is %d char count is %d the longest line length is %d\n", l, w, c, L);
        return;
    }

    if (flag_l) printf("%d ", l);
    if (flag_w) printf("%d ", w);
    if (flag_c) printf("%d ", c);
    if (flag_L) printf("%d ", L);
    if (name && name[0]) printf("%s", name);
    printf("\n");
}

int main(int argc, char *argv[]) {


    if (argc == 2 && argv[1][0] == '?' && argv[1][1] == '\0') {
        printf("Usage: wc <file_path>\n");
        return 0;
    }


    int files_start = 1;
    for (; files_start < argc; files_start++) {
        char *arg = argv[files_start];
        if (arg[0] != '-' || arg[1] == '\0')
            break;
        for (int j = 1; arg[j]; j++) {
            switch (arg[j]) {
            case 'l': flag_l = 1; break;
            case 'w': flag_w = 1; break;
            case 'c': flag_c = 1; break;
            case 'L': flag_L = 1; break;
            default:
                printf("wc: unknown flag -%c\n", arg[j]);
                exit(1);
            }
        }
    }

    int fd, i;

    if (files_start >= argc) {
        wc(0, "");
        exit(0);
    }

    for (i = files_start; i < argc; i++) {
        if ((fd = open(argv[i], O_RDONLY)) < 0) {
            printf("wc: cannot open %s\n", argv[i]);
            exit(1);
        }
        wc(fd, argv[i]);
        close(fd);
    }
    exit(0);
}
