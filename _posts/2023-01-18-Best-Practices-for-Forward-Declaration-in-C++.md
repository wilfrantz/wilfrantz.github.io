---
title: Best Practices for Forward Declaration in C++
date: 2023-01-18 11:33:00 +0800
categories: [Blogging, Doc]
tags: [C++, OOP]
pin: false
math: true
mermaid: true
---

Forward declaration is a powerful technique in `C++` that allows you to declare a class, function, or template without providing its full definition. It is particularly useful for improving compile times, reducing dependencies, and resolving circular dependencies. In this article, we will discuss best practices for using forward declaration effectively.

Table of contents

- [Declaration vs. Definition](#declaration-vs-definition)
- [Use Forward Declaration Instead of `#include`](#use-forward-declaration-instead-of-include)
- [Place Forward Declarations in Separate Header Files](#place-forward-declarations-in-separate-header-files)
- [Forward Declare Templates](#forward-declare-templates)
- [Use Forward Declarations in Header Files](#use-forward-declarations-in-header-files)
- [Include Full Definitions in Source Files](#include-full-definitions-in-source-files)
- [Avoid Forward Declaring Standard Library Entities](#avoid-forward-declaring-standard-library-entities)
- [Conclusion](#conclusion)
- [Resources](#resources)

## Declaration vs. Definition

Before diving into the best practices, let's clarify the difference between declaration and definition:

- **Declaration**: A declaration introduces the name and type of a variable, function, or class to the compiler. It tells the compiler that the entity exists, but it does not provide the details of its implementation. Declarations typically appear in header files or at the beginning of a code file.

- **Definition**: A definition provides the actual implementation or memory allocation for a declared entity. It includes the complete details of how the entity behaves and is typically placed in source files (.cpp files) or within a class or function body.

<u>Forward declaration is simply a way to provide a declaration without the full definition</u>. It informs the compiler about the existence and type of an entity before its full definition is encountered. This allows you to use the entity in your code without needing to know all the implementation details.

## Use Forward Declaration Instead of `#include`

When you only need to declare a class or function in a header file, prefer using forward declaration instead of including the entire header file. This helps to minimize dependencies and reduces compilation times, especially when dealing with large codebases.

Suppose you have a class called `MyClass` defined in a header file `MyClass.h`, and you only need to use a pointer to `MyClass` in another header file. Instead of including the entire `MyClass.h` header, you can forward declare the class:

`MyClass.h`

```cpp
#pragma once

class MyClass {
    // Class definition here
};
```

`AnotherClass.h`

```cpp
#pragma once

// Forward declaration of MyClass
class MyClass;

class AnotherClass {
    MyClass* myClassPtr;  // Using a pointer to MyClass
};
```

By forward declaring `MyClass` in `AnotherClass.h`, you avoid including the full definition of `MyClass` and reduce unnecessary dependencies in the codebase. This can lead to improved compilation times and better code organization.

## Place Forward Declarations in Separate Header Files

To improve code organization and maintainability, consider placing forward declarations in separate header files. By doing so, you create a clear separation between the declarations and the definitions, making it easier to manage and understand the codebase.

For example, you can create a header file `MyClassForward.h` to contain all the forward declarations for a class called `MyClass`:

```cpp
// MyClassForward.h

#pragma once

class MyClass;
```

## Forward Declare Templates

When dealing with template classes or functions, it's important to forward declare them correctly. To forward declare a template class, you need to provide the template parameter(s) along with the class name.

For example, to forward declare a template class `MyTemplateClass` with a single template parameter:

```cpp
template <typename T>
class MyTemplateClass;
```

## Use Forward Declarations in Header Files

In header files, prefer forward declarations whenever possible to reduce the number of unnecessary includes in other files. This can significantly improve compilation times, as including unnecessary headers can result in a lot of redundant code being compiled.

However, be cautious when forward declaring in header files if you need the full definition of a class or function, as it may lead to incomplete types and compilation errors.

## Include Full Definitions in Source Files

In source files, include the necessary header files that provide the full definitions of the forward-declared entities. This ensures that the compiler has access to the complete information needed for proper type checking and code generation.

By including the necessary headers in source files rather than header files, you keep the dependencies contained within the implementation files, minimizing the impact on the overall codebase.

## Avoid Forward Declaring Standard Library Entities

Avoid forward declaring entities from the C++ standard library, such as classes or functions from the `std` namespace. Instead, include the appropriate standard library headers directly, as they are designed to be included and provide the necessary declarations.

## Conclusion

Forward declaration is a powerful technique in `C++` that can greatly improve code organization, reduce compilation times, and manage dependencies. By following these best practices, you can effectively use forward declaration in your codebase and harness its benefits. Remember to strike a balance between forward declarations and including full definitions to ensure proper type checking and avoid compilation errors.

## Resources

- [Why forward-declare is necessary in C++](https://stackoverflow.com/questions/4757565/what-are-forward-declarations-in-c){:target="_blank"}
