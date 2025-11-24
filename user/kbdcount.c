#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
  printf("%d\n", get_keystrokes_count());
  exit(0);
}
