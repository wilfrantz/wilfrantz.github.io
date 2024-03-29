---
title: Mastering MacOS Shellcodes - Techniques, Resources, and Examples [Draft]
date: 2022-11-07 11:33:00 +0800
categories: [Blogging, Doc]
tags: [MacOS, Assembly, Shellcode, C]
pin: false 
math: true
mermaid: true
image: 
  path: macos-researcher.png
  alt: custom shellcode 
---


> ⚠️ **This document is still a draft. Please note that there might be mistakes or inaccuracies.**
{: .prompt-warning }

## Introduction

This document serves as a valuable resource for the Offsec[^footnote]'s `OSMR: EXP-312 MacOS Control Bypass` course. It offers a wide range of techniques, examples, and valuable resources to elevate MacOS Shellcode development.

[Shellcode](https://en.wikipedia.org/wiki/Shellcode){:target="_blank"} is a crucial element in the field of cybersecurity, enabling attackers to execute malicious actions on targeted systems. This technical document provides comprehensive insights into mastering shellcodes, covering various techniques and offering practical examples.

Table of contents

- [Introduction](#introduction)
- [Shellcode Overview](#shellcode-overview)
- [Advantages of Writing Custom Shellcode](#advantages-of-writing-custom-shellcode)
- [Choosing Between `Assembly` and `C`](#choosing-between-assembly-and-c)
  - [Writing Pure Assembly Shellcode](#writing-pure-assembly-shellcode)
    - [Calling Conventions and Registers](#calling-conventions-and-registers)
    - [System Call Numbering](#system-call-numbering)
    - [Working with BSD Type System Calls](#working-with-bsd-type-system-calls)
  - [Writing Shellcode in C](#writing-shellcode-in-c)
- [Executing Arbitrary Commands](#executing-arbitrary-commands)
- [Creating a Bind Shell](#creating-a-bind-shell)
- [Using `C` Code to Call Arbitrary Functions](#using-c-code-to-call-arbitrary-functions)
- [Referencing XNU Source Code](#referencing-xnu-source-code)
- [Conclusion](#conclusion)
- [Resource](#resource)
- [Footnote](#footnote)

## Shellcode Overview

Shellcode refers to a set of `assembly` instructions that an attacker deploys to perform malicious actions on a targeted system. These actions commonly include opening a reverse or bind shell, but they can also involve more complex operations. Understanding shellcodes is essential for both offensive and defensive security practitioners.

## Advantages of Writing Custom Shellcode

Writing custom shellcode offers several benefits compared to using auto-generated shellcodes. By crafting our own shellcode, we can tailor it to meet specific requirements, ensuring optimal functionality and stealthiness. Additionally, custom shellcode is often less detectable by antivirus software, providing an advantage in evading security measures.

## Choosing Between `Assembly` and `C`

Shellcode can be written in two primary languages: assembly (`ASM`) and `C`. Assembly is commonly preferred in binary exploitation due to its precise control over the code, enabling optimization for size and the elimination of NULL bytes. However, assembly coding is time-consuming and prone to errors.

On the other hand, writing shellcode in `C` can be faster, less error-prone (especially for longer code), and benefits from the assembly generated by the compiler. However, reliance on the compiler-generated assembly might introduce challenges in certain scenarios.

### Writing Pure Assembly Shellcode

This section focuses on the process of crafting pure assembly shellcode using `system calls`. The control offered by assembly language allows for optimized code, free from NULL bytes, while achieving the desired outcome.

It is important to have an understanding of the [Basic Syntax of Assembly Language](https://dede.dev/posts/Basic-Syntax-of-Assembly/){: target="_blank"}. Start with this [assembly programming tutorial](https://www.tutorialspoint.com/assembly_programming/index.htm){: target="_blank"}, or if you prefer video, this [Introduction to Assembly Language](https://www.youtube.com/playlist?list=PLU6DPNTD99vpzpVA7BhCo-ZGym-bDcjEj){: target="_blank"} is also great.

On macOS we can use `system calls` to create a working shellcode. It's possible to run shell commands and open a reverse shell with only `system calls`.

`System calls` (or `syscalls`) are various functions or services offered by the kernel to user mode. To run `syscalls`, we must know the <u>system call number</u>, and the <u>parameter(s)</u> it expects.

#### Calling Conventions and Registers

Just like `Linux`, `macOS` uses the [`AMD64` calling convention](https://dede.dev/posts/AMD64-Calling-Convention-for-Linux-and-macOS/){: target="_blank"} on `X86_64` CPUs to pass arguments to the function being called. To do this, it uses some general purpose registers as function arguments.

| Register | Description                                     |
| -------- | ----------------------------------------------- |
| RDI      | 1st function argument                           |
| RSI      | 2nd function argument                           |
| RDX      | 3rd function argument (and optionally 2nd return value) |
| RCX      | 4th function argument                           |
| R8       | 5th function argument                           |
| R9       | 6th function argument                           |
| RAX      | Contains the return value of the function       |

The other important registers are as follow.

| Register | Description                                 |
| -------- | ------------------------------------------- |
| RIP      | Instruction pointer                         |
| RSP      | Stack pointer                               |
| RBP      | Frame pointer                               |
| RBX      | Base pointer (optional)                     |

#### System Call Numbering

Each system call has a given number that needs to be stored in the `RAX` register before the syscall assembly instruction. This number will be used by the kernel to decide which function to call.

The `Berkeley Software Distribution` (`BSD`) system call numbers can be found in the file [xnu-7195.50.7.100.1/bsd/kern/syscalls.master](https://github.com/wilfrantz/xnu/blob/master/bsd/kern/syscalls.master){:target="_blank"}.

We focus on two key categories: `shell commands execution` and `bind or reverse shells creation`.

```c
30 AUE_ACCEPT ALL { int accept(int s, caddr_t name, socklen_t *anamelen) NO_SYSCALL_STUB; } 
59 AUE_EXECVE ALL { int execve(char *fname, char **argp, char **envp); } 
90 AUE_DUP2 ALL { int dup2(u_int from, u_int to); } 
97 AUE_SOCKET ALL { int socket(int domain, int type, int protocol); } 
98 AUE_CONNECT ALL { int connect(int s, caddr_t name, socklen_t namelen) NO_SYSCALL_STUB; } 
104 AUE_BIND ALL { int bind(int s, caddr_t name, socklen_t namelen) NO_SYSCALL_STUB; } 
106 AUE_LISTEN ALL { int listen(int s, int backlog) NO_SYSCALL_STUB; } 
```

We will use `execve (59)` to run arbitrary commands, to work with sockets when we create a bind or reverse shell we will use the followings:
`accept (30)`<br>
`dup2 (90)`<br>
`socket (97)`<br>
`connect (98)`<br>
`bind (104)`<br>
`listen (106)`<br>

> `macOS` supports multiple classes of system calls, not just `BSD`[^fn-nth-2]. These classes are defined in the [xnu-7195.50.7.100.1/osfmk/mach/i386/syscall_sw.h](https://github.com/wilfrantz/xnu/blob/master/osfmk/mach/i386/syscall_sw.h){:target="_blank"} file.
{: .prompt-tip }

```c
#define SYSCALL_CLASS_SHIFT 24
#define SYSCALL_CLASS_MASK (0xFF << SYSCALL_CLASS_SHIFT)
#define SYSCALL_NUMBER_MASK (~SYSCALL_CLASS_MASK)

#define SYSCALL_CLASS_NONE 0 /* Invalid */
#define SYSCALL_CLASS_MACH 1 /* Mach */ 
#define SYSCALL_CLASS_UNIX 2 /* Unix/BSD */
#define SYSCALL_CLASS_MDEP 3 /* Machine-dependent */
#define SYSCALL_CLASS_DIAG 4 /* Diagnostics */
#define SYSCALL_CLASS_IPC 5 /* Mach IPC */
```

#### Working with BSD Type System Calls

When dealing with traditional BSD type system calls, it is important to understand how to declare the desired class and system call number. The `SYSCALL_CLASS_UNIX` class, represented by the number `2`, is used for BSD type calls.

To specify the class, we set the class number in the syscall value, positioning it at `24` on the bitmask using the `SYSCALL_CLASS_SHIFT` definition. For BSD type calls, this results in `0x2000000`, obtained by shifting the value 2 left by 24 bits.

After setting the class, we add the specific system call number to `0x2000000`. For instance, if we want to use the `execve` system call with the number `59` (0x3b in hexadecimal), we combine it with the bitmask. The resulting number becomes `0x200003b`, with the system call number occupying the first two positions on the bitmask.

To perform the actual system call, we need to pass this number to the syscall assembly instruction. This instruction will execute the desired system call based on the provided class and system call number.

### Writing Shellcode in C

With `C`, developers can leverage the power and flexibility of the language to create efficient and reliable shellcode. The use of `C` allows for faster development, reduced chances of errors (especially for longer code), and the ability to leverage the assembly generated by the compiler.
However, it is important to be cautious of potential issues such as the presence of `NULL` bytes in the generated assembly, which may introduce challenges in certain exploitation scenarios.

## Executing Arbitrary Commands

One fundamental capability of shellcode is executing arbitrary commands on the targeted system. This section explores techniques for implementing shellcode that enables the execution of desired commands.
 bts[^fn-nth-4] instruction. The bts (bit test and set) instruction sets the n-th bit in a bit string to 1.

For executing custom commands we will only need one system call, `execve`. The function prototype is defined in [xnu-7195.50.7.100.1/bsd/kern/syscalls.master](https://github.com/wilfrantz/xnu/blob/master/bsd/kern/syscalls.master){:target="_blank"}.

## Creating a Bind Shell

In addition to executing arbitrary commands, shellcode can be designed to create a bind shell. This allows the attacker to establish a persistent remote connection to the compromised system.

## Using `C` Code to Call Arbitrary Functions

Another approach to shellcode development involves using `C` code to call arbitrary functions. This method offers faster development and reduced chances of errors, especially for longer shellcode. Though, it comes with the trade-off of relying on the assembly generated by the compiler. The potential issues, such as the presence of NULL bytes, are discussed in this section.

## Referencing XNU Source Code

Throughout the document, the source code of `XNU version 7195.50.7.100.1` is utilized for function prototypes and constants. The `XNU`[^fn-nth-3] source code can be accessed online or downloaded and viewed locally. The document provides instructions on locating the source code, enabling readers to consult it as a valuable resource.

## Conclusion

Mastering shellcodes is essential for both offensive and defensive cybersecurity professionals. This technical document has provided an in-depth exploration of various shellcode techniques and examples, empowering readers to understand the intricacies of crafting custom shellcodes.

By leveraging this knowledge, security practitioners can fortify their systems against malicious attacks and effectively respond to cybersecurity incidents.

## Resource

- [Helper tool for generating 64-bit macOS shellcode using the nasm compiler.](https://github.com/war4uthor/macOS-Shellcode-Helper){:target="_blank"}

## Footnote

[^footnote]: [Offensive Security is Now OffSec](https://finance.yahoo.com/news/offensive-security-now-offsec-refreshed-183100173.html){:target="_blank"}
[^fn-nth-2]: Berkeley Software Distribution
[^fn-nth-3]: Kernel developed at Apple Inc
[^fn-nth-4]: [Bit Test Wikipedia, 2021](https://en.wikipedia.org/wiki/Bit_Test){:target="_blank"}
