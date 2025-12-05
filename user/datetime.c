#include "kernel/types.h"
#include "user/user.h"

int main() {
    struct rtcdate d;
    if(datetime(&d) < 0){
        printf("datetime syscall failed\n");
        exit(1);
    }
    printf("Current time: %d-%d-%d %d:%d:%d\n",
           d.year, d.month, d.day,
           d.hour, d.minute, d.second);
    exit(0);
}
