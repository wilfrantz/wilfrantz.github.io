---
title: AMD64 Calling Convention for Linux and macOS 
date: 2023-06-17 1:33:00 +0800
categories: [Blogging, Document]
tags: [Asm, OSMR, Linux, MacOs]
pin: false 
math: true
mermaid: true
image: 
  path: amd64-macos-registers.png
---

The `AMD64` calling convention defines how functions receive parameters from their caller and how they return a result. Adhering to this calling convention ensures proper data handling and register usage in function calls.

Here is a comprehensive list of the registers used in the AMD64 calling convention for `Linux` and `macOS`:

- `%rax`: Used for returning a value from a function by the caller.
- `%rbx`: Optionally used as a base pointer.
- `%rcx`: Used to pass the 4th argument to a function by the caller.
- `%rdx`: Used to pass the 3rd argument to a function and optionally to return a second value by the caller.
- `%rsp`: Stack pointer.
- `%rbp`: Frame pointer.
- `%rsi`: Used to pass the 2nd argument to a function by the caller.
- `%rdi`: Used to pass the 1st argument to a function by the caller.
- `%r8`: Used to pass the 5th argument to a function by the caller.
- `%r9`: Used to pass the 6th argument to a function by the caller.
- `%r10`, `%r11`, `%r12`, `%r13`, `%r14`, `%r15`: Temporary registers.

The responsibility for saving the contents of certain registers depends on whether they are used by the caller or the callee. The following table summarizes the register usage and saving responsibility:

| Register | Use                  | Saved By          |
| -------- | -------------------- | ----------------- |
| `%rax`   | Return value         | Caller            |
| `%rbx`   | Base pointer         | Callee (Optional) |
| `%rcx`   | 4th argument         | Caller            |
| `%rdx`   | 3rd argument         | Caller            |
| `%rsp`   | Stack pointer        | -                 |
| `%rbp`   | Frame pointer        | Callee            |
| `%rsi`   | 2nd argument         | Caller            |
| `%rdi`   | 1st argument         | Caller            |
| `%r8`    | 5th argument         | Caller            |
| `%r9`    | 6th argument         | Caller            |
| `%r10`   | Temporary register   | Caller            |
| `%r11`   | Temporary register   | Caller            |
| `%r12`   | Temporary register   | Callee            |
| `%r13`   | Temporary register   | Callee            |
| `%r14`   | Temporary register   | Callee            |
| `%r15`   | Temporary register   | Callee            |

Registers saved by the callee are typically spilled to the current function's stack frame, while the caller is responsible for setting up the arguments for the callee in the appropriate registers.

Understanding and following the AMD64 calling convention is essential for proper function call handling and interoperability between different code modules in `Linux` and `macOS` environments. By adhering to this convention, developers can ensure efficient and reliable program execution.

This [Assembly Instruction Reference](http://127.0.0.1:4000/posts/X86-64-Assembly-Instruction-Reference/){:target="_blank"} is also a valuable resource.

## Reference

- [AMD64 Calling Conventions for Linux / Mac OSX CSE 378 – Fall 2010, Section](https://courses.cs.washington.edu/courses/cse378/10au/sections/Section1_recap.pdf){: target="_blank"}
