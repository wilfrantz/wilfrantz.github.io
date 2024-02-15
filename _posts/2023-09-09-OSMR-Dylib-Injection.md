---
title: Dylib Injection - Exploiting macOS Applications 
date: 2023-09-09 11:33:00 +0800
categories: [Blogging, Doc]
tags: [dylib, dyld, OSMR, Assembly, MacOS]
pin: false
math: true
mermaid: true
image:
---

> **This document is still a draft. Please note that there might be mistakes or inaccuracies.**
{: .prompt-warning }

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Step 1: Identify Target Application](#step-1-identify-target-application)
- [Step 2: Create the Dylib](#step-2-create-the-dylib)
  - [Create a new `Xcode` project for a Command Line Tool](#create-a-new-xcode-project-for-a-command-line-tool)
  - [Write your dylib code in C/C++](#write-your-dylib-code-in-cc)
    - [DYLD\_INSERT\_LIBRARIES Injection in macOS](#dyld_insert_libraries-injection-in-macos)
    - [Monitor log output using the `log` command](#monitor-log-output-using-the-log-command)
    - [DYLIB Hijacking](#dylib-hijacking)
  - [Build the dylib, ensuring it's a dynamic library (`.dylib`)](#build-the-dylib-ensuring-its-a-dynamic-library-dylib)
- [Step 3: Inject the Dylib](#step-3-inject-the-dylib)
- [Step 4: Test the Injection](#step-4-test-the-injection)
- [Step 5: Cleanup](#step-5-cleanup)
- [Conclusion](#conclusion)

## Introduction

Dylib injection is a technique used to modify or extend the behavior of macOS applications by injecting dynamic libraries (`dylibs`) into their address space. This can be a powerful tool for reverse engineering, debugging, or even security research. In this guide, we'll walk through the process of injecting a `dylib` into a `macOS` application.

We will explore two different techniques for injecting a dynamically linked library (`dylib`) into an application:

- `DYLD_INSERT_LIBRARIES Injection`
- `DYLIB Hijacking`

We will ultimately leverage this to run in the application's context, which will provide us rights that we didn't necessarily have before.

## Prerequisites

Before we begin, make sure you have the following:

- `macOS` development environment.
- Knowledge of `C/C++` programming.
- `Xcode` or a compatible development environment.
- The target `macOS` application for injection.

## Step 1: Identify Target Application

Identify the `macOS` application you want to inject a dylib into. You'll need the full path to the application binary (e.g., `/Applications/TargetApp.app/Contents/MacOS/TargetApp`).

## Step 2: Create the Dylib

### Create a new `Xcode` project for a Command Line Tool

### Write your dylib code in C/C++

Let's make a short dynamic library that we can inject into a target application. The library will print to the standard output and generate a log message as well.

#### DYLD_INSERT_LIBRARIES Injection in macOS

The `DYLD_INSERT_LIBRARIES` injection technique is a very old and classic technique on macOS. It’s similar to the `LD_PRELOAD1` method.

`DYLD_INSERT_LIBRARIES` is an environment variable that instructs the dyld dynamic library loader to load any `dylib` before the main application starts. The loaded `dylib` will run in the context of the application we are targeting.

```c
#include <stdio.h>
#include <syslog.h>

__attribute__((constructor))
static void myconstructor(int argc, const char **argv)
{
     printf("[+] dylib constructor called from %s\n", argv[0]);
     syslog(LOG_ERR, "[+] dylib constructor called from %s\n", argv[0]);
}
```

The `__attribute__((constructor))` is a `GCC` specific syntax that instructs the compiler to treat the next function as a constructor. When the dynamic loader loads the compiled binary, it will run the function specified under the constructor.

Use `gcc` to compile the dynamic library. The `-dynamiclib` option will compile the file as a `dylib` instead of a `Mach-O` executable. The `-o` option specifies the name of the output file.

```shell
gcc -dynamiclib example.c -o example.dylib
```

Let's create a simple "Hello World" application in `C`, compile it with `gcc`, run it, and inject the dynamic library into this application.

```c
#include <stdio.h>
int main()
{
   printf("Hello, World!\n");
   return 0;
}
```

```shell
./hello
DYLD_INSERT_LIBRARIES=example.dylib ./hello
```

```shell
DYLD_INSERT_LIBRARIES=example.dylib ./hello 
[+] dylib constructor called from ./hello
Hello, World!
```

#### Monitor log output using the `log` command

```shell
log stream --style syslog --predicate 'eventMessage CONTAINS[c] "constructor"'

Filtering the log data using "composedMessage CONTAINS[c] "constructor""
Timestamp                       (process)[PID]    
2021-01-15 08:35:14.505743-0600  localhost MachOView[94732]: (example.dylib) [+] dylib constructor called from /Applications/MachOView.app/Contents/MacOS/MachOView
```

> This command logs all event messages containing the "constructor" word in the message body. We're using the stream option to view logs from the system continuously, `--style` to specify the formatting, and `--predicate` is a filter we apply to the stream.
{: .prompt-tip }

#### DYLIB Hijacking

A second way of injecting code into a macOS application is by performing dylib hijacking or a dylib proxying attack.

The idea behind this attack is very similar to DLL hijacking1 on Windows. It works by leveraging situations in which we can inject our own dylib when the dynamic loader (dyld) loads the application's shared libraries.

There are two main scenarios in which we can conduct dylib hijacking


### Build the dylib, ensuring it's a dynamic library (`.dylib`)

## Step 3: Inject the Dylib

1. Open Terminal and navigate to the directory where the dylib and target application are located.
2. Use the `DYLD_INSERT_LIBRARIES` environment variable to inject the dylib into the target application. Replace `TargetApp` and `YourDylib.dylib` with the actual names:

   ```shell
   DYLD_INSERT_LIBRARIES=./YourDylib.dylib /Applications/TargetApp.app/Contents/MacOS/TargetApp
   ```

3. The target application will launch with your dylib injected.

## Step 4: Test the Injection

1. Monitor the application for any behavior changes or logs generated by your dylib.
2. Test your code thoroughly to ensure it interacts with the target application as intended.

## Step 5: Cleanup

1. After testing, remember to remove the dylib injection by closing the target application.
2. To revert, simply close the application and remove the dylib from the environment variable:

   ```shell
   DYLD_INSERT_LIBRARIES= /Applications/TargetApp.app/Contents/MacOS/TargetApp
   ```

## Conclusion

Dylib injection is a powerful technique for manipulating macOS applications. However, use it responsibly and only for legitimate purposes like debugging and reverse engineering. Be aware that some applications may have security mechanisms in place to prevent injection.

Remember that unauthorized dylib injection into proprietary applications may violate their terms of service or even legal regulations, so always use this knowledge ethically and within the bounds of the law.
