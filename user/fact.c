#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

//fact x     [x!]
int main(int argc, char *argv[])
{
  if (argc != 2)
  {
    fprintf(2, "fact: incorrect usage, fact x \n");
    exit(1);
  }

  int n=atoi(argv[1]);
  if(n<0)
  {
    fprintf(2,"cannot take in a negative value /n");
    exit(1);
  }

  for(int i=n-1;i>1;i--)
  {
    n=n*i;
  }
  fprintf(2,"%d/n",n);
  exit(0);

}
