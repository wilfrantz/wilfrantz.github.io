---
title: How to fix "The Default Constructor Cannot Be Referenced -- It Is a Deleted Function" Issue 
date: 2023-06-07 11:33:00 +0800
categories: [Blogging, Doc]
tags: [C++, OOP, Inheritance]
pin: false
math: true
mermaid: true
image: 
  path: use-of-deleted-function.png
  alt: error - use of deleted function  
---

## Introduction

The purpose of this technical document is to provide detailed guidance on fixing the `The default constructor cannot be referenced -- it is a deleted function` issue in C++ programming. This error occurs when the default constructor of a class has been explicitly deleted, preventing its usage. This document will cover various approaches to resolve this issue with code snippets and illustrations.

## Table of Contents

- [Introduction](#introduction)
- [Table of Contents](#table-of-contents)
- [Understanding the Error](#understanding-the-error)
- [Causes of the Issue](#causes-of-the-issue)
- [Resolving the Issue](#resolving-the-issue)
  - [Providing an Alternative Constructor](#providing-an-alternative-constructor)
  - [Removing the Deleted Default Constructor](#removing-the-deleted-default-constructor)
  - [Using Available Constructors](#using-available-constructors)
  - [Modifying the Base Class](#modifying-the-base-class)
  - [Reevaluating Class Design](#reevaluating-class-design)
- [Code Snippets and Illustrations](#code-snippets-and-illustrations)
  - [Example 1: Providing an Alternative Constructor](#example-1-providing-an-alternative-constructor)
  - [Example 2: Removing the Deleted Default Constructor](#example-2-removing-the-deleted-default-constructor)
  - [Example 3: Modifying the Base Class](#example-3-modifying-the-base-class)
- [Conclusion](#conclusion)
- [Resource](#resource)

## Understanding the Error

The error message `The default constructor cannot be referenced -- it is a deleted function` indicates that the default constructor of a class has been explicitly deleted, making it inaccessible for creating objects.

## Causes of the Issue

- Explicit deletion of the default constructor using the `delete` specifier.
- Inheritance from a base class with a deleted default constructor.

## Resolving the Issue

### Providing an Alternative Constructor

If the default constructor is deleted, you can define a <u>parameterized constructor</u> that accepts the necessary arguments to initialize the object. This way, objects can be created using the parameterized constructor instead of the default constructor.

```cpp
class MyClass {
public:
    MyClass(int arg1, double arg2) {
        // Initialize the object with provided arguments
    }
};
```

### Removing the Deleted Default Constructor

If the explicit deletion of the default constructor is not necessary, you can remove the `delete` specifier from the default constructor declaration, restoring its functionality.

```cpp
class MyClass {
public:
    MyClass() = default; // Remove the explicit deletion
};
```

### Using Available Constructors

If other constructors are available in the class, utilize those constructors to create objects instead of relying on the default constructor. Review the available constructors and choose the appropriate one based on the initialization requirements.

### Modifying the Base Class

If the class in question is derived from a base class with a deleted default constructor, ensure that the base class's default constructor is accessible or provide a suitable alternative. Modify the base class as needed to allow object creation.

### Reevaluating Class Design

If the deleted default constructor is intentional and necessary for the class design, carefully consider the usage and ensure that objects are created using appropriate constructors or factory methods provided by the class.

## Code Snippets and Illustrations

### Example 1: Providing an Alternative Constructor

```cpp
class Employee {
public:
    Employee(const std::string& name, int age) {
        // Initialize the employee object with provided values
    }
};

Employee emp("John Doe", 30); // Creating an object using the alternative constructor
```

### Example 2: Removing the Deleted Default Constructor

```cpp
class MyClass {
public:
    MyClass() = default; // Restoring the default constructor
};

MyClass obj; // Creating an object using the default constructor
```

### Example 3: Modifying the Base Class

```cpp
class Base {
public:
    Base() = delete; // Deleted default constructor in

 the base class
};

class Derived : public Base {
public:
    Derived(int value) : Base(), data(value) {
        // Initialize the derived class object
    }

private:
    int data;
};

Derived derivedObj(42); // Creating an object of the derived class
```

## Conclusion

By following the approaches outlined in this technical document, you can effectively resolve the `The default constructor cannot be referenced -- it is a deleted function` issue in your C++ code. Consider the specific context and requirements of your project to choose the most appropriate approach for your situation.

Now that you know how to fix this issue, you can easily avoid it by following [these simple practices](https://dede.dev/posts/Avoid-Default-Constructor-Cannot-Be-Referenced-Issue/){:target="_blank"}.

## Resource

- [The default constructor cannot be referenced.](https://stackoverflow.com/questions/65425572/the-default-constructor-cannot-be-referenced){:target="_blank"}
- ["default constructor cannot be referenced" in Visual Studio 2015.](https://stackoverflow.com/questions/33978185/default-constructor-cannot-be-referenced-in-visual-studio-2015){:target="_blank"}
