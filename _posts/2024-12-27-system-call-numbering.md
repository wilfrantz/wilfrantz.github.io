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

| Syscall | Number | Purpose |
|---------|--------|---------|
| fork | 2 | Create a new process (the classic BSD fork) |
| accept | 30 | Accept a connection on a listening socket (used in bind shells) |
| execve | 59 | Execute a new program (replaces the current process image) |
| dup2 | 90 | Duplicate a file descriptor (used to route stdin/stdout/stderr) |
| socket | 97 | Create a socket (e.g., for TCP/UDP) |
| connect | 98 | Connect a socket to a remote address (used in reverse shells) |
| bind | 104 | Bind a socket to a local address/port |
| listen | 106 | Mark a bound socket as passive (listen for incoming connections) |

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

## Where to Confirm or Learn More

 1. `/usr/include/sys/syscall.h`: On macOS, this header enumerates all system call constants.

 2. `man syscalls`: Lists syscalls, their prototypes, and numbers.

 3. `XNU Source Code (Apple Open Source)`: Browse or clone Apple’s XNU kernel from `opensource.apple.com` to see the latest definitions for your version of macOS.

These syscalls form the low-level building blocks for shellcode on Apple Silicon. Higher-level library calls (like `system()`, `posix_spawn()`, or the BSD/POSIX wrappers in `libc`) ultimately rely on them.
