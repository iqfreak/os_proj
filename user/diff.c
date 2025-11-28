#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int read_line(int fd, char *buf) {
    int n = 0;
    char c;
    while(read(fd, &c, 1) == 1) {
        if(c == '\n') break;
        buf[n++] = c;
    }
    buf[n] = 0;
    return n;
}

int main(int argc, char *argv[])
{
  if (argc != 3)
  {
    fprintf(2, "diff: Incorrect usage \n");
    exit(1);
  }

  char *file1 = argv[1];
  char *file2 = argv[2];

  int fd1 = open(file1,0);
  int fd2 = open(file2,0);

  if(fd1 < 0 || fd2 < 0) {
    printf("Error opening files\n");
    exit(1);
  }

  char buf1[128], buf2[128];
  int line_num = 1;
  int differences=0;
  while(1)
  {
    int n1 = read_line(fd1, buf1);
    int n2 = read_line(fd2, buf2);

    if(n1 == 0 && n2 == 0) break;

    if(n1 == 0) {
        printf("Line %d only in %s:\n> %s\n", line_num, file2, buf2);
        line_num++;
        differences++;
        continue;
    }

    if(n2 == 0) {
        printf("Line %d only in %s:\n< %s\n", line_num, file1, buf1);
        line_num++;
        differences++;
        continue;
    }

    if(strcmp(buf1, buf2) != 0) {
        printf("Line %d differs:\n< %s\n> %s\n", line_num, buf1, buf2);
        differences++;
      }

    line_num++;
  }
 if(differences == 0) {
    printf("Files are identical\n");
 }

  close(fd1);
  close(fd2);

  exit(0);
}
