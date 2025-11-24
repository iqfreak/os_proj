#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

/*
mv src dst
*/
int main(int argc, char *argv[])
{
  if (argc != 3)
  {
    printf("mv: Incorrect usage, mv src dst\n");
    exit(1);
  }

  if (link(argv[1], argv[2]) < 0)
  {
    printf("mv: link src %s to dst %s failed\n", argv[1], argv[2]);
    exit(1);
  }

  if (unlink(argv[1]) < 0)
  {
    printf("mv: unlink %s failed\n", argv[1]);
    if (unlink(argv[2]) < 0)
    {
      printf("mv: rollback failed for %s\n", argv[2]);
    }
    exit(1);
  }

  exit(0);
}
