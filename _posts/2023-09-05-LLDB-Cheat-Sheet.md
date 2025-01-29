---
title: LLDB Cheat Sheet
date: 2023-09-05 11:33:00 +0800
categories: [Blogging, Tutorial]
tags: [LLDB, Debugging, macOS]
pin: false
math: true
mermaid: true
image:
---

LLDB is the debugger that comes with Xcode and is part of the LLVM project. It is used for debugging programs written in C, C++, Objective-C, and Swift. Here’s a cheat sheet to help you get started with LLDB:

***Table of contents***

- [Starting LLDB](#starting-lldb)
- [Basic Commands](#basic-commands)
- [Breakpoints](#breakpoints)
- [Stepping](#stepping)
- [Examining State](#examining-state)
- [Memory Inspection](#memory-inspection)
- [Expressions](#expressions)
- [Advanced Commands](#advanced-commands)
- [Register Commands](#register-commands)
- [Scripting](#scripting)
- [Tips and Tricks](#tips-and-tricks)
- [Conclusion](#conclusion)

## Starting LLDB

1. **Start LLDB and load a program**

    ```sh
    lldb <program>
    ```

2. **Attach to a running process**

    ```sh
    lldb -p <pid>
    ```

3. **Start LLDB and run a program**

    ```sh
    lldb
    (lldb) target create <program>
    (lldb) run
    ```

## Basic Commands

1. **Run the program**

    ```sh
    run
    ```

2. **Continue execution**

    ```sh
    continue
    ```

3. **Quit LLDB**

    ```sh
    quit
    ```

## Breakpoints

1. **Set a breakpoint at a specific line**

    ```sh
    breakpoint set --file <file> --line <line>
    ```

2. **Set a breakpoint at a function**

    ```sh
    breakpoint set --name <function>
    ```

3. **List all breakpoints**

    ```sh
    breakpoint list
    ```

4. **Delete a breakpoint**

    ```sh
    breakpoint delete <breakpoint-id>
    ```

5. **Conditional Breakpoints**

    ```sh
    breakpoint set --name <function> --condition "<condition>"
    ```

6. **Breakpoints with Commands**

    ```sh
    breakpoint command add <breakpoint-id>
    ```

## Stepping

1. **Step over a line of code**

    ```sh
    next
    ```

2. **Step into a function**

    ```sh
    step
    ```

3. **Step out of a function**

    ```sh
    finish
    ```

4. **Step by Instruction**

    ```sh
    nexti
    ```

## Examining State

1. **Print the value of a variable**

    ```sh
    print <variable>
    ```

2. **Print the call stack**

    ```sh
    backtrace
    ```

3. **List local variables**

    ```sh
    frame variable
    ```

4. **Select a frame**

    ```sh
    frame select <frame-index>
    ```

## Memory Inspection

1. **Read memory at a specific address**

    ```sh
    memory read <address>
    ```

2. **Write memory at a specific address**

    ```sh
    memory write <address> <value>
    ```

3. **Memory Region Info**

    ```sh
    memory region <address>
    ```

## Expressions

1. **Evaluate an expression**

    ```sh
    expr <expression>
    ```

2. **Call a function**

    ```sh
    expr (void) <function>()
    ```

3. **Modify a variable**

    ```sh
    expr <variable> = <value>
    ```

## Advanced Commands

1. **Disassemble a function**

    ```sh
    disassemble --name <function>
    ```

2. **Set a watchpoint**

    ```sh
    watchpoint set variable <variable>
    ```

3. **List all watchpoints**

    ```sh
    watchpoint list
    ```

4. **Delete a watchpoint**

    ```sh
    watchpoint delete <watchpoint-id>
    ```

5. **Trace Function Calls**

    ```sh
    trace start --function <function>
    ```

6. **Stop Tracing**

    ```sh
    trace stop
    ```

## Register Commands

1. **View all registers**

    ```sh
    register read
    ```

2. **View a specific register**

    ```sh
    register read <register-name>
    ```

3. **Modify a register value**

    ```sh
    register write <register-name> <value>
    ```

4. **Save register state to a file**

    ```sh
    register save <file>
    ```

5. **Restore register state from a file**

    ```sh
    register restore <file>
    ```

## Scripting

1. **Run a Script**

    ```sh
    command script import <script.py>
    ```

2. **Define a Custom Command**

    ```sh
    command script add -f <script.function> <command-name>
    ```

3. **List Custom Commands**

    ```sh
    command script list
    ```

## Tips and Tricks

1. **Persistent Variables**

    ```sh
    expr int $myvar = 10
    ```

2. **Format Specifiers**

    ```sh
    print <variable> --format <format>
    ```

3. **Set Environment Variables**

    ```sh
    settings set target.env-vars <VAR>=<value>
    ```

4. **Save Breakpoints**

    ```sh
    breakpoint write <file>
    ```

5. **Load Breakpoints**

    ```sh
    breakpoint read <file>
    ```

## Conclusion

LLDB is a powerful debugger that can help you find and fix bugs in your code. This cheat sheet covers the most commonly used commands, but LLDB has many more features that you can explore in the official documentation.
