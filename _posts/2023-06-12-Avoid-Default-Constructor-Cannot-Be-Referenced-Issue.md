---
title: How to Avoid "The Default Constructor Cannot Be Referenced -- It Is a Deleted Function" Error in C++
date: 2023-06-12 11:33:00 +0800
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

In C++, the error message `The Default Constructor Cannot Be Referenced -- It Is a Deleted Function` can occur when working with derived classes and base classes. This technical document provides insights into this scenario and offers strategies to avoid the issue in C++ programming.

## Table of Contents

- [Introduction](#introduction)
- [Table of Contents](#table-of-contents)
- [Understanding the "Default Constructor Cannot Be Referenced" Error](#understanding-the-default-constructor-cannot-be-referenced-error)
- [Handling Derived Classes and Base Classes](#handling-derived-classes-and-base-classes)
- [Avoiding the Issue](#avoiding-the-issue)
  - [Define a Default Constructor](#define-a-default-constructor)
  - [Avoid Deleting the Default Constructor](#avoid-deleting-the-default-constructor)
  - [Provide Non-Default Constructors](#provide-non-default-constructors)
  - [Use Initialization Lists](#use-initialization-lists)
  - [Inheriting Constructors](#inheriting-constructors)
  - [Explicitly Defining Constructors](#explicitly-defining-constructors)
- [Conclusion](#conclusion)

## <a name="understanding-the-default-constructor-cannot-be-referenced-error">Understanding the "Default Constructor Cannot Be Referenced" Error</a>

The error message `The Default Constructor Cannot Be Referenced -- It Is a Deleted Function` indicates that the default constructor of a class has been explicitly deleted, making it inaccessible for creating objects. It can occur when working with derived classes and base classes in C++. In which scenario it indicates that the default constructor of the base class is not accessible or deleted, preventing the derived class from using it.

## <a name="handling-derived-classes-and-base-classes">Handling Derived Classes and Base Classes</a>

In C++, `when a derived class is created, it implicitly calls the default constructor of its base class`. If the default constructor of the base class is not available or explicitly deleted, attempting to create objects of the derived class will result in the `Default Constructor Cannot Be Referenced` error.

## <a name="avoiding-the-issue">Avoiding the Issue</a>

To avoid the "<u>Default Constructor Cannot Be Referenced</u>" error in scenarios involving derived classes and base classes, consider the following strategies:

### <a name="define-a-default-constructor">Define a Default Constructor</a>

If your class lacks a default constructor, define one explicitly. A default constructor has no parameters or has all parameters with default values. By providing a default constructor, you allow the creation of objects without arguments, preventing the error. Here's an example:

```c++
   class MyClass {
   public:
       MyClass() {
           // Default constructor implementation
       }
   };
```

### <a name="avoid-deleting-the-default-constructor">Avoid Deleting the Default Constructor</a>

If you have explicitly deleted the default constructor in your class declaration, remove the deleted function declaration. When a constructor is deleted using the `= delete` syntax, it prevents the compiler from generating a default constructor. By removing this deletion, the default constructor will be available again.

### <a name="provide-non-default-constructor">Provide Non-Default Constructors</a>

If your class has constructors with parameters only, ensure that you always provide the necessary arguments when creating objects. This approach avoids relying on the default constructor and eliminates the error. Example:

```c++
   class MyClass {
   public:
       MyClass(int value) {
           // Constructor implementation
       }
   };
   
   int main() {
       MyClass obj(42); // Creating an object using the non-default constructor
       // Rest of the code
       return 0;
   }
```

### <a name="use-initialization-lists">Use Initialization Lists</a>

> In `C++`, references must be initialized upon declaration and cannot be left uninitialized.
{: .prompt-tip}

If you have a non-default constructor that initializes member variables, ensure that you use [initialization lists](https://dede.dev/posts/Advanced-Technical-Guide-to-Initialization-Lists-in-C++/){:target="_blank"} to assign values to these variables. Initialization lists provide a way to initialize member variables before the body of the constructor is executed. By using initialization lists, you can avoid relying on the default constructor. Example:

```c++
   class MyClass {
   private:
       int value;
   
   public:
       MyClass(int newValue) : value(newValue) {
           // Constructor implementation
       }
   };
```

### <a name="inheriting-constructors">Inheriting Constructors</a>

In `C++11` and later versions, you can use the "<u>inheriting constructors</u>" feature to automatically inherit constructors from the base class. By adding `using BaseClass::BaseClass;` in the derived class, the constructors of the base class become accessible. This allows the derived class to utilize the constructors of the base class. For example:

```c++
class BaseClass {
public:
    BaseClass(int value) {
        // Constructor implementation
    }
};

class DerivedClass : public BaseClass {
public:
    using BaseClass::BaseClass; // Inherit constructors from BaseClass
};
```

This way, the derived class can use the constructors of the base class, including the default constructor if available.

### <a name="explicitly-defining-constructors">Explicitly Defining Constructors</a>

Alternatively, you can explicitly define constructors in both the derived class and the base class. This allows you to control the initialization of the derived class while ensuring that the base class is properly constructed. For example:

```c++
class BaseClass {
public:
    BaseClass(int value) {
        // Constructor implementation
    }
};

class DerivedClass : public BaseClass {
public:
    DerivedClass(int value) : BaseClass(value) {
        // Derived class constructor implementation
    }
};
```

By explicitly defining the constructors, you can ensure that the base class is properly initialized while providing additional functionality specific to the derived class.

## <a name="conclusion">Conclusion</a>

By understanding the scenarios involving derived classes and base classes, and applying the appropriate strategies, you can avoid the `The Default Constructor Cannot Be Referenced -- It Is a Deleted Function` issue in C++.

Inheriting constructors or explicitly defining constructors in both the derived class and the base class enable proper initialization and ensure the constructors are accessible for object creation. Following these simple practices enhances the reliability and flexibility of your C++ programs.
