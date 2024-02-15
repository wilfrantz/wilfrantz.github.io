---
title: A Comprehensive Guide to macOS Binary Analysis Tools
date: 2023-09-09 11:33:00 +0800
categories: [Note, Doc]
tags: [macOS, ASM, OSMR]
pin: false
math: true
mermaid: true
image:
  path: macOS-Binary-Analysis-Tools.png
---

> ⚠️ **This document is still a draft. Please note that there might be mistakes or inaccuracies.**
{: .prompt-warning }

When it comes to understanding the inner workings of `macOS` applications and system processes, binary analysis tools are essential. These tools allow security researchers, developers, and curious minds to dissect binaries, examine code, and gain insights into how `macOS` software functions.

In this comprehensive guide, we'll explore various `macOS` binary analysis tools, both command-line and graphical, to help you navigate the world of binary analysis effectively. In order to discover vulnerabilities and write exploits, we need to conduct both dynamic and static analysis of binaries and understand how to debug applications.

<u>Table of contents</u>

- [Command Line Static Analysis Tools](#command-line-static-analysis-tools)
  - [codesign](#codesign)
  - [objdump](#objdump)
  - [`jtool`](#jtool)
- [Static Analysis with Hopper](#static-analysis-with-hopper)
  - [Views in Hopper](#views-in-hopper)
  - [Navigating the Code](#navigating-the-code)
  - [External C Function Resolution](#external-c-function-resolution)
- [Dynamic Analysis](#dynamic-analysis)
  - [The `LLDB` Debugger](#the-lldb-debugger)
    - [Setting Breakpoints](#setting-breakpoints)
    - [Disassembling with `LLDB`](#disassembling-with-lldb)
    - [Reading and Writing Memory, and Registers](#reading-and-writing-memory-and-registers)
    - [Modifying Code During Debugging](#modifying-code-during-debugging)
  - [Debugging with Hopper](#debugging-with-hopper)
    - [Starting the Debugger](#starting-the-debugger)
    - [Basic Controls and Functionality](#basic-controls-and-functionality)
    - [Inspecting External Function Resolution](#inspecting-external-function-resolution)
  - [Tracing Applications with `DTrace`](#tracing-applications-with-dtrace)
    - [`DTrace` Example - Monitoring System Calls](#dtrace-example---monitoring-system-calls)
    - [`DTrace` Example - Monitoring Write Calls](#dtrace-example---monitoring-write-calls)
    - [`DTrace` Example - Creating Aggregation Info](#dtrace-example---creating-aggregation-info)
    - [`DTrace` Probes](#dtrace-probes)
    - [System `DTrace` Scripts](#system-dtrace-scripts)
- [Wrapping Up](#wrapping-up)

## Command Line Static Analysis Tools

### codesign

`codesign` is a powerful command-line tool that helps verify code signatures and certificates associated with `macOS` binaries. It ensures the integrity and authenticity of executable files, libraries, and bundles. Running `codesign` with appropriate options allows you to investigate code signing details and identify potential security issues.

To verify the code signature of a `macOS` binary named "MyApp.app" you can use the following command:

```shell
codesign -dv --verbose=4 /path/to/MyApp.app
```

This command will display detailed information about the code signature, including the certificate used for signing.

### objdump

`objdump` is a versatile utility that provides detailed information about binary files, including disassembled code, section headers, and symbol tables. This tool is particularly useful for reverse engineering, allowing you to examine assembly instructions and gain insights into a binary's functionality.

To disassemble a `macOS` binary file named "my_binary" you can use the following command:

```bash
objdump -d /path/to/my_binary
```

This command will display the disassembled code of the binary, allowing you to analyze its assembly instructions.

### `jtool`

``jtool`` is a Swiss army knife for `macOS` binary analysis. It offers various functionalities, including disassembly, code signature inspection, and more. Its flexibility and ease of use make it a valuable addition to your binary analysis toolkit.

To inspect the code signature of a `macOS` binary using `jtool`, you can use the following command:

```zsh
`jtool` --sign /path/to/my_binary
```

This command will provide information about the binary's code signature, similar to codesign.

## Static Analysis with Hopper

[Hopper](https://www.hopperapp.com/){:target="_blank"} is a popular graphical disassembler and decompiler for `macOS`. It simplifies the process of reverse engineering by providing a user-friendly interface. Here are some key aspects of static analysis with Hopper:

### Views in Hopper

`Hopper`offers various views, such as the disassembly view, pseudo code view, and data flow view. These views help you explore different aspects of the binary, making it easier to understand its behavior.

### Navigating the Code

`Hopper`allows you to navigate through the binary code effortlessly. You can jump between functions, follow code paths, and analyze control flow to comprehend the binary's logic.

### External C Function Resolution

When analyzing `macOS` binaries, you often encounter calls to external C functions. `Hopper`assists in resolving these external function references, helping you understand how the binary interacts with the `macOS` API.

## Dynamic Analysis

Dynamic analysis involves observing the behavior of a binary while it runs. This approach is valuable for understanding how software behaves in real-world scenarios and can uncover runtime vulnerabilities. Tools like `LLDB` and `Hopper`facilitate dynamic analysis.

### The `LLDB` Debugger

#### Setting Breakpoints

`LLDB` is the default debugger for `macOS`. You can use it to set breakpoints in a binary, allowing you to halt execution at specific points in the code for inspection.

#### Disassembling with `LLDB`

`LLDB` provides disassembly capabilities, enabling you to examine the assembly instructions executed by the binary during debugging sessions.

#### Reading and Writing Memory, and Registers

`LLDB` allows you to read and modify memory contents and CPU registers during debugging. This is crucial for understanding and manipulating a binary's state.

#### Modifying Code During Debugging

In some cases, you may want to modify the binary's code while debugging. `LLDB` enables you to patch binary code on the fly, which can be useful for analyzing and mitigating security vulnerabilities.

### Debugging with Hopper

`Hopper`also provides debugging capabilities to complement its static analysis features:

#### Starting the Debugger

You can initiate a debugging session within `Hopper`to dynamically analyze a binary. This allows you to step through code, set breakpoints, and inspect memory and registers.

#### Basic Controls and Functionality

Hopper's debugger offers controls for stepping through code, examining variables, and understanding the binary's runtime behavior.

#### Inspecting External Function Resolution

Similar to static analysis, Hopper's debugger helps you inspect and understand how the binary interacts with external functions during runtime.

### Tracing Applications with `DTrace`

[`DTrace`](https://`DTrace`.org/){:target="_blank"} is a dynamic tracing framework available on `macOS`. It enables you to monitor and trace various system activities, providing insights into application behavior and performance. Here are some examples of using `DTrace` for binary analysis:

#### `DTrace` Example - Monitoring System Calls

You can create `DTrace` scripts to trace system calls made by a binary, helping you understand its interactions with the underlying operating system.

#### `DTrace` Example - Monitoring Write Calls

`DTrace` can be used to track write operations, allowing you to observe file and network activity initiated by the binary.

#### `DTrace` Example - Creating Aggregation Info

`DTrace` can aggregate data, making it easier to identify patterns and anomalies in the binary's behavior over time.

#### `DTrace` Probes

`DTrace` provides a rich set of probes that you can use to trace various events, such as function calls, I/O operations, and more.

#### System `DTrace` Scripts

Numerous `DTrace` scripts and tools are available for specific use cases. You can leverage these scripts to gain deeper insights into binary behavior.

The `man -k dtrace` command will list all of the DTrace scripts available.

```shell
man -k dtrace

Tcl_CommandTraceInfo(3tcl), Tcl_TraceCommand(3tcl), Tcl_UntraceCommand(3tcl) - monitor renames and deletes of a command
perldtrace(1)            - Perl's support for DTrace
bitesize.d(1m)           - analyse disk I/O size by process. Uses DTrace
cpuwalk.d(1m)            - Measure which CPUs a process runs on. Uses DTrace
creatbyproc.d(1m)        - snoop creat()s by process name. Uses DTrace
dappprof(1m)             - profile user and lib function usage. Uses DTrace
dapptrace(1m)            - trace user and library function usage. Uses DTrace
dispqlen.d(1m)           - dispatcher queue length by CPU. Uses DTrace
dtrace(1)                - dynamic tracing compiler and tracing utility
dtruss(1m)               - process syscall details. Uses DTrace
errinfo(1m)              - print errno for syscall fails. Uses DTrace
execsnoop(1m)            - snoop new process execution. Uses DTrace
fddist(1m)               - file descriptor usage distributions. Uses DTrace
filebyproc.d(1m)         - snoop opens by process name. Uses DTrace
hotspot.d(1m)            - print disk event by location. Uses DTrace
iofile.d(1m)             - I/O wait time by file and process. Uses DTrace
iofileb.d(1m)            - I/O bytes by file and process. Uses DTrace
iopattern(1m)            - print disk I/O pattern. Uses DTrace
iopending(1m)            - plot number of pending disk events. Uses DTrace
iosnoop(1m)              - snoop I/O events as they occur. Uses DTrace
iotop(1m)                - display top disk I/O events by process. Uses DTrace
kill.d(1m)               - snoop process signals as they occur. Uses DTrace
lastwords(1m)            - print syscalls before exit. Uses DTrace
loads.d(1m)              - print load averages. Uses DTrace
newproc.d(1m)            - snoop new processes. Uses DTrace
opensnoop(1m)            - snoop file opens as they occur. Uses DTrace
pathopens.d(1m)          - full pathnames opened ok count. Uses DTrace
perldtrace(1)            - Perl's support for DTrace
pidpersec.d(1m)          - print new PIDs per sec. Uses DTrace
plockstat(1)             - front-end to DTrace to print statistics about POSIX mutexes and read/write locks
priclass.d(1m)           - priority distribution by scheduling class. Uses DTrace
pridist.d(1m)            - process priority distribution. Uses DTrace
procsystime(1m)          - analyse system call times. Uses DTrace
rwbypid.d(1m)            - read/write calls by PID. Uses DTrace
rwbytype.d(1m)           - read/write bytes by vnode type. Uses DTrace
rwsnoop(1m)              - snoop read/write events. Uses DTrace
sampleproc(1m)           - sample processes on the CPUs. Uses DTrace
seeksize.d(1m)           - print disk event seek report. Uses DTrace
setuids.d(1m)            - snoop setuid calls as they occur. Uses DTrace
sigdist.d(1m)            - signal distribution by process. Uses DTrace
syscallbypid.d(1m)       - syscalls by process ID. Uses DTrace
syscallbyproc.d(1m)      - syscalls by process name. Uses DTrace
syscallbysysc.d(1m)      - syscalls by syscall. Uses DTrace
topsyscall(1m)           - top syscalls by syscall name. Uses DTrace
topsysproc(1m)           - top syscalls by process name. Uses DTrace
Tcl_CommandTraceInfo(3tcl), Tcl_TraceCommand(3tcl), Tcl_UntraceCommand(3tcl) - monitor renames and deletes of a command
bitesize.d(1m)           - analyse disk I/O size by process. Uses DTrace
cpuwalk.d(1m)            - Measure which CPUs a process runs on. Uses DTrace
creatbyproc.d(1m)        - snoop creat()s by process name. Uses DTrace
dappprof(1m)             - profile user and lib function usage. Uses DTrace
dapptrace(1m)            - trace user and library function usage. Uses DTrace
dispqlen.d(1m)           - dispatcher queue length by CPU. Uses DTrace
dtrace(1)                - dynamic tracing compiler and tracing utility
dtruss(1m)               - process syscall details. Uses DTrace
errinfo(1m)              - print errno for syscall fails. Uses DTrace
execsnoop(1m)            - snoop new process execution. Uses DTrace
fddist(1m)               - file descriptor usage distributions. Uses DTrace
filebyproc.d(1m)         - snoop opens by process name. Uses DTrace
hotspot.d(1m)            - print disk event by location. Uses DTrace
iofile.d(1m)             - I/O wait time by file and process. Uses DTrace
iofileb.d(1m)            - I/O bytes by file and process. Uses DTrace
iopattern(1m)            - print disk I/O pattern. Uses DTrace
iopending(1m)            - plot number of pending disk events. Uses DTrace
iosnoop(1m)              - snoop I/O events as they occur. Uses DTrace
iotop(1m)                - display top disk I/O events by process. Uses DTrace
kill.d(1m)               - snoop process signals as they occur. Uses DTrace
lastwords(1m)            - print syscalls before exit. Uses DTrace
loads.d(1m)              - print load averages. Uses DTrace
newproc.d(1m)            - snoop new processes. Uses DTrace
opensnoop(1m)            - snoop file opens as they occur. Uses DTrace
pathopens.d(1m)          - full pathnames opened ok count. Uses DTrace
perldtrace(1)            - Perl's support for DTrace
pidpersec.d(1m)          - print new PIDs per sec. Uses DTrace
plockstat(1)             - front-end to DTrace to print statistics about POSIX mutexes and read/write locks
priclass.d(1m)           - priority distribution by scheduling class. Uses DTrace
pridist.d(1m)            - process priority distribution. Uses DTrace
procsystime(1m)          - analyse system call times. Uses DTrace
rwbypid.d(1m)            - read/write calls by PID. Uses DTrace
rwbytype.d(1m)           - read/write bytes by vnode type. Uses DTrace
rwsnoop(1m)              - snoop read/write events. Uses DTrace
sampleproc(1m)           - sample processes on the CPUs. Uses DTrace
seeksize.d(1m)           - print disk event seek report. Uses DTrace
setuids.d(1m)            - snoop setuid calls as they occur. Uses DTrace
sigdist.d(1m)            - signal distribution by process. Uses DTrace
syscallbypid.d(1m)       - syscalls by process ID. Uses DTrace
syscallbyproc.d(1m)      - syscalls by process name. Uses DTrace
syscallbysysc.d(1m)      - syscalls by syscall. Uses DTrace
topsyscall(1m)           - top syscalls by syscall name. Uses DTrace
topsysproc(1m)           - top syscalls by process name. Uses DTrace
```

## Wrapping Up

In this guide, we've covered a range of `macOS` binary analysis tools, from command-line utilities like `codesign` and `objdump` to powerful graphical tools like Hopper, as well as dynamic analysis with `LLDB` and `DTrace`.

Understanding these tools and how to use them effectively is essential for anyone involved in reverse engineering, security research, or `macOS` development. With these tools at your disposal, you can gain valuable insights into the inner workings of `macOS` applications and system processes, uncover vulnerabilities, and enhance your overall `macOS` binary analysis skills.

Happy analyzing!!
