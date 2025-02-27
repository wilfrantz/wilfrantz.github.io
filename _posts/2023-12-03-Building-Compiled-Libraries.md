---
title: Mastering C/C++ Library Development and Build Management with CMake
date: 2020-06-05 11:33:00 +0800
categories: [Blog]
tags: [Library, C++, SWE]
pin: false
math: true
mermaid: true
image: 
---

When working on large `C/C++` projects or creating reusable code, building compiled libraries is a common practice. Compiled libraries allow you to encapsulate functionality and data structures into reusable modules that can be easily linked into other programs.

In this blog post, we'll walk you through the process of building a compiled library in `C/C++` and show you how to prepare a `CMakeLists.txt` file to manage the build process.

Table of Contents

- [Building a Compiled Library](#building-a-compiled-library)
  - [Step 1: Write Your Library Code](#step-1-write-your-library-code)
  - [Step 2: Compile Source Files](#step-2-compile-source-files)
  - [Step 3: Create the Library](#step-3-create-the-library)
  - [Step 4: Install the Library (Optional)](#step-4-install-the-library-optional)
    - [Manual installation (recommended)](#manual-installation-recommended)
      - [Update the Linker Configuration](#update-the-linker-configuration)
      - [Linking Against the Static Library](#linking-against-the-static-library)
      - [Including Headers](#including-headers)
    - [Using a Package Manager](#using-a-package-manager)
      - [Create a Package](#create-a-package)
      - [Build the `.deb` package](#build-the-deb-package)
      - [Install the Package](#install-the-package)
      - [Linking Against the Static Library](#linking-against-the-static-library-1)
      - [Include the header files](#include-the-header-files)
- [Preparing a CMakeLists.txt File](#preparing-a-cmakeliststxt-file)
  - [Step 1: Create a CMakeLists.txt File](#step-1-create-a-cmakeliststxt-file)
  - [Step 2: Set Minimum CMake Version](#step-2-set-minimum-cmake-version)
  - [Step 3: Define Your Project](#step-3-define-your-project)
  - [Step 4: Specify Source Files](#step-4-specify-source-files)
  - [Step 5: Specify Header Files](#step-5-specify-header-files)
  - [Step 6: Install Headers (Optional)](#step-6-install-headers-optional)
  - [Step 7: Install the Library (Optional)](#step-7-install-the-library-optional)
  - [Step 8: Export the Library (Optional)](#step-8-export-the-library-optional)
  - [Step 9: Generate Build Files](#step-9-generate-build-files)
  - [Step 10: Build Your Library](#step-10-build-your-library)
- [Conclusion](#conclusion)

## Building a Compiled Library

---

### Step 1: Write Your Library Code

Start by writing the code for your library. This can include functions, classes, or any code you want to reuse in multiple programs. Organize your code into source files (.c or .cpp) and header files (.h) for clear separation of interface and implementation.

### Step 2: Compile Source Files

Compile your source files into object files (.o or .obj). You can do this using a `C/C++` compiler. For example, if you have two source files, `file1.cpp` and `file2.cpp`, you can compile them as follows:

For C++ code:

```bash
g++ -c file1.cpp file2.cpp -o mylibrary.o
```

This will create separate object files for each source file.

### Step 3: Create the Library

To create a library file, you can use the `ar` (Archive) tool for static libraries (.a on Unix-based systems) or the compiler to create shared libraries (.so or .dll on Unix-based and Windows systems, respectively).

For a static library (Unix):

```bash
ar rcs libmylibrary.a mylibrary.o
```

For a shared library (Unix):

```bash
g++ -shared -o libmylibrary.so mylibrary.o
```

For a shared library (Windows):

```bash
g++ -shared -o mylibrary.dll mylibrary.o
```

### Step 4: Install the Library (Optional)

If you want to make your library available system-wide, you can install it using platform-specific package management tools or by manually copying it to system directories.

#### Manual installation (recommended)

- To manually make the library available system-wide, you need to copy it to a standard location where the linker can find it, such as `/usr/local/lib` or `/usr/lib`. It's generally recommended to use `/usr/local/lib` for libraries that are not managed by the system's package manager.

```bash
sudo cp libmylib.a /usr/local/lib
```

##### Update the Linker Configuration

After copying the library, you need to inform the linker about the new library path. This is done by adding the path to the `/etc/ld.so.conf` file or a new file in the `/etc/ld.so.conf.d/` directory.

Create a new file named `mylib.conf` in `/etc/ld.so.conf.d/`:

```bash
echo "/usr/local/lib" | sudo tee /etc/ld.so.conf.d/mylib.conf
```

Then, run `ldconfig` (`ld` on macOS) to update the linker cache:

```bash
sudo ldconfig
```

on MacOS, Consult the ld man page (`man ld`) for detailed information.

##### Linking Against the Static Library

Now that your static library is available system-wide, you can link against it when compiling your programs. Use the `-l` option with the `gcc` or `g++` command, omitting the lib prefix and the `.a` suffix from the library name. For example:

```bash
gcc -o myprogram myprogram.c -lmylib
```

##### Including Headers

If your static library comes with header files, you should also place these in a standard location, like `/usr/local/include`, so that they can be easily included in programs that use your library.

```bash
sudo cp mylib.h /usr/local/include
```

#### Using a Package Manager

##### Create a Package

The next step is to package your static library. Different Linux distributions use different package managers (like `apt` for Debian-based systems, `yum` or `dnf` for Red Hat-based systems, etc.), and each has its own packaging format (`.deb`, `.rpm`, etc.). We'll use Debian's `.deb` format as an example.

Create a directory structure for your package:

```bash
mkdir -p mylib-package/DEBIAN
mkdir -p mylib-package/usr/local/lib
mkdir -p mylib-package/usr/local/include
```

Copy your library and header files to the respective directories:

```bash
cp libmylib.a mylib-package/usr/local/lib/
cp mylib.h mylib-package/usr/local/include/
```

Create a control file inside the DEBIAN directory with necessary package information:

```bash
echo "Package: mylib\nVersion: 1.0\nSection: custom\nPriority: optional\nArchitecture: all\nEssential: no\nInstalled-Size: 1024\nMaintainer: Your Name\nDescription: My custom static library" > mylib-package/DEBIAN/control
```

##### Build the `.deb` package

```bash
dpkg-deb --build mylib-package
```

##### Install the Package

```bash
sudo dpkg -i mylib-package.deb
```

Alternatively, if you wish to distribute your library, you can host it on a repository or share the `.deb` file for others to download and install.

##### Linking Against the Static Library

After installation, link against your static library when compiling programs:

```bash
gcc -o myprogram myprogram.c -L/usr/local/lib -lmylib
```

##### Include the header files

```c++
#include <mylib.h>
```

## Preparing a CMakeLists.txt File

---

CMake is a powerful tool for managing the build process of C/C++ projects, including compiled libraries. Here's how to prepare a `CMakeLists.txt` file for your library:

### Step 1: Create a CMakeLists.txt File

In your library's project directory, create a `CMakeLists.txt` file. This file will contain instructions for CMake on how to build your library.

### Step 2: Set Minimum CMake Version

Start your CMakeLists.txt file by specifying the minimum required CMake version. This ensures that users with older versions of CMake are aware of the compatibility requirements.

```cmake
cmake_minimum_required(VERSION 3.0)
```

### Step 3: Define Your Project

Define your project with a name and version.

```cmake
project(mylibrary VERSION 1.0)
```

### Step 4: Specify Source Files

List the source files for your library. You can use the add_library command to create the library from these source files.

```cmake
add_library(mylibrary
    file1.cpp
    file2.cpp
)
```

### Step 5: Specify Header Files

Specify the header files that are part of your library. This helps CMake organize your project and allows users of your library to find and include the headers.

```cmake
target_include_directories(mylibrary
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)
```

### Step 6: Install Headers (Optional)

If you want to make the header files of your library available to other projects, you can install them.

```cmake
install(FILES file1.h file2.h
    DESTINATION include/mylibrary
)
```

### Step 7: Install the Library (Optional)

If you want to install your library along with the header files, you can do so with the following command.

```cmake
install(TARGETS mylibrary
    DESTINATION lib
)
```

### Step 8: Export the Library (Optional)

If your library is intended to be used as a dependency in other CMake projects, you can export it.

```cmake
export(TARGETS mylibrary FILE MyLibraryConfig.cmake)
```

With this, other CMake projects can easily find and link against your library.

### Step 9: Generate Build Files

Now that your CMakeLists.txt file is ready, you can generate the build files using the cmake command.

```bash
mkdir build
cd build
cmake ..
```

This will generate the appropriate build files for your platform and build system.

### Step 10: Build Your Library

Finally, build your library using your chosen build system. For example, if you're on a Unix-based system with Makefiles generated by CMake, run:

```bash
make
```

Your compiled library will be created in the build directory.

## Conclusion

Building a compiled library in C/C++ allows you to create reusable code that can be easily incorporated into other projects. By preparing a CMakeLists.txt file, you can effectively manage the build process and make your library accessible to other developers. With these steps, you're well on your way to creating and sharing powerful C/C++ libraries. Happy coding!
