---
title: System Call Numbering for Apple Silicon
date: 2024-12-27 11:33:00 +0800
categories: [ASM, Shellcode]
tags: [syscall, shellcode, Apple Silicon, ARM64]
pin: true
math: true
mermaid: true
image: 
---

Below is a commonly referenced set of Darwin (macOS) system call numbers relevant to spawning shells (via `fork/execve`) and creating bind/reverse shells (via socket, connect, bind, listen, accept, etc.) on Apple Silicon (ARM64). These are the “classic” BSD-style syscall numbers as defined in Apple’s XNU kernel for 64-bit processes.

---

> Important Note
{: .prompt-info }

- System call numbers can vary slightly across different macOS releases.
- Some syscalls have “cancel” or “nocancel” variants.
- In many cases, higher-level library functions (like posix_spawn) wrap these syscalls rather than calling them directly.
 • You can confirm the exact numbers on your system by looking at `/usr/include/sys/syscall.h` or running `man syscalls`.

## Common Syscalls for Fork/Exec and Networking

### Syscall Number Purpose

Below is the same table sorted by syscall number in ascending order:

| Syscall | Number | Prototype | Purpose |
|---------|---------|-----------|----------|
| fork | 2 | `pid_t fork(void);` | Create a new process (the classic BSD fork). |
| accept | 30 | `int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);` | Accept a connection on a listening socket (used in bind shells). |
| execve | 59 | `int execve(const char *pathname, char *const argv[], char *const envp[]);` | Execute a new program (replaces the current process image). |
| dup2 | 90 | `int dup2(int oldfd, int newfd);` | Duplicate a file descriptor (often used to route stdin/stdout/stderr in shells). |
| socket | 97 | `int socket(int domain, int type, int protocol);` | Create a socket (e.g., for TCP/UDP). |
| connect | 98 | `int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);` | Connect a socket to a remote address (used in reverse shells). |
| bind | 104 | `int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);` | Bind a socket to a local address/port. |
| listen | 106 | `int listen(int sockfd, int backlog);` | Mark a bound socket as passive (listen for incoming connections). |

> Note: macOS supports multiple classes of system calls, not just `BSD`. These classes are
defined in the `xnu-7195.50.7.100.1/osfmk/mach/i386/syscall_sw.h` file.

### Reverse Shell

 1. socket(AF_INET, SOCK_STREAM, 0) → syscall #97
 2. connect(sock, &server_addr, ...) → syscall #98
 3. dup2(sock, STDIN_FILENO) → syscall #90
 4. dup2(sock, STDOUT_FILENO) → syscall #90
 5. dup2(sock, STDERR_FILENO) → syscall #90
 6. execve("/bin/sh", ...) → syscall #59

### Bind Shell

 1. socket(AF_INET, SOCK_STREAM, 0) → syscall #97
 2. bind(sock, &local_addr, ...) → syscall #104
 3. listen(sock, 1) → syscall #106
 4. accept(sock, NULL, NULL) → syscall #30
 5. dup2(new_sock, STDIN_FILENO) → syscall #90
 6. dup2(new_sock, STDOUT_FILENO) → syscall #90
 7. dup2(new_sock, STDERR_FILENO) → syscall #90
 8. execve("/bin/sh", ...) → syscall #59

 • Spawning a Shell (locally)
 9. fork() → syscall #2
 10. If child: execve("/bin/sh", ...) → syscall #59

