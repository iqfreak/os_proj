#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

/*mv src dst*/
int main(int argc, char *argv[])
{
  if (argc != 3)
  {
    fprintf(2, "mv: Incorrect usage, mv src dst\n");
    exit(1);
  }

  // int statusCode = move(argv[1], argv[2], 0, err_msg);
  // if (statusCode < 0)
  // {
  //   fprintf(2, "%s", err_msg);
  // }
  // exit(statusCode);
}
