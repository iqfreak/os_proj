#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

//add a b c     [a+b=c]
int main(int argc, char *argv[])
{
  if (argc != 3)
  {
    fprintf(2, "incorrect usage");
    exit(1);
  }

  int a=atoi(argv[1]);
  int b=atoi(argv[2]);
  printf("%d\n",a+b);


  exit(0);
}
