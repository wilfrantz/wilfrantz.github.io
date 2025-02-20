---
title: DomainEngine - CMake Configuration 
date: 2015-07-15 11:33:00 +0800
categories: [Blogging, Document]
tags: [Domain, Software, CMake]
pin: false 
math: true
mermaid: true
image: 
---

## Introduction

This document outlines the CMake configuration for the `domainEngine` project, which is version 1.0.2. The project is implemented in C++ and relies on various libraries and packages. The document provides an overview of the CMake configuration, including minimum required versions, project details, package dependencies, compilation options, and target linkage.

## CMake Configuration Details

The following sections provide a breakdown of the CMake configuration based on the provided code snippet.

### Minimum Required Version

The CMake configuration specifies the minimum required version of CMake to be between 3.10 and 3.20.

```cmake
cmake_minimum_required(VERSION 3.10...3.20)
```

### Project Details

The project is implemented using C++.

```cmake
project(domain VERSION 1.0.2 LANGUAGES CXX)
```

### C++ Standard

The CMake configuration sets the C++ standard to 17.

```cmake
set(CMAKE_CXX_STANDARD 17)
```

### Package Dependencies

The project depends on several external packages, which are found using the `find_package()` command.

```cmake
find_package(fmt REQUIRED)
find_package(spdlog REQUIRED)
find_package(CURL REQUIRED)
find_library(JSONCPP_LIBRARIES NAMES jsoncpp)
find_package(Boost REQUIRED COMPONENTS system thread)
```

### Compilation Options

The CMake configuration defines several options that affect the compilation process. These options can be enabled or disabled during the build.

```cmake
OPTION(CMAKE_VERBOSE_MAKEFILE "Enable verbose output from Makefile builds" OFF)
OPTION(BUILD_TESTS "Build tests" ON)
OPTION(CMAKE_VERBOSE_MAKEFILE "Verbose Makefile" ON)
```

### Compilation Definitions

A compile definition is added to the project, specifying the version of the engine as the project version.

```cmake
add_compile_definitions(ENGINE_VERSION="${PROJECT_VERSION}")
```

### Project Sources

The project sources are defined using the `ADD_EXECUTABLE()` command, listing the relevant source files.

```cmake
ADD_EXECUTABLE(${PROJECT_NAME}
    src/main.cpp
    src/domain.cpp
    src/dynadot.cpp
    src/keywords.cpp
    src/misc.cpp
)
```

### macOS Specific Configuration

For macOS, the CMake configuration sets the macOS SDK version to be used.

```cmake
set(CMAKE_OSX_SYSROOT /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX13.3.sdk)
```

### Target Linkage

The target linkage specifies the libraries to be linked with the executable based on the platform.

```cmake
if (UNIX AND NOT APPLE)
    target_link_libraries(${PROJECT_NAME} PRIVATE
        tdjson
        jsoncpp
        fmt::fmt
        spdlog::spdlog
        Boost::system
        Boost::thread
        CURL::libcurl
    )
else(APPLE)
    target_link_libraries(${PROJECT_NAME} PRIVATE
        fmt::fmt
        spdlog::spdlog
        Boost::system
        Boost::thread
        CURL::libcurl
        ${TDJSON_LIBRARIES}
        /usr/local/Cellar/jsoncpp/1.9.5/lib/libjsoncpp.dylib
    )
endif()
```

### Testing (Commented Out)

The CMake configuration includes a section for building tests if the `BUILD_TESTS` option is enabled. However, this section is currently disabled.

```cmake
# if (BUILD_TESTS)
#   message(STATUS "Building tests ...")
#   enable_testing()
#   add_subdirectory(test)
#   add_test(NAME ${PROJECT_NAME}_tests COMMAND test/${PROJECT_NAME}_test)
# endif (BUILD_TESTS)
```

## Conclusion

This design document presents the CMake configuration for the "domain" project. It covers the minimum required version, project details, package dependencies, compilation options, target linkage, and testing configuration. 

With this configuration, the project can be built using CMake, ensuring proper compilation and linkage of the required libraries and dependencies. For more details, see the [source code](https://github.com/wilfrantz/DomainEngine){:target="_blank"} on GitHub. This [document](https://dede.dev/posts/Domain-names-backorder-program/){:target="_blank"} provides an overview of the `domainEngine` project, its purpose, architecture, key components, and design considerations.
