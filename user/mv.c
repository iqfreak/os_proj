#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

char *strcat(char *dst, const char *src)
{
  char *p = dst;

  while (*p)
    p++;

  // copy src into dst starting at the end
  while (*src)
  {
    *p = *src;
    p++;
    src++;
  }

  *p = 0;

  return dst;
}

int is_dir(char *path)
{
  struct stat st;
  if (stat(path, &st) < 0)
    return 0;
  return st.type == T_DIR;
}

char *join_path(char *dir, char *filename, char *out_buffer, int bufsize)
{
  int dn = strlen(dir);
  int nn = strlen(filename);
  int need = dn + 1 + nn + 1;
  if (need > bufsize)
    return 0;
  strcpy(out_buffer, dir);
  if (dir[dn - 1] != '/')
  {
    out_buffer[dn] = '/';
    out_buffer[dn + 1] = 0;
  }
  strcat(out_buffer, filename);
  return out_buffer;
}

/*mv src dst*/
int main(int argc, char *argv[])
{
  if (argc != 3)
  {
    fprintf(2, "mv: Incorrect usage, mv src dst\n");
    exit(1);
  }

  char *src = argv[1];
  int is_src_dir = is_dir(src);
  char *dst = argv[2];
  int is_dst_dir = is_dir(dst);

  char dst_path[500];
  strcpy(dst_path, dst);
  char *filename = src;

  // Dir to dir
  if (is_src_dir)
  {
    printf("mv: direcotry to directory isn't implemented yet\n");
    exit(0);
  }

  for (char *p = src; *p; p++)
  {
    if (*p == '/')
      filename = p + 1;
  }

  // File to File
  if (!is_src_dir && is_dst_dir)
  {
    join_path(dst, filename, dst_path, sizeof(dst_path));
    printf("New path: %s, %s\n", filename, dst_path);
  }

  if (link(src, dst_path) < 0)
  {
    fprintf(2, "mv: link src %s to dst %s failed\n", src, dst_path);
    exit(1);
  }

  if (unlink(src) < 0)
  {
    fprintf(2, "mv: unlink %s failed\n", src);
    if (unlink(dst_path) < 0)
    {
      fprintf(2, "mv: rollback failed for %s\n", dst_path);
    }
    exit(1);
  }

  exit(0);
}
