---
title: Understanding the Basic Syntax of Assembly Language
date: 2022-11-02 1:33:00 +0800
categories: [Blogging, Document]
tags: [Asm, nasm, OSMR]
pin: false 
math: true
mermaid: true
image: 
  path: asm-basic.png
  alt: basic asm
---

Assembly language is a low-level programming language that provides direct control over the computer's hardware. In this blog post, we will explore the basic syntax of assembly language using a simple program that prints "Hello, world!" to the console.

```c
section .bss     ; uninitialized data variables

section .text    ; code

global _main     ; must be declared for linker (ld)

_main:           ; tells linker entry point
    mov edx, len ; message length
    mov ecx, msg ; message to write
    mov ebx, 1   ; file descriptor (stdout)
    mov eax, 4   ; system call number (sys_write)
    int 0x80     ; call kernel

    mov eax, 1   ; system call number (sys_exit)
    xor ebx, ebx ; exit status 0
    int 0x80     ; call kernel

section .data               ; initialized data
msg db 'Hello, world!', 0xa ; string to be printed
len equ $-msg               ; length of the string
```

Let's break down the different sections and instructions used in this program:

## Sections

Assembly programs are typically organized into different sections. In this program, we have three sections: `.bss`, `.text`, and `.data`.

- The `.bss` section is used for declaring uninitialized data variables.
- The `.text` section contains the executable code.
- The `.data` section is used for declaring initialized data variables.

## Entry Point

The `_main:` or `_start:` label denotes the entry point of the program. It is the first instruction executed when the program is run.

## Instructions

- `mov` instructions are used to move data between registers and memory. For example, `mov edx, len` moves the length of the message to the `edx` register.
- `int 0x80` is a software interrupt instruction that triggers a system call to the kernel. The value `0x80` indicates the system call interface for the Linux operating system.
- `eax` register holds the system call number. In this program, `eax` is set to `4` for `sys_write` (write to console) and `1` for `sys_exit` (program exit).
- `len equ $ - msg` <u>calculates the length of the string by subtracting the memory address of `msg` from the current memory address (`$` symbol)</u>.

## String and Printing

The `msg` variable holds the string "Hello, world!" terminated with a newline character (`0xa`). This string is printed to the console using the `sys_write` system call.

## Program Termination

After printing the message, the program exits using the `sys_exit` system call.

## Build and run the `asm` programs

`Nasm` is one of the most popular assembly language compilers, it is widely used for various platforms and architectures. In the following steps, we will install `NASM` on `macOS` using Homebrew, a popular package manager for macOS. And on Debian-based `Linux` systems, using the default package manager, `apt`.

### Install nasm on MacOS

1. Open the Terminal application on your macOS system. You can find it in the “Utilities” folder within the “Applications” directory.

2. Install Homebrew by running the following command in the Terminal:

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. Once Homebrew is installed, you can use it to install NASM. Run the following command in the Terminal:

   ```bash
   brew install nasm
   ```

### Install nasm on Debian-based systems

To install NASM on a Debian-based system, you can follow these steps:

1. Open a terminal.

2. Update the package lists by running the following command:

   ```bash
   sudo apt update
   ```

3. Install NASM using the package manager `apt` with the following command:

   ```bash
   sudo apt install nasm
   ```

Wait for the installation to complete. NASM and its dependencies will be downloaded and installed on your system. You can verify the installation by running the following command to check the version:

   ```bash
   nasm --version
   ```

You should see the version information for NASM displayed in the Terminal, confirming that NASM is successfully installed on your system.

To build and run an assembly program using NASM, follow these steps:

1. Save our assembly source file with the extension `.asm`, for example, `program.asm`.

2. Run the following command to compile the source code:

   ```bash
   nasm -f elf64 program.asm -o program.o
   ```

   This command assembles the assembly source code into an object file (`program.o`). Adjust the `-f` option according to your target architecture (e.g., `elf32` for 32-bit).

3. Link the object file using a suitable linker, such as `ld` or `GCC` (GNU Compiler Collection). Run the following command:

   ```bash
   gcc program.o -o program
   ```

   This command links the object file and generates an executable file called `program`. You can replace `gcc` with the appropriate linker if needed.

4. Run the program by executing the following command:

   ```bash
   ./program
   ```

   This command executes the assembled and linked program, printing "Hello world!" to the console.

## Conclusion

Understanding the basic syntax of assembly language allows you to gain a deeper insight into how programs interact with the underlying hardware. Although assembly can be complex, it offers unparalleled control and optimization possibilities.

Keep exploring and experimenting with assembly to expand your programming horizons.
