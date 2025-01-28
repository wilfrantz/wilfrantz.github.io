---
title: ARM64 Calling Convention Cheat Sheet (MacOS)
date: 2023-09-05 11:33:00 +0800
categories: [Blogging, Doc]
tags: [ARM64, macOS, ASM, Assembly, ARMv8-A]
pin: false
math: true
mermaid: true
image:
  path: ARM64.png
  alt: ARM64
---

**ARM64**, also known as **AArch64**, is the 64-bit execution state introduced in the `ARMv8-A` architecture. If you're diving into `ARM64` assembly on macOS, understanding the calling convention is crucial. It helps in ensuring interoperability between function calls, making your code more readable, maintainable, and efficient. Here's a cheat sheet for the standard ARM64 calling convention on macOS:

***Table of contents***

- [General-Purpose Registers](#general-purpose-registers)
- [Floating Point and Vector Registers](#floating-point-and-vector-registers)
- [Stack](#stack)
- [Function Calling](#function-calling)
- [Function Return](#function-return)
- [Variadic Functions](#variadic-functions)
- [System Calls](#system-calls)
- [System Call Numbering](#system-call-numbering)
- [Instruction Sets](#instruction-sets)
- [ARMv8-A Instructions](#armv8-a-instructions)
- [Common ARM64 Commands](#common-arm64-commands)
- [Calling Conventions and Registers](#calling-conventions-and-registers)
  - [General-Purpose Registers Summary](#general-purpose-registers-summary)
  - [Floating Point and Vector Registers Overview](#floating-point-and-vector-registers-overview)
  - [Stack Overview](#stack-overview)
  - [Function Calling Overview](#function-calling-overview)
  - [Function Return Overview](#function-return-overview)
  - [Handling Variadic Functions](#handling-variadic-functions)
  - [System Calls Overview](#system-calls-overview)
- [Conclusion](#conclusion)
- [Ressources](#ressources)

## General-Purpose Registers

There are 31 general-purpose registers, labeled `X0` to `X30`. The 32nd register is the stack pointer, `SP`.

- **X0 - X7**: Used for parameter passing and return values. If a function has more than 8 arguments, the subsequent ones are passed on the stack.
  
- **X8**: Used as an indirect result location register.
  
- **X9 - X15**: Temporary registers. Can be used freely within a function.
  
- **X16 - X17**: Used as intra-procedure-call scratch registers (temporary).
  
- **X18**: Platform register (OS-reserved).
  
- **X19 - X28**: Callee-saved registers. Functions must save and restore these registers if used.
  
- **X29**: Frame pointer. Used to maintain a reference to the top of the current function's stack frame.
  
- **X30**: Link register. Holds the return address when a function is called.

---

## Floating Point and Vector Registers

There are 32 SIMD (Single Instruction, Multiple Data) and floating-point registers, labeled `V0` to `V31`.

- **V0 - V7**: Used for parameter passing and return values for floating-point and vector data.
  
- **V8 - V15**: Must be saved and restored by the callee if used.
  
- **V16 - V31**: Temporary registers.

---

## Stack

The stack is full descending, meaning the stack grows down in memory.

- **SP**: Stack Pointer. Always points to the top of the stack.
  
- **Stack alignment**: Must be 16 bytes. Functions must maintain this alignment.

---

## Function Calling

- **Arguments**: First 8 integer or pointer arguments in `X0` to `X7`. First 8 floating-point or vector arguments in `V0` to `V7`. Additional arguments are passed on the stack.
  
- **Return values**: Integer and pointer return values in `X0` (and `X1` if needed). Floating-point or vector return values in `V0` (and `V1` if needed).

- **Callee-saved registers**: `X19` to `X30`, `V8` to `V15`. Functions must restore these if they are used within the function.

---

## Function Return

A function returns to its caller by branching to the address in `X30` (the link register).

---

## Variadic Functions

For functions with a variable number of arguments:

- Named arguments are passed as usual.
  
- Unnamed arguments are passed in registers until they are filled, then on the stack.

---

## System Calls

- **Arguments**: `X0` to `X7`.
  
- **System call number**: In `X16`.

---

## System Call Numbering

System calls in ARM64 are identified by unique numbers. These numbers are placed in the `X16` register before making the system call. Here are some common system call numbers:

- **0**: `syscall` - Generic system call.
- **1**: `exit` - Terminate the calling process.
- **2**: `fork` - Create a new process.
- **3**: `read` - Read from a file descriptor.
- **4**: `write` - Write to a file descriptor.
- **5**: `open` - Open a file.
- **6**: `close` - Close a file descriptor.

To make a system call, load the appropriate system call number into `X16` and the arguments into `X0` to `X7`, then execute the `svc` instruction.

Example:

```c
MOV X0, #1       // File descriptor (stdout)
MOV X1, message  // Pointer to message
MOV X2, #13      // Message length
MOV X16, #4      // System call number (write)
SVC #0           // Make the system call
```

> Understanding system call numbering is essential for interacting with the operating system at a low level.

---

## Instruction Sets

ARM64 supports several instruction sets, each designed for specific types of operations:

- **A64**: The 64-bit instruction set used in ARMv8-A architecture. It includes general-purpose, SIMD, and floating-point instructions.
  
- **A32**: The 32-bit instruction set used in ARMv7-A and ARMv8-A architectures. It is also known as ARM instruction set.
  
- **T32**: The 32-bit Thumb instruction set, which provides a more compact representation of instructions compared to A32.

Understanding these instruction sets is crucial for writing efficient assembly code and optimizing performance on ARM64 platforms.

---

## ARMv8-A Instructions

ARMv8-A introduces several new instructions to enhance performance and functionality. Here are some key instructions:

- **ADD**: Adds two registers and stores the result in a register.

 ```c
  ADD X0, X1, X2  // X0 = X1 + X2
  ```

- **SUB**: Subtracts one register from another and stores the result in a register.

  ```c
  SUB X0, X1, X2  // X0 = X1 - X2
  ```

- **MOV**: Moves a value from one register to another.

  ```c
  MOV X0, X1  // X0 = X1
  ```

- **LDR**: Loads a value from memory into a register.

  ```c
  LDR X0, [X1]  // X0 = *X1
  ```

- **STR**: Stores a value from a register into memory.

  ```c
  STR X0, [X1]  // *X1 = X0
  ```

- **B**: Branches to a specified address.

  ```c
  B label  // Branch to label
  ```

- **BL**: Branches to a specified address and saves the return address in the link register (X30).

  ```c
  BL label  // Branch to label and link
  ```

- **RET**: Returns from a subroutine by branching to the address in the link register (X30).

  ```c
  RET  // Return from subroutine
  ```

- **CMP**: Compares two registers and sets condition flags.

  ```c
  CMP X0, X1  // Compare X0 and X1
  ```

- **B.EQ**: Branches if the comparison result is equal.

  ```c
  B.EQ label  // Branch to label if equal
  ```

---

## Common ARM64 Commands

Here are some common ARM64 commands that you might find useful:

- **NOP**: No operation. It does nothing and is often used for timing or alignment purposes.

  ```c
  NOP  // No operation
  ```

- **AND**: Performs a bitwise AND operation between two registers and stores the result in a register.

  ```c
  AND X0, X1, X2  // X0 = X1 & X2
  ```

- **ORR**: Performs a bitwise OR operation between two registers and stores the result in a register.

  ```c
  ORR X0, X1, X2  // X0 = X1 | X2
  ```

- **EOR**: Performs a bitwise exclusive OR (XOR) operation between two registers and stores the result in a register.

  ```c
  EOR X0, X1, X2  // X0 = X1 ^ X2
  ```

- **LSL**: Logical shift left. Shifts the bits in a register to the left by a specified number of positions.

  ```c
  LSL X0, X1, #2  // X0 = X1 << 2
  ```

- **LSR**: Logical shift right. Shifts the bits in a register to the right by a specified number of positions.

  ```c
  LSR X0, X1, #2  // X0 = X1 >> 2
  ```

- **ASR**: Arithmetic shift right. Shifts the bits in a register to the right by a specified number of positions, preserving the sign bit.

  ```c
  ASR X0, X1, #2  // X0 = X1 >> 2 (arithmetic)
  ```

- **MUL**: Multiplies two registers and stores the result in a register.

  ```c
  MUL X0, X1, X2  // X0 = X1 * X2
  ```

- **DIV**: Divides one register by another and stores the result in a register.

  ```c
  DIV X0, X1, X2  // X0 = X1 / X2
  ```

- **NEG**: Negates the value in a register.

  ```c
  NEG X0, X1  // X0 = -X1
  ```

- **NOT**: Performs a bitwise NOT operation on a register and stores the result in a register.

  ```c
  NOT X0, X1  // X0 = ~X1
  ```

These commands are fundamental for performing arithmetic, logical, and data manipulation operations in ARM64 assembly.

---

## Calling Conventions and Registers

Understanding the calling conventions and the role of each register is crucial for ARM64 assembly programming. Here is a summary:

### General-Purpose Registers Summary

- **X0 - X7**: Used for parameter passing and return values.
- **X8**: Indirect result location register.
- **X9 - X15**: Temporary registers.
- **X16 - X17**: Intra-procedure-call scratch registers.
- **X18**: Platform register (OS-reserved).
- **X19 - X28**: Callee-saved registers.
- **X29**: Frame pointer.
- **X30**: Link register.

### Floating Point and Vector Registers Overview

- **V0 - V7**: Used for parameter passing and return values.
- **V8 - V15**: Callee-saved registers.
- **V16 - V31**: Temporary registers.

### Stack Overview

- **SP**: Stack Pointer. Points to the top of the stack.
- **Stack alignment**: Must be 16 bytes.

### Function Calling Overview

- **Arguments**: First 8 integer/pointer arguments in `X0` to `X7`, first 8 floating-point/vector arguments in `V0` to `V7`.
- **Return values**: Integer/pointer return values in `X0` (and `X1` if needed), floating-point/vector return values in `V0` (and `V1` if needed).
- **Callee-saved registers**: `X19` to `X30`, `V8` to `V15`.

### Function Return Overview

- **Return address**: Stored in `X30` (link register).

### Handling Variadic Functions

- **Named arguments**: Passed as usual.
- **Unnamed arguments**: Passed in registers until filled, then on the stack.

### System Calls Overview

- **Arguments**: `X0` to `X7`.
- **System call number**: In `X16`.

---

## Conclusion

When coding in `ARM64` assembly on macOS or dealing with debugging and reverse engineering, understanding the calling convention can be invaluable. It helps in tracking the flow of data between functions, deciphering the purpose of various registers at different points in time, and making sense of the machine code in front of you.

## Ressources

- [AArch64/ARM64 Tutorial](https://mariokartwii.com/armv8/ch5.html){:target="_blank"}
