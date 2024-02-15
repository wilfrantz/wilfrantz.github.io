---
title: Homebrew vs. MacPorts, A Systems Software Engineer's Perspective 
date: 2019-01-25 11:33:00 +0800
categories: [Blog]
tags: [MacOS, Darwin, Unix, XNU, homebrew, macports]
pin: false
math: true
mermaid: true
image:
---


As a systems software engineer navigating the macOS ecosystem, the choice between package managers is crucial. Homebrew and MacPorts are two of the most popular options, each with its own philosophy, strengths, and quirks. In this blog post, we'll dive into the world of Homebrew and MacPorts, providing practical examples to help you make an informed choice.

Table of Content

- [Understanding the Basics](#understanding-the-basics)
  - [1. Homebrew](#1-homebrew)
  - [2. MacPorts](#2-macports)
- [Installation](#installation)
  - [Homebrew](#homebrew)
  - [MacPorts](#macports)
- [Package Availability](#package-availability)
- [Package Management](#package-management)
  - [Homebrew](#homebrew-1)
  - [MacPorts](#macports-1)
- [Conflict Resolution](#conflict-resolution)
  - [Homebrew](#homebrew-2)
  - [MacPorts](#macports-2)
- [Conclusion](#conclusion)

## Understanding the Basics

Before we jump into the comparison, let's establish some foundational knowledge:

### 1. Homebrew

- Philosophy: Homebrew follows the "keep it simple" approach. It installs packages into its own directory (`/usr/local`) and relies on `symlinks` to make them available.

- Language: `Brew` is written in Ruby, making it easy for users to contribute packages and formulas.

### 2. MacPorts

- Philosophy: MacPorts aims for a complete separation of packages from `macOS` system libraries, often referred to as the "self-contained" approach.

- Language: MacPorts uses its own domain-specific language called `Tcl` for portfiles, which describe how software should be built and installed.

## Installation

### Homebrew

Installing Homebrew is a breeze. Open your terminal and run:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### MacPorts

MacPorts also offers straightforward installation. Visit the [official website](https://www.macports.org/install.php){: target="_blank" }, download the installer, and follow the instructions.

## Package Availability

When it comes to available packages, Homebrew typically has the edge in terms of sheer numbers. It boasts a vast community-contributed repository, making it a go-to choice for popular software. For instance, installing `Git` is as simple as:

```shell
brew install git
```

MacPorts, while having an extensive collection of packages, might not have the latest versions for some software. However, it excels in providing less common or specialized software. To install Git with MacPorts:

```shell
sudo port install git
```

## Package Management

### Homebrew

Homebrew emphasizes simplicity. Updating packages is as easy as:

```shell
brew update
brew upgrade
```

Removing a package is equally straightforward:

```shell
brew uninstall package_name
```

### MacPorts

MacPorts' approach is more structured. To update all installed ports:

```shell
sudo port selfupdate
sudo port upgrade outdated
```

Uninstalling a port is done using:

```shell
sudo port uninstall port_name
```

## Conflict Resolution

This is where the two package managers differ significantly.

### Homebrew

Homebrew relies on symlinks in `/usr/local` and can occasionally run into issues if you have conflicting software already installed on your system. It might require extra effort to resolve such conflicts.

### MacPorts

MacPorts' self-contained approach minimizes conflicts. It isolates packages from macOS system libraries, reducing the likelihood of clashes.

## Conclusion

The choice between `Homebrew` and `MacPorts` ultimately depends on your preferences and requirements as a systems software engineer.

- Choose Homebrew if you prioritize simplicity and want access to a wide range of up-to-date packages. It's great for everyday software needs and if you prefer working with Ruby.

- Opt for MacPorts if you need a more controlled environment and want to avoid potential conflicts with macOS system libraries. It's suitable for specialized or less common software needs and if you're comfortable with `Tcl`.

In practice, many engineers use both package managers to combine the strengths of each. For instance, use Homebrew for common software and MacPorts for specialized projects.

The choice is yours, and the good news is that macOS provides flexibility for both options. Experiment with both Homebrew and MacPorts, and find the mix that best suits your systems engineering needs.
