#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "proc.h"

struct rtcdate {
    int year;
    int month;
    int day;
    int hour;
    int minute;
    int second;
};

#define CLINT_MTIME 0x0200bff8L   // memory-mapped mtime register
#define TIMER_FREQ 10000000       // 10 MHz

// Simple function to convert UNIX timestamp to Y/M/D/H/M/S
void unix_to_rtc(uint64 t, struct rtcdate *d) {
    d->second = t % 60;
    t /= 60;
    d->minute = t % 60;
    t /= 60;
    d->hour = t % 24;
    t /= 24;

    // Simplified: ignore leap years, just approximate day count
    int days = t;
    d->year = 1970 + days / 365;
    d->month = 1 + (days % 365) / 30;
    d->day = 1 + (days % 365) % 30;
}

uint64
sys_datetime(void)
{
    struct rtcdate *d;
    if(argptr(0, (void*)&d, sizeof(*d)) < 0)
        return -1;

    volatile uint64 *mtime = (uint64*)CLINT_MTIME;
    uint64 ticks = *mtime;
    uint64 seconds_since_boot = ticks / TIMER_FREQ;
    uint64 unix_time = BOOT_EPOCH + seconds_since_boot;

    unix_to_rtc(unix_time, d);

    return 0;
}
