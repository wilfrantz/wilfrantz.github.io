---
title: ARM64 Calling Convention Cheat Sheet
date: 2023-09-05 11:33:00 +0800
categories: [Blogging, Doc]
tags: [ARM64, OSMR, ASM, Assembly]
pin: false
math: true
mermaid: true
image:
  path: ARM64.png
  alt: ARM64
---

`ARM64`, also known as `AArch64`, is the 64-bit execution state introduced in the `ARMv8` architecture. If you're diving into `ARM64`` assembly, understanding the calling convention is crucial. It helps in ensuring interoperability between function calls, making your code more readable, maintainable, and efficient. Here's a cheat sheet for the standard ARM64 calling convention:

***Table of contents***

- [General-Purpose Registers](#general-purpose-registers)
- [Floating Point and Vector Registers](#floating-point-and-vector-registers)
- [Stack](#stack)
- [Function Calling](#function-calling)
- [Function Return](#function-return)
- [Variadic Functions](#variadic-functions)
- [System Calls](#system-calls)
- [Conclusion](#conclusion)

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
  
- **System call number**: In `X8`.

---

## Conclusion

When coding in `ARM64` assembly or dealing with debugging and reverse engineering, understanding the calling convention can be invaluable. It helps in tracking the flow of data between functions, deciphering the purpose of various registers at different points in time, and making sense of the machine code in front of you.
