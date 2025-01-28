---
title: GDB and CGDB Cheat Sheet
date: 2021-03-17 11:33:00 +0800
categories: [Blog]
tags: [SWE, GDB]
pin: false
math: true
mermaid: true
image:
---

## GDB (GNU Debugger)

GDB is a powerful tool for debugging applications written in C, C++, and other languages. Here's a quick reference to some commonly used commands:

### Basic Commands

- `gdb [program]` - Start GDB with the specified program.
- `run [args]` - Run the program with optional arguments.
- `break [location]` - Set a breakpoint at the specified location (function, line number, etc.).
- `continue` - Continue execution until the next breakpoint.
- `next` - Execute the next line of the program (step over).
- `step` - Step into a function.
- `list` - Show the source code around the current line.
- `print [expression]` - Evaluate and print the expression.
- `info breakpoints` - List all breakpoints.
- `delete breakpoints [number]` - Delete a specific breakpoint.
- `quit` - Exit GDB.

### Advanced Commands

- `watch [var]` - Set a watchpoint for a variable.
- `backtrace` - Show the call stack.
- `frame [number]` - Select a frame from the call stack.
- `set variable [var]=[value]` - Set a variable to a new value.
- `disassemble [function]` - Show assembly code for the function.
- `catch [event]` - Break on specific events like `throw` or `catch`.
- `info registers` - Display the contents of CPU registers.
- `info threads` - List all threads.
- `thread [number]` - Switch to a specific thread.
- `thread apply all [command]` - Apply a command to all threads.
- `set logging on` - Enable logging of GDB session to a file.
- `set follow-fork-mode [mode]` - Control whether GDB follows the parent or child process after a fork.

### Tips and Tricks

- **Conditional Breakpoints**: Set breakpoints that only trigger when a condition is met.

    ```sh
    break [location] if [condition]
    ```

- **Command Lists**: Execute a list of commands when a breakpoint is hit.

    ```sh
    break [location]
    commands
    [command1]
    [command2]
    end
    ```

- **Pretty Printing**: Enable pretty printing for complex data structures.

    ```sh
    set print pretty on
    ```

- **Reverse Debugging**: Step backwards in the program execution (requires GDB to be configured with reverse debugging support).

    ```sh
    target record
    reverse-step
    reverse-continue
    ```

## CGDB (Curses-based interface to the GNU Debugger)

CGDB provides a more user-friendly interface to GDB. It includes split views showing source code and GDB commands simultaneously.

### Key Bindings

- `F7` - Step into a function (`step` in GDB).
- `F8` - Step over a function (`next` in GDB).
- `F9` - Set or clear a breakpoint at the current line.
- `F10` - Continue program execution (`continue` in GDB).
- `Ctrl + L` - Redraw the screen.
- `Tab` - Switch between source and GDB command window.

### Using CGDB

- Launching: `cgdb [program]`
- In the source window, you can navigate the code just like in a text editor.
- In the GDB command window, you can type any GDB command.

### Tips for CGDB

- CGDB remembers the history of GDB commands; use the arrow keys to navigate through past commands.
- The split screen allows simultaneous viewing of source code and real-time debugging output, enhancing the debugging experience.
- **Custom Key Bindings**: Customize key bindings in CGDB by editing the `.cgdb/cgdbrc` file.

    ```sh
    bind key [key] [command]
    ```

- **Macros**: Define macros in CGDB to automate repetitive tasks.

    ```sh
    define [macro-name]
    [command1]
    [command2]
    end
    ```

- **Color Schemes**: Customize the color scheme of CGDB by editing the `.cgdb/cgdb.conf` file.

    ```sh
    set color [element] [color]
    ```

By leveraging these advanced commands and tips, you can significantly enhance your debugging efficiency and effectiveness with GDB and CGDB.
