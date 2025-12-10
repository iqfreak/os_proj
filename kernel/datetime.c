#include "defs.h"
#include "memlayout.h"
#include "param.h"
#include "proc.h"
#include "riscv.h"
#include "types.h"

// Constants for hardware timer
#define CLINT_BASE 0x0200c000L
#define CLINT_MTIME 0x0200bff8L
#define TIMER_FREQ 10000000 // 10 MHz

void get_datetime(struct rtcdate *d) {
    volatile uint64 *mtime = (uint64 *)CLINT_MTIME;
    uint64 secs = *mtime / TIMER_FREQ + BOOT_EPOCH;
    d->second = secs % 60;
    d->minute = secs / 60 % 60;
    d->hour = secs / 60 / 60 % 24;
    uint64 days = secs / 60 / 60 / 24;

    uint64 year = 1970 + days / 365;
    uint64 month = 1 + (days % 365) / 30;
    d->year = year;
    d->month = month;
    d->day = 1 + (days % 365) % 30;

    return;
}
