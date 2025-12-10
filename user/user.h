#pragma once
#include "kernel/proc.h"

struct stat;

struct opt {
    char opt;    // short option char, e.g. 'n' or 'f'
    int has_arg; // 0 = flag, 1 = option requires argument
    int seen;    // set to 1 by parser if option appeared
    char *arg;   // pointer to option argument (NULL if none)
};

struct pinfo {
    int pid;
    int ppid;
    int state;
    char name[16];
    uint64 sz;
};

// system calls
int fork(void);
int exit(int) __attribute__((noreturn));
int wait(int *);
int pipe(int *);
int write(int, const void *, int);
int read(int, void *, int);
int close(int);
int kill(int);
int exec(const char *, char **);
int open(const char *, int);
int mknod(const char *, short, short);
int unlink(const char *);
int fstat(int fd, struct stat *);
int link(const char *, const char *);
int mkdir(const char *);
int chdir(const char *);
int dup(int);
int getpid(void);
char *sbrk(int);
int sleep(int);
int uptime(void);
int get_keystrokes_count(void);
int shutdown(void);
int countsyscall(void);
int getptable(struct pinfo *);
int get_proc_time(int pid, struct proc_time *pt);
int set_priority(int pid, int priority);
int getppid(void);
int randd(void);

int datetime(struct rtcdate *d);

// ulib.c
int stat(const char *, struct stat *);
char *strcpy(char *, const char *);
void *memmove(void *, const void *, int);
char *strchr(const char *, char c);
int strcmp(const char *, const char *);
int strncmp(const char *, const char *, int);
void fprintf(int, const char *, ...) __attribute__((format(printf, 2, 3)));
void printf(const char *, ...) __attribute__((format(printf, 1, 2)));
char *gets(char *, int max);
uint strlen(const char *);
void *memset(void *, int, uint);
int atoi(const char *);
int memcmp(const void *, const void *, uint);
void *memcpy(void *, const void *, uint);

char *strcat(char *, const char *);
int isdir(char *);
int is_valid_int(char *);
char *joinpath(char *, char *, char *, int);
char *getFilename(char *path);

// umalloc.c
void *malloc(uint);
void free(void *);

// utils.c
int move(char *src, char *dst, int shouldDelete);
int moveDir(char *src, char *dst, int shouldDelete);
int moveFile(char *src, char *dst, int shouldDelete);

int parse_flags(int argc, char **argv, struct opt *opts, int nopts);
int parse_nonneg_int(const char *s); // helper to convert option args
int strip_flags(int argc, char **argv, const char *opts_with_arg);
