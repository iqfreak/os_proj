
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
            c++;
            if (buf[i] == '\n'){
            l++;

            if ((c - oldc) > L){
            L= c - oldc;
            oldc = c;}}
        if (strchr(" \r\t\n\v", buf[i]))
                inword = 0;
            else if (!inword) {
                w++;
                inword = 1;
            }



    }
  }
    if (n < 0) {
        printf("wc: read error\n");
        exit(1);
    }

    printf("line count is %d word count is %d char count is %d the longest line length is %d %s\n", l, w, c,L, name);
}

int main(int argc, char *argv[]) {

    if (argc == 2 && argv[1][0] == '?' && argv[1][1] == '\0') {
        printf("Usage: wc <file_path>\n");
        return 0;
    }


    int fd, i;

    if (argc <= 1) {
        wc(0, "");
        exit(0);
    }

    for (i = 1; i < argc; i++) {
        if ((fd = open(argv[i], O_RDONLY)) < 0) {
            printf("wc: cannot open %s\n", argv[i]);
            exit(1);
        }
        wc(fd, argv[i]);
        close(fd);
    }
    exit(0);
}
