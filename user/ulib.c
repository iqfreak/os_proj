#include "kernel/fcntl.h"
#include "kernel/fs.h"
#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

//
// wrapper so that it's OK if main() does not call exit().
//
void start() {
    extern int main();
    main();
    exit(0);
}

char *
strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
        ;
    return os;
}

int strcmp(const char *p, const char *q) {
    while (*p && *p == *q)
        p++, q++;
    return (uchar)*p - (uchar)*q;
}

int strncmp(const char *p, const char *q, int len) {
    if (len <= 0)
        return 0;

    const unsigned char *a = (const unsigned char *)p;
    const unsigned char *b = (const unsigned char *)q;

    while (len-- > 0) {
        if (*a != *b)
            return (int)(*a) - (int)(*b);
        if (*a == '\0')
            return 0;
        a++;
        b++;
    }
    return 0;
}

uint strlen(const char *s) {
    int n;

    for (n = 0; s[n]; n++)
        ;
    return n;
}

void *
memset(void *dst, int c, uint n) {
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++) {
        cdst[i] = c;
    }
    return dst;
}

char *
strchr(const char *s, char c) {
    for (; *s; s++)
        if (*s == c)
            return (char *)s;
    return 0;
}

char *
gets(char *buf, int max) {
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
            break;
    }
    buf[i] = '\0';
    return buf;
}

int stat(const char *n, struct stat *st) {
    int fd;
    int r;

    fd = open(n, O_RDONLY);
    if (fd < 0)
        return -1;
    r = fstat(fd, st);
    close(fd);
    return r;
}

int atoi(const char *s) {
    int n;
    if (*s == '-')
        return -atoi(s + 1);

    n = 0;
    while ('0' <= *s && *s <= '9')
        n = n * 10 + *s++ - '0';
    return n;
}

void *
memmove(void *vdst, const void *vsrc, int n) {
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
        while (n-- > 0)
            *dst++ = *src++;
    } else {
        dst += n;
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}

int memcmp(const void *s1, const void *s2, uint n) {
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0) {
        if (*p1 != *p2) {
            return *p1 - *p2;
        }
        p1++;
        p2++;
    }
    return 0;
}

void *
memcpy(void *dst, const void *src, uint n) {
    return memmove(dst, src, n);
}

char *strcat(char *dst, const char *src) {
    char *p = dst;

    while (*p)
        p++;

    // copy src into dst starting at the end
    while (*src) {
        *p = *src;
        p++;
        src++;
    }

    *p = 0;

    return dst;
}

int isdir(char *path) {
    struct stat st;
    if (stat(path, &st) < 0)
        return 0;
    return st.type == T_DIR;
}

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize) {
    int dn = strlen(dir);
    int nn = strlen(filename);
    int need = dn + 1 + nn + 1;
    if (need > bufsize)
        return 0;
    strcpy(out_buffer, dir);
    if (dir[dn - 1] != '/') {
        out_buffer[dn] = '/';
        out_buffer[dn + 1] = 0;
    }
    strcat(out_buffer, filename);
    return out_buffer;
}

char *getFilename(char *path) {
    char *dirname = path;
    for (char *p = path; *p; p++) {
        if (*p == '/')
            dirname = p + 1;
    }
    return dirname;
}

int find_opt(struct opt *opts, int nopts, char ch) {
    for (int i = 0; i < nopts; ++i)
        if (opts[i].opt == ch)
            return i;
    return -1;
}

/* parse non-empty decimal integer s; return -1 on error, else value >=0 */
int parse_nonneg_int(const char *s) {
    if (!s || *s == '\0')
        return -1;
    int v = 0;
    for (const char *p = s; *p; ++p) {
        if (*p < '0' || *p > '9')
            return -1;
        v = v * 10 + (*p - '0');
    }
    return v;
}

