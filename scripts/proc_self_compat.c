/* Optional compatibility for containers exposing /proc/self/exe but not
 * /proc/<own-pid>/exe. Translate only the current process's executable link.
 * No Lean code, kernel, proof object, or other filesystem path is modified. */
#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

ssize_t readlink(const char *path, char *buffer, size_t length) {
    static ssize_t (*actual)(const char *, char *, size_t) = 0;
    if (!actual) actual = dlsym(RTLD_NEXT, "readlink");
    char own[80];
    snprintf(own, sizeof own, "/proc/%ld/exe", (long)getpid());
    return actual(strcmp(path, own) == 0 ? "/proc/self/exe" : path,
                  buffer, length);
}
