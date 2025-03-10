---
title: MachXplorer
date: 2025-03-10
layout: post
description: Mach-O Binary Loader & Analyzer.
---

### Mach-O Binary Analyzer for macOS


 CLI tool for deep analysis of Mach-O binaries on macOS, offering reverse engineers and security researchers insights into ARM64 executables through header inspection, disassembly, and obfuscation detection.

[![GitHub Stars](https://img.shields.io/github/stars/wilfrantz/MachXplorer?style=flat-square)](https://github.com/wilfrantz/MachXplorer){:target="_blank"}
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT){:target="_blank"}

---

## 🛠 Features

| Option                | Flag                | Description                                             |
| --------------------- | ------------------- | ------------------------------------------------------- |
| Header Analysis       | `-h, --header`      | Inspect Mach-O headers, load commands, and entry points |
| Segment Analysis      | `-s, --segment`     | Analyze memory layout, permissions, and unusual flags   |
| Symbol Analysis       | `-y, --symbol`      | Detect hidden functions and stripped symbols            |
| Disassembly           | `-d, --disassembly` | Examine executable sections with ARM64 disassembly      |
| Obfuscation Detection | `-o, --obfuscation` | Identify common obfuscation patterns                    |
| Hex & Strings         | `-x, --hex`         | Generate formatted hex dumps with string extraction     |
| Binary Comparison     | `-c, --compare`     | Diff two Mach-O binaries for integrity checks           |

## 📦 Installation

### Prerequisites

- macOS (ARM64 compatible)
- Xcode Command Line Tools
- `otool` and `llvm-objdump` (install via [Homebrew](https://brew.sh/)):

  ```sh
  brew install llvm
  ```

### Build from Source

```sh
git clone https://github.com/wilfrantz/MachXplorer.git
cd MachXplorer
mkdir build && cd build
cmake ..
cmake --build . --config Release
```

## 🚀 Usage

```sh
# Basic header inspection
./MachXplorer -h suspicious_binary.macho

# Full analysis workflow
./MachXplorer -hsydo complex_binary.macho

# Compare two versions
./MachXplorer -c original.macho modified.macho
```

## 🔍 Resource Guide

### Key macOS Headers

```sh
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/mach-o/
```

| Header File | Purpose                        |
| ----------- | ------------------------------ |
| `loader.h`  | Mach-O load command structures |
| `nlist.h`   | Symbol table entry definitions |
| `fat.h`     | Universal binary format        |

## 🗺 Roadmap

- [ ] Universal binary support
- [ ] Automated suspicious pattern detection
- [ ] IDA Pro integration plugin
- [ ] Entitlements analysis module

## 🤝 Contributing

We welcome contributions through:

- Issue reporting
- Pull requests
- Feature proposals

