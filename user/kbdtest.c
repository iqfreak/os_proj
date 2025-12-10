#include "kernel/types.h"
#include "user/user.h"

int main(){
  printf("NUmber of keyboard interrupts: %d\n", kbdint());
  exit(0);
}
