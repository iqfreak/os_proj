#include "kernel/fs.h"
#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
    struct rtcdate d;

    if (datetime(&d) == 0) {
        printf("Date: %d-%d-%d\n", d.year, d.month, d.day);
        printf("Time: %d:%d:%d\n", d.hour, d.minute, d.second);
    } else {
        printf("datetime failed\n");
    }

    return 0;
}
