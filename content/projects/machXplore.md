+++
title = "MachXplorer: Mach-O binary analyzer."
date = "2025-02-20"
tags = ["hugo", "blogging", "RE", "macOS"]
+++

[machXplorer](https://github.com/wilfrantz/MachXplorer) MachXplorer is a command-line tool built for analyzing Mach-O binaries on macOS, with a focus on ARM64 architecture. Designed for reverse engineers, security researchers, and developers, MachXplorer helps uncover hidden details within binaries—whether it’s headers, segments, symbols, or obfuscation patterns.

This tool is tailored for those diving deep into macOS internals, providing clear insights into executable structures and potential security threats.

## Features

The tool offers a comprehensive set of features for Mach-O binary analysis, including:

- header analysis to extract and display headers,
- load commands, and entry points;
- segment analysis to examine memory layout, permissions, and unusual flags; and
- symbol analysis to detect hidden functions, obfuscated strings, or stripped symbols.
  
It also provides disassembly for extracting and analyzing executable sections, obfuscation detection to identify common obfuscation patterns or suspicious modifications, and hex dump and string extraction to deliver a formatted hex dump alongside extracted strings.

The binary comparison feature allows users to compare two Mach-O binaries for integrity checks.

### Basic Commands

```sh
# Extract Mach-O headers
./MachXplorer -h file.macho

# Analyze segments
./MachXplorer -s file.macho

# Detect hidden functions or stripped symbols
./MachXplorer -y file.macho

# Disassemble executable sections
./MachXplorer -d file.macho

# Identify obfuscation techniques
./MachXplorer -o file.macho

# Display formatted hex dump with extracted strings
./MachXplorer -x file.macho

# Compare two binaries for differences
./MachXplorer -c file1.macho file2.macho
```

## Links

- Source code: [machXplorer](https://github.com/wilfrantz/MachXplorer)
- Website (Coming soon): [machExplorer.com](https://machExplorer.com)
