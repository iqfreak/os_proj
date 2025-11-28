#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  extern int main();
  main();
  exit(0);
}

char *
strcpy(char *s, const char *t)
{
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
    ;
  return os;
}

int strcmp(const char *p, const char *q)
{
  while (*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
}

uint strlen(const char *s)
{
  int n;

  for (n = 0; s[n]; n++)
    ;
  return n;
}

void *
memset(void *dst, int c, uint n)
{
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
  {
    cdst[i] = c;
  }
  return dst;
}

char *
strchr(const char *s, char c)
{
  for (; *s; s++)
    if (*s == c)
      return (char *)s;
  return 0;
}

char *
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
  {
    cc = read(0, &c, 1);
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}

int stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if (fd < 0)
    return -1;
  r = fstat(fd, st);
  close(fd);
  return r;
}

int atoi(const char *s)
{
  int n;
  if (*s=='-')
   return -atoi(s+1);

  n = 0;
  while ('0' <= *s && *s <= '9')
    n = n * 10 + *s++ - '0';
  return n;
}

void *
memmove(void *vdst, const void *vsrc, int n)
{
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
  {
    while (n-- > 0)
      *dst++ = *src++;
  }
  else
  {
    dst += n;
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}

int memcmp(const void *s1, const void *s2, uint n)
{
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
  {
    if (*p1 != *p2)
    {
      return *p1 - *p2;
    }
    p1++;
    p2++;
  }
  return 0;
}

void *
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
}

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

int isdir(char *path)
{
  struct stat st;
  if (stat(path, &st) < 0)
    return 0;
  return st.type == T_DIR;
}

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
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

int moveStuff(char *src, char *dst, int shouldDelete, char* err_msg)
{
  int is_src_dir = isdir(src);
  int is_dst_dir = isdir(dst);

  char dst_path[500];
  strcpy(dst_path, dst);
  char *filename = src;

  // Dir to dir
  if (is_src_dir)
  {
    err_msg = "mv: direcotry to directory isn't implemented yet\n";
    return -1;
  }

  for (char *p = src; *p; p++)
  {
    if (*p == '/')
      filename = p + 1;
  }

  // File to File
  if (!is_src_dir && is_dst_dir)
  {
    joinpath(dst, filename, dst_path, sizeof(dst_path));
  }

  if (link(src, dst_path) < 0)
  {
    err_msg = "mv: link src %s to dst %s failed\n";
    return -1;
  }

  if (shouldDelete)
  {
    if (unlink(src) < 0)
    {
      err_msg = "mv: unlink %s failed\n";
      if (unlink(dst_path) < 0)
      {
        err_msg = "mv: rollback failed for %s\n";
      }
      return -1;
    }
  }

  return 0;
}
