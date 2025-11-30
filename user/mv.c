#include "kernel/fcntl.h"
#include "kernel/fs.h"
#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

// mkdir a; mkdir b; touch a/a_file.txt
int MAX_PATH_LEN = 700;
int DEBUG = 1;

int moveStuff(char *src, char *dst, int shouldDelete);
int moveDir(char *src, char *dst, int shouldDelete);
int moveFile(char *src, char *dst, int shouldDelete);

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(2, "mv: Incorrect usage, mv src dst\n");
        exit(1);
    }

    int statusCode = moveStuff(argv[1], argv[2], 1);
    if (statusCode < 0) {
        fprintf(2, "Command failed\n");
    }
    exit(statusCode);
}

int moveStuff(char *src, char *dst, int shouldDelete) {
    if (!isdir(dst)) {
        printf("mv: dst must be a directory");
        return -1;
    }

    else if (isdir(src)) {
        return moveDir(src, dst, shouldDelete);
    } else {
        return moveFile(src, dst, shouldDelete);
    }
}

int moveDir(char *src, char *dst, int shouldDelete) {
    // Create destination path: dst/dirname
    char *filename = getFilename(src);
    char *new_dst = malloc(MAX_PATH_LEN);
    joinpath(dst, filename, new_dst, MAX_PATH_LEN);

    // Create the destination directory
    if (mkdir(new_dst) < 0) {
        fprintf(2, "mv: mkdir failed\n");
        return -1;
    }

    if (DEBUG)
        printf("1 made directory at %s\n", new_dst);

    // Open source directory to read its contents
    int fd = open(src, O_RDONLY);
    if (fd < 0) {
        fprintf(2, "mv: open source directory failed\n");
        unlink(new_dst); // Cleanup created directory
        return -1;
    }

    if (DEBUG)
        printf("2, opened %s to read content\n", src);

    // Read each directory
    struct dirent de;
    while (read(fd, &de, sizeof(de)) == sizeof(de)) {
        if (de.inum == 0)
            continue; // Skip empty entries
        if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
            continue; // Skip special entries

        char *item_src = malloc(MAX_PATH_LEN);
        joinpath(src, de.name, item_src, MAX_PATH_LEN);
        if (DEBUG)
            printf("3. item src: %s, item dst: %s, shouldDelete: %d\n", item_src, new_dst, shouldDelete);

        // Recursive call
        if (moveStuff(item_src, new_dst, shouldDelete) < 0) {
            close(fd);

            // Cleanup on failure
            unlink(new_dst);
            free(item_src);
            free(new_dst);

            if (DEBUG)
                printf("Welp that call failed\n");

            return -1;
        }
        free(item_src);
        free(new_dst);
    }
    close(fd);

    if (shouldDelete && unlink(src) < 0) {
        fprintf(2, "mv: unlink source directory failed\n");
        return -1;
    }

    printf("5. this Subcall done succesfully\n");
    return 0;
}

int moveFile(char *src, char *dst, int shouldDelete) {
    char *filename = getFilename(src);

    joinpath(dst, filename, dst, MAX_PATH_LEN);
    if (link(src, dst) < 0) {
        fprintf(2, "mv: link src %s to dst %s failed\n", src, dst);
        return -1;
    }
    printf("done linking %s to %s\n", src, dst);

    if (shouldDelete) {
        if (unlink(src) < 0) {
            fprintf(2, "mv: unlink %s failed\n", src);
            if (unlink(dst) < 0)
                fprintf(2, "mv: rollback failed for %s\n", dst);

            return -1;
        }
    }

    return 0;
}
