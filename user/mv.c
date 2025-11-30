#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"

// mkdir a; mkdir b; touch a/a_file.txt
int MAX_PATH_LEN = 700;
int moveStuff(char *, char *, int);
int DEBUG = 1;

int main(int argc, char *argv[])
{
  if (argc != 3)
  {
    fprintf(2, "mv: Incorrect usage, mv src dst\n");
    exit(1);
  }

  int statusCode = moveStuff(argv[1], argv[2], 1);
  if (statusCode < 0)
  {
    fprintf(2, "Command failed\n");
  }
  exit(statusCode);
}

int moveStuff(char *src, char *dst, int shouldDelete)
{
  printf("called\n");
  if (shouldDelete >= 10)
  {
    printf("termination time\n");
    return 0;
  }
  int is_src_dir = isdir(src);
  // int is_dst_dir = isdir(dst);

  char *dst_path = malloc(MAX_PATH_LEN);
  strcpy(dst_path, dst);
  char *filename = getFilename(src);

  // Dir to dir
  if (is_src_dir)
  {
    // Create destination path: dst/dirname
    char *new_dst = malloc(MAX_PATH_LEN);
    joinpath(dst, filename, new_dst, MAX_PATH_LEN);

    // Create the destination directory
    if (mkdir(new_dst) < 0)
    {
      fprintf(2, "mv: mkdir failed\n");
      return -1;
    }

    if (DEBUG)
      printf("1 made directory at %s\n", new_dst);

    // Open source directory to read its contents
    int fd = open(src, O_RDONLY);
    if (fd < 0)
    {
      fprintf(2, "mv: open source directory failed\n");
      unlink(new_dst); // Cleanup created directory
      return -1;
    }

    if (DEBUG)
      printf("2, opened %s to read content\n", src);

    // Read each directory
    struct dirent de;
    while (read(fd, &de, sizeof(de)) == sizeof(de))
    {
      if (de.inum == 0)
        continue; // Skip empty entries
      if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
        continue; // Skip special entries

      char *item_src = malloc(MAX_PATH_LEN);
      joinpath(src, de.name, item_src, MAX_PATH_LEN);
      if (DEBUG)
        printf("3. item src: %s, item dst: %s, shouldDelete: %d\n", item_src, new_dst, shouldDelete);

      // Recursive call
      if (moveStuff(item_src, new_dst, shouldDelete) < 0)
      {
        close(fd);
        unlink(new_dst); // Cleanup on failure

        if (DEBUG)
          printf("Welp that call failed\n");

        free(item_src);
        free(dst_path);
        return -1;
      }
      free(item_src);
      printf("4\n");
    }
    close(fd);

    if (shouldDelete && unlink(src) < 0)
    {
      fprintf(2, "mv: unlink source directory failed\n");
      return -1;
    }

    printf("5. this Subcall done succesfully\n");
    free(dst_path);
    return 0;
  }

  joinpath(dst, filename, dst_path, MAX_PATH_LEN);
  if (link(src, dst_path) < 0)
  {
    fprintf(2, "mv: link src %s to dst %s failed\n", src, dst_path);
    free(dst_path);
    return -1;
  }
  printf("done linking %s to %s\n", src, dst_path);

  if (shouldDelete)
  {
    if (unlink(src) < 0)
    {
      fprintf(2, "mv: unlink %s failed\n", src);
      if (unlink(dst_path) < 0)
        fprintf(2, "mv: rollback failed for %s\n", dst_path);

      free(dst_path);
      return -1;
    }
  }

  free(dst_path);
  return 0;
}
