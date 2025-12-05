#ifndef __ASSEMBLER__

#pragma once

typedef unsigned int uint;
typedef unsigned short ushort;
typedef unsigned char uchar;

typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned int uint32;
typedef unsigned long uint64;

struct rtcdate {
    int year;
    int month;
    int day;
    int hour;
    int minute;
    int second;
};


typedef uint64 pde_t;
#endif /* __ASSEMBLER__ */