/*
  Parser rules:
  - supports combined short flags like -abc
  - if an option requires an arg (has_arg==1):
      - attached form: -n5  (rest of same argv)
      - separate form: -n 5 (next argv must exist and must NOT start with '-')
  - "--" stops option parsing, rest are files
  - single "-" is treated as a file (stdin)
  - unknown option -> error
  - returns new argc (>=1) or -1 on parse error
*/
int parse_flags(int argc, char **argv, struct opt *opts, int nopts) {
    // init seen/arg
    for (int k = 0; k < nopts; ++k) {
        opts[k].seen = 0;
        opts[k].arg = 0;
    }

    int write_i = 1; // next write position for non-option args
    for (int i = 1; i < argc; ++i) {
        char *a = argv[i];
        if (a[0] == '\0')
            continue; // skip weird empty
        if (a[0] != '-' || a[1] == '\0') {
            // normal filename or "-" (stdin)
            argv[write_i++] = a;
            continue;
        }
        if (a[1] == '-' && a[2] == '\0') {
            // "--" : copy remaining as files and stop parsing
            for (int j = i + 1; j < argc; ++j)
                argv[write_i++] = argv[j];
            break;
        }

        // Option cluster: -abc or -n5 or -n
        int len = 0;
        while (a[len])
            ++len;
        for (int j = 1; j < len; ++j) {
            char ch = a[j];
            int idx = find_opt(opts, nopts, ch);
            if (idx < 0)
                return -1; // unknown option

            if (opts[idx].has_arg) {
                // rest of this argv is the arg (if any)
                if (j + 1 < len) {
                    opts[idx].seen = 1;
                    opts[idx].arg = &a[j + 1]; // attached part
                    break;                     // finished with this argv
                }
                // else try next argv for the arg
                if (i + 1 >= argc)
                    return -1; // missing arg
                if (argv[i + 1][0] == '-')
                    return -1; // don't accept next flag as arg
                opts[idx].seen = 1;
                opts[idx].arg = argv[i + 1];
                i++;   // consume next argv
                break; // done with this argv
            } else {
                // flag with no arg
                opts[idx].seen = 1;
                // continue to next char in the cluster (e.g. -nf where f is next)
                continue;
            }
        }
    }
    // null-terminate remaining argv chunk
    argv[write_i] = 0;
    for (int j = write_i; j < argc; ++j)
        argv[j] = 0;

    return write_i; // new argc
}

// opts_with_arg is a NUL-terminated string of option letters that need an argument, e.g. "n".
// Returns new argc (>=1) on success, or -1 on error (missing arg).
int contains_char(const char *s, char c) {
    if (!s)
        return 0;
    for (; *s; ++s)
        if (*s == c)
            return 1;
    return 0;
}

/*
  Rules:
   - Preserves argv[0] (program name).
   - Treats single "-" as a filename (kept).
   - "--" stops option parsing and copies remaining args as files.
   - Removes option tokens like "-f" or clusters "-abc".
   - If an option requires an arg (in opts_with_arg), handles both "-n5" and "-n 5".
*/
int strip_flags(int argc, char **argv, const char *opts_with_arg) {
    int write_i = 1; // where to write non-option args
    for (int i = 1; i < argc; ++i) {
        char *a = argv[i];
        if (!a || a[0] == '\0')
            continue;

        // not an option or single "-" => keep
        if (a[0] != '-' || a[1] == '\0') {
            argv[write_i++] = a;
            continue;
        }

        // "--" : copy remaining args as files and break
        if (a[1] == '-' && a[2] == '\0') {
            for (int j = i + 1; j < argc; ++j)
                argv[write_i++] = argv[j];
            break;
        }

        // Option cluster: parse characters after '-'
        int len = 0;
        while (a[len])
            ++len;
        int consumed_next = 0;
        for (int j = 1; j < len; ++j) {
            char ch = a[j];
            if (contains_char(opts_with_arg, ch)) {
                // option requires argument
                if (j + 1 < len) {
                    // attached form: -nVALUE  -> rest of this token is the arg
                    // we just remove this token entirely (don't copy it)
                } else {
                    // separate form: -n VALUE -> must consume next argv as arg
                    if (i + 1 >= argc)
                        return -1; // missing arg
                    // skip next token (the arg)
                    i++;
                    consumed_next = 1;
                }
                // after handling an option that takes arg, stop scanning this token
                break;
            } else {
                // no-arg flag; we just mark it seen by removing the token
                continue;
            }
        }
        // token (and possibly its arg) removed — do not copy 'a'
        (void)consumed_next; // silence unused if needed
    }

    argv[write_i] = 0; // optional null terminator for convenience
    return write_i;
}
