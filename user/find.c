#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/fs.h"

void
find_helper(char *path, char *name)
{
  int fd;
  struct stat st;
  char buf[512], *p;
  struct dirent de;

  if ((fd = open(path, O_RDONLY)) < 0) {
    return;
  }
  if (fstat(fd, &st) < 0) {
    close(fd);
    return;
  }

  if (st.type == T_FILE) {
    char *s = path + strlen(path) - 1;
    while (s >= path && *s != '/')
      s--;
    s++;
    if (strcmp(s, name) == 0) {
      printf("%s\n", path);
    }
    close(fd);
    return;
  }

  if (st.type == T_DIR) {
    if (strlen(path) + 1 + DIRSIZ + 1 > sizeof(buf)) {
      close(fd);
      return;
    }

    strcpy(buf, path);
    p = buf + strlen(buf);
    *p++ = '/';
    while (read(fd, &de, sizeof(de)) == sizeof(de)) {
      if (de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;

      if (strcmp(p, ".") == 0 || strcmp(p, "..") == 0)
        continue;

      if (stat(buf, &st) < 0) {
        continue;
      }

      if (st.type == T_FILE) {
        char *s = buf + strlen(buf) - 1;
        while (s >= buf && *s != '/')
          s--;
        s++;
        if (strcmp(s, name) == 0) {
          printf("%s\n", buf);
        }
      } else if (st.type == T_DIR) {
        find_helper(buf, name);
      }
    }
    close(fd);
    return;
  }

  close(fd);
}

int
main(int argc, char *argv[])
{
  if (argc < 3) {
    printf("usage: find filename path\n");
    exit(1);
  }

  char *name = argv[1];
  char *path = argv[2];

  find_helper(path, name);
  exit(0);
}
