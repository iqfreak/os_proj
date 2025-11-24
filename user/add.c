#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
  int sum = 0;
  for (int i = 1; i < argc; ++i)
  {
    for (int j = 0; argv[i][j]; ++j)
    {
      if (argv[i][j] < '0' || argv[i][j] > '9')
      {
        printf("Bad usage at %s, only integers allowed\n", argv[i]);
        exit(1);
      }
    }
    sum += atoi(argv[i]);
  }
  printf("%d\n", sum);
  exit(0);
}
