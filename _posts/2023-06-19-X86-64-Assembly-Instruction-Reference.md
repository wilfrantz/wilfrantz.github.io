---
title: X86-64 Assembly Instruction Reference
date: 2023-06-19 1:33:00 +0800
categories: [Blogging, Document]
tags: [Asm, OSMR, Linux, MacOs]
pin: false 
math: true
mermaid: true
image: 
  path: amd64-macos-registers.png
---

This document provides a quick reference guide for commonly used `X86-64` assembly instructions. It serves as a handy resource for novice programmers learning assembly language.

<u>Table of contents</u>

- [Data Movement Instructions](#data-movement-instructions)
- [Arithmetic and Logical Instructions](#arithmetic-and-logical-instructions)
- [Control Transfer Instructions](#control-transfer-instructions)
- [Stack Instructions](#stack-instructions)
- [Arithmetic Instructions](#arithmetic-instructions)
- [Bit Manipulation Instructions](#bit-manipulation-instructions)

## Data Movement Instructions

- `MOV`: Move data between registers, memory locations, or immediate values.

## Arithmetic and Logical Instructions

- `ADD`: Perform addition operations on registers or memory locations.
- `SUB`: Perform subtraction operations on registers or memory locations.
- `CMP`: Compare two operands and set flags accordingly for conditional branching.
- `INC`: Increment the value of a register or memory location.
- `DEC`: Decrement the value of a register or memory location.
- `AND`: Perform bitwise AND operations on registers or memory locations.
- `OR` : Perform bitwise OR operations on registers or memory locations.
- `XOR`: Perform bitwise XOR operations on registers or memory locations.

## Control Transfer Instructions

- `JMP`: Unconditionally jump to a specified location in the program.
- `JE/JZ`: Jump if equal or zero.
- `JNE/JNZ`: Jump if not equal or not zero.
- `CALL`: Call a function or subroutine at a specified memory address.
- `RET`: Return from a subroutine back to the calling function.

## Stack Instructions

- `PUSH`: Push data onto the stack.
- `POP`: Pop data from the stack.

## Arithmetic Instructions

- `MUL`: Perform multiplication operations.
- `DIV`: Perform division operations.

## Bit Manipulation Instructions

- `SHL/SHR`: Shift the bits of a register or memory location left or right.

> This is not an exhaustive list, but it covers some of the commonly used `X86-64` assembly instructions. For a more comprehensive understanding of the instruction set, refer to the official `Intel` or `AMD` documentation.
{: .prompt-info }
> **Note:** Understanding assembly language requires familiarity with the underlying computer architecture. It is recommended to study the official documentation and refer to appropriate learning resources for a thorough understanding of `X86-64` assembly programming.
{: .prompt-tip}
