#include "user.h"

void test_basic_syscalls(void) {
    printf("Testing basic system calls...\n");
    int pid = getpid();
    printf("Current PID: %d\n", pid);

    int child_pid = fork();
    if (child_pid == 0) {
        printf("Child process: PID=%d\n", getpid());
        exit(42);
    } else if (child_pid > 0) {
        int status = 0;
        wait(&status);
        printf("Child exited with status: %d\n", status);
    } else {
        printf("Fork failed!\n");
    }
}

int main(void) {
    test_basic_syscalls();
    return 0;
}
