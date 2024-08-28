---
title: Compiled Library vs Header Library 
date: 2023-05-15 11:33:00 +0800
categories: [Blogging, Tutorial]
tags: [C++, Library, SWE]
pin: false 
math: true
mermaid: true
image: 
---

When it comes to developing software, especially in C and C++ programming languages, the use of libraries is crucial for code reusability and efficiency. Two common types of libraries used in these languages are compiled libraries and header libraries. Both serve different purposes and have their own advantages and disadvantages. In this blog post, we'll delve into the differences between compiled libraries and header libraries to better understand when and how to use each.

## Comparison between Compiled Libraries and Header Libraries

| Aspect                 | Compiled Libraries                   | Header Libraries                 |
|------------------------|--------------------------------------|----------------------------------|
| **Efficiency**         | High                                 | Moderate                         |
| **Portability**        | High (Precompiled binary code)       | Moderate (Requires source code) |
| **Encapsulation**      | High (Internal details hidden)       | Moderate (Interface exposed)     |
| **Flexibility**        | Low (Limited customization)          | High (Can modify source code)   |
| **Dependency Management** | Low (Compiled into executable)     | High (Need to include header files) |
| **Dynamic Linking**    | No                                   | Yes                              |
| **Compilation Overhead**| Yes                                  | No                               |
| **Compatibility Issues**| Possible                             | Less likely                      |
| **Compilation Time**   | Low                                  | Moderate (May increase)          |

Table of content

- [Comparison between Compiled Libraries and Header Libraries](#comparison-between-compiled-libraries-and-header-libraries)
- [Compiled Libraries](#compiled-libraries)
  - [Advantages of Compiled Libraries](#advantages-of-compiled-libraries)
  - [Disadvantages of Compiled Libraries](#disadvantages-of-compiled-libraries)
  - [Compiled Library Example](#compiled-library-example)
- [Header Libraries](#header-libraries)
  - [Advantages of Header Libraries](#advantages-of-header-libraries)
  - [Disadvantages of Header Libraries](#disadvantages-of-header-libraries)
  - [Header Library Example](#header-library-example)
- [Conclusion](#conclusion)

## Compiled Libraries

Compiled libraries, also known as object libraries or static libraries, are collections of precompiled binary code that can be linked directly into an executable during the compilation phase of software development. These libraries typically have a file extension such as `.lib` on Windows or `.a` on Unix-like systems.

### Advantages of Compiled Libraries

1. **Efficiency**: Since compiled libraries are precompiled into machine code, they offer efficient execution at runtime.
2. **Portability**: Once compiled, the library can be easily distributed and used on different platforms without requiring access to the source code.
3. **Encapsulation**: The internal implementation details of the library are hidden from the user, providing a clean interface and promoting modularity in software design.

### Disadvantages of Compiled Libraries

1. **Compilation Overhead**: Each time the library is updated or modified, it needs to be recompiled, which can introduce overhead in the development process.
2. **Compatibility Issues**: Different versions of the library might not be compatible with each other, leading to potential conflicts and difficulties in managing dependencies.
3. **Limited Flexibility**: Users cannot modify the source code of a compiled library directly, limiting customization options.

### Compiled Library Example

```c++
// CompiledLibrary.cpp

#include <iostream>

// Function declaration in header file
extern void myFunction();

int main() {
    std::cout << "Using compiled library..." << std::endl;
    
    // Call function from compiled library
    myFunction();

    return 0;
}
```

```c++
// CompiledLibrary.h

#ifndef COMPILED_LIBRARY_H
#define COMPILED_LIBRARY_H

// Function declaration
void myFunction();

#endif // COMPILED_LIBRARY_H
```

```c++
// CompiledLibraryImpl.cpp

#include "CompiledLibrary.h"
#include <iostream>

// Function definition
void myFunction() {
    std::cout << "This is myFunction from the compiled library." << std::endl;
}
```

In this example, `CompiledLibrary.cpp` is the main file that uses the compiled library. The function `myFunction()` is declared in `CompiledLibrary.h`, and its implementation is provided in `CompiledLibraryImpl.cpp`. The compiled library is linked with `CompiledLibrary.cpp` during the compilation process.

## Header Libraries

Header libraries, also known as header files or interface libraries, contain declarations of functions, constants, and data types that are used by the application code. These declarations serve as an interface between the application code and the actual implementation provided by the library. Header files typically have a `.h` extension.

### Advantages of Header Libraries

1. **Flexibility**: Header files allow developers to see the interface of the library and understand how to use it without exposing the internal implementation details.
2. **Ease of Development**: By including header files in their code, developers can use functions and data types provided by the library without worrying about the implementation details.
3. **Dynamic Linking**: Header libraries are often used in conjunction with dynamic linking, allowing the library code to be loaded into memory at runtime, which can reduce the size of the executable file and allow for easier updates.

### Disadvantages of Header Libraries

1. **Dependency Management**: Developers need to ensure that the appropriate header files are included and that the library is properly linked during the compilation process.
2. **Potential Name Clashes**: If multiple libraries use the same function or data type names, conflicts can arise when including their respective header files.
3. **Increased Compilation Time**: Including header files in the source code can increase compilation time, especially for large projects with many dependencies.

### Header Library Example

```c++
// HeaderLibrary.cpp

#include <iostream>
#include "HeaderLibrary.h"

int main() {
    std::cout << "Using header library..." << std::endl;
    
    // Call function from header library
    myFunction();

    return 0;
}
```

```c++
// HeaderLibrary.h

#ifndef HEADER_LIBRARY_H
#define HEADER_LIBRARY_H

// Function declaration
void myFunction();

#endif // HEADER_LIBRARY_H
```

```c++
// HeaderLibraryImpl.cpp

#include "HeaderLibrary.h"
#include <iostream>

// Function definition
void myFunction() {
    std::cout << "This is myFunction from the header library." << std::endl;
}
```

In this example, `HeaderLibrary.cpp` is the main file that uses the header library. The function `myFunction()` is declared in `HeaderLibrary.h`, and its implementation is provided in `HeaderLibraryImpl.cpp`. The header library is included directly in `HeaderLibrary.cpp`, and no separate linking step is required.

## Conclusion

In summary, both compiled libraries and header libraries play important roles in software development. Compiled libraries offer efficiency and encapsulation but may require recompilation and can lead to compatibility issues.

On the other hand, header libraries provide flexibility and ease of development but require careful dependency management and can increase compilation time. Ultimately, the choice between compiled and header libraries depends on the specific requirements and constraints of the project at hand.
