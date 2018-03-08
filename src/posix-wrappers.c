#include <stdio.h>
#include <errno.h>
#include <sys/stat.h>

int posix_wrap_stat(const char *filename, struct stat *buf) {
  return stat(filename, buf);
}