### Porting x86_64 macOS Assembly to ARM64

 Below is a minimal example showing how you might port that simple “write ‘hi’ to stdout, then exit” x86_64 macOS assembly snippet to ARM64 on macOS. The biggest differences are:

 1. Register Usage (ARM64 uses x0–x7 for arguments, x16 for the syscall number).
 2. System Call Mechanism (ARM64 macOS uses svc #0 instead of syscall).
 3. Assembler Directives (NASM doesn’t target ARM64 on macOS; typically you’ll use Clang/LLVM’s integrated assembler or GAS).

Below is an example using Clang’s inline assembly style (or GAS syntax). This should work on Apple Silicon when compiled with the right flags (e.g., -target arm64-apple-macos if cross-compiling).

 Important: The exact syscall numbers on macOS ARM64 can vary; the numbers 0x2000004 (write) and 0x2000001 (exit) are consistent with the traditional macOS offsets from x86_64, but you should verify them against your local headers (e.g., /usr/include/sys/syscall.h).

#### Example ARM64 Assembly for macOS

```c

.section __TEXT,__text
.align 2
.global _start

_start:
    // ===== write(1, "hi", 2) =====
    mov     x16, #0x2000004     // System call number for 'write' on macOS (ARM64)
    mov     x0, #1              // file descriptor: stdout
    adrp    x1, msg             // get address of "hi" (high part)
    add     x1, x1, :lo12:msg   // add low part of address
    mov     x2, #2              // length of the string
    svc     #0                  // trigger the system call

    // ===== exit(0) =====
    mov     x16, #0x2000001     // System call number for 'exit' on macOS (ARM64)
    mov     x0, #0              // exit status code
    svc     #0                  // trigger the system call

.data
msg:
    .ascii "hi"
```

#### Explanation

 1. `.section __TEXT,__text / .data:`
 • On Mach-O systems, code typically resides in the __TEXT,__text section; data in __DATA or (here) .data.
 2. `mov x16, #0x2000004:`
 • On macOS, the syscall number for write (with the 0x2000000 offset) is used here.
 • You place the syscall number in x16 for ARM64 Darwin.
 3. x0, x1, x2:
 • On AArch64 macOS, function (and syscall) arguments go in x0 through x7.
 • For write(fd, buf, len):
 • x0 = file descriptor (1 = stdout)
 • x1 = pointer to the buffer (“hi”)
 • x2 = length of the buffer
 4. adrp x1, msg + add x1, x1, :lo12:msg:
 • Loads the 64-bit address of msg in a position-independent way (split into “page” + “page offset”).
 5. svc #0:
 • Executes the system call on ARM64 (the equivalent of syscall on x86_64).
 6. `mov x16, #0x2000001:`
 • Syscall number for exit on macOS.
 7. `_start:`
 • Defines the entry point if you’re linking this as a standalone executable.
 • Alternatively, you could define `_main` if you’re linking against a C runtime that calls `_main`.

#### Compiling and Running on Apple Silicon

 1. Save the above code to a file, e.g. shellcode_arm64.s.
 2. Assemble and Link (using Clang on Apple Silicon):

    ```bash
    clang -o shellcode_arm64 shellcode_arm64.s
    ```

This produces a Mach-O executable named shellcode_arm64.

3. Run:

```bash
./shellcode_arm64
```

It should print hi (without a newline) and then exit.

#### Verifying Syscall Numbers

 • macOS (Apple Silicon) uses similar syscall numbering to x86_64 but invoked via x16/svc #0 rather than rax/syscall.
 • Check your local headers:

```bash
grep -i 'SYS_write' /usr/include/sys/syscall.h
grep -i 'SYS_exit' /usr/include/sys/syscall.h
```

or browse the open-source XNU headers at opensource.apple.com.

If the numbers differ, adjust mov x16, #0x2000004 (and #0x2000001) accordingly.

 • Replace `mov rax, 0x2000004 ; syscall (x86_64 style)` with `mov x16, #0x2000004 ; svc #0 (ARM64 style)`.
 • Move arguments into x0, x1, x2 (instead of rdi, rsi, rdx, etc.).
 • Use adrp + add (or adr) instructions to load addresses in a position-independent manner.
 • Confirm the syscall numbers in the local environment for 64-bit ARM macOS.

## Where to Confirm or Learn More

 1. `/usr/include/sys/syscall.h`: On macOS, this header enumerates all system call constants.

 2. `man syscalls`: Lists syscalls, their prototypes, and numbers.

 3. `XNU Source Code (Apple Open Source)`: Browse or clone Apple’s XNU kernel from `opensource.apple.com` to see the latest definitions for your version of macOS.

These syscalls form the low-level building blocks for shellcode on Apple Silicon. Higher-level library calls (like `system()`, `posix_spawn()`, or the BSD/POSIX wrappers in `libc`) ultimately rely on them.
