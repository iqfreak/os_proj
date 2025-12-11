#include "defs.h"
#include "memlayout.h"
#include "param.h"
#include "proc.h"
#include "riscv.h"
#include "types.h"

// Constants for hardware timer
#define EGYPT_TZ_OFFSET (2 * 3600)
#define CLINT_BASE 0x0200c000L
#define CLINT_MTIME 0x0200bff8L
#define TIMER_FREQ 10000000 // 10 MHz

int is_leap(int year) {
    return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
}

void get_datetime(struct rtcdate *d) {
    int days_in_month[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    volatile uint64 *mtime = (uint64 *)CLINT_MTIME;
    uint64 secs = *mtime / TIMER_FREQ + BOOT_EPOCH;
    secs += EGYPT_TZ_OFFSET;

    d->second = secs % 60;
    secs /= 60;
    d->minute = secs % 60;
    secs /= 60;
    d->hour = secs % 24;
    int days = secs / 24;

    // year
    d->year = 1970;
    while (1) {
        int days_in_year = is_leap(d->year) ? 366 : 365;
        if (days < days_in_year)
            break;

        days -= days_in_year;
        d->year++;
    }

    // days
    d->month = 1;
    if (is_leap(d->year)) {
        days_in_month[2] = 29;
    }

    while (days >= days_in_month[d->month]) {
        days -= days_in_month[d->month];
        d->month++;
    }

    d->day = days + 1;

    return;
}
