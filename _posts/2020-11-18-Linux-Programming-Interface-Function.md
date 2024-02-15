---
title: Linux Programming Interface Cheat Sheet 
date: 2020-11-18 11:33:00 +0800
categories: [Blogging, Doc]
tags: [Linux, Api, Cli]
pin: false
math: true
mermaid: true
---


## Introduction

This cheat sheet provides a comprehensive list of commonly used functions in the Linux programming interface. These functions are essential for interacting with the operating system, managing processes, files, memory, network communication, and performing various system-related tasks.

Table of contents

- [Introduction](#introduction)
- [Process Control Functions](#process-control-functions)
- [File and I/O Functions](#file-and-io-functions)
- [Memory Management Functions](#memory-management-functions)
- [Process Scheduling Functions](#process-scheduling-functions)
- [Signal Handling Functions](#signal-handling-functions)
- [Interprocess Communication Functions](#interprocess-communication-functions)
- [File System Functions](#file-system-functions)
- [Network Programming Functions](#network-programming-functions)

## Process Control Functions

- `fork()`: Create a new process by duplicating the existing process.
- `exec()` family: Replace the current process image with a new program.
- `wait()` and `waitpid()`: Suspend the calling process until one of its child processes exits.
- `exit()`: Terminate the calling process and return the exit status.
- `getpid()`: Get the process ID of the calling process.
- `getppid()`: Get the parent process ID of the calling process.
- `signal()`: Set a signal handler for a specific signal.
- `kill()`: Send a signal to a process or a group of processes.
- `nice()`: Modify the priority of a process.

## File and I/O Functions

- `open()`: Open a file or create one if it does not exist.
- `read()` and `write()`: Read from or write to a file descriptor.
- `close()`: Close a file descriptor.
- `lseek()`: Change the file offset within a file.
- `dup()` and `dup2()`: Duplicate a file descriptor.
- `pipe()`: Create a pipe for interprocess communication.
- `fopen()`, `fclose()`, `fread()`, and `fwrite()`: File operations using `FILE` streams.
- `fgets()`, `fputs()`, and `fprintf()`: Read from or write to a `FILE` stream.
- `stat()`, `fstat()`, and `lstat()`: Retrieve file status information.
- `mkdir()`: Create a new directory.
- `rmdir()`: Remove an empty directory.
- `chdir()`: Change the current working directory.

## Memory Management Functions

- `malloc()`, `calloc()`, `realloc()`, and `free()`: Dynamic memory allocation and deallocation.
- `mmap()`, `munmap()`, and `msync()`: Map files or devices into memory.
- `brk()` and `sbrk()`: Change the program break, modifying the heap's memory space.

## Process Scheduling Functions

- `sleep()`: Suspend the execution of the calling process for a specified number of seconds.
- `usleep()`: Suspend the execution of the calling process for a specified number of microseconds.
- `sched_yield()`: Yield the processor to another thread or process.
- `setpriority()`: Set the scheduling priority of a process.
- `nice()`: Modify the priority of a process.

## Signal Handling Functions

- `signal()`: Set a signal handler for a specific signal.
- `sigaction()`: Set a signal handler with extended capabilities.
- `kill()`: Send a signal to a process or a group of processes.
- `sigprocmask()`: Change the signal mask for the calling process.

## Interprocess Communication Functions

- `pipe()`: Create a pipe for communication between two related processes.
- `shmget()`, `shmat()`, and `shmdt()`: Create or attach to a shared memory segment.
- `msgget()`, `msgsnd()`, and `msgrcv()`: Create or send/receive messages to/from a message queue.
- `semget()`, `semop()`, and `semctl()`: Create or operate on a semaphore.
- `socket()`: Create an endpoint for communication.
- `bind()`: Assign a local address to a socket.
- `

listen()`: Mark a socket as a passive socket, ready to accept connections.

- `accept()`: Accept a connection on a socket.
- `connect()`: Establish a connection to a remote host.
- `send()` and `recv()`: Send or receive data on a socket.
- `getaddrinfo()` and `freeaddrinfo()`: Convert hostnames and service names to socket addresses.

## File System Functions

- `opendir()`, `readdir()`, and `closedir()`: Open, read, and close a directory.
- `scandir()`: Scan a directory for files matching a specific criterion.
- `chown()`: Change the owner and group of a file.
- `chmod()`: Change the permissions of a file.
- `rename()`: Rename a file.
- `remove()`: Delete a file.
- `link()` and `unlink()`: Create or remove a hard link to a file.
- `symlink()` and `readlink()`: Create or read the value of a symbolic link.
- `utime()`: Change the access and modification times of a file.
- `realpath()`: Resolve the absolute path of a file.

## Network Programming Functions

- `gethostbyname()` and `gethostbyaddr()`: Retrieve host information by name or address.
- `getaddrinfo()` and `freeaddrinfo()`: Convert hostnames and service names to socket addresses.
- `socket()`: Create an endpoint for communication.
- `bind()`: Assign a local address to a socket.
- `listen()`: Mark a socket as a passive socket, ready to accept connections.
- `accept()`: Accept a connection on a socket.
- `connect()`: Establish a connection to a remote host.
- `send()` and `recv()`: Send or receive data on a socket.
- `select()`: Monitor multiple file descriptors for readiness.
- `setsockopt()` and `getsockopt()`: Set or retrieve options on a socket.

These are just some of the many functions available in the Linux programming interface. Each function provides specific functionality for interacting with different aspects of the operating system and building robust Linux applications.

> Please refer to the relevant man pages and official documentation for detailed usage and additional functions available in the Linux programming interface.
{: .prompt-info }
