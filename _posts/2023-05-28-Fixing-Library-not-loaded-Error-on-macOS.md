---
title: Fixing "Library not loaded" Error on macOS 
date: 2016-10-09 11:33:00 +0800
categories: [Blogging, Document]
tags: [MacOS, Darwin, Terminal]
pin: false 
math: true
mermaid: true
image: 
  path: Library-not-loaded.png
  alt: Library not loaded 
---

Have you encountered the `Library not loaded` error on macOS when trying to run a program? This error typically occurs when the dynamic linker (dyld) is unable to find and load a required library at runtime. In this blog post, I'll explore the error message and provide steps to fix it.

For the purpose of this documentation, I will use the `fmt` library to go over the `Library not loaded` issue. The steps and solutions outlined here can be applied to similar situations where a required library fails to load on `macOS`.

## Understanding the Error

The error message usually looks like this:

```bash
dyld[72336]: Library not loaded: /usr/local/opt/fmt/lib/libfmt.9.dylib
  Referenced from: <5429903E-1BD1-355E-89D0-A7EE5FD31EC4> /Users/dede/Code/Github/dotfiles/bin/domain
  Reason: tried: '/usr/local/opt/fmt/lib/libfmt.9.dylib' (no such file),
          '/System/Volumes/Preboot/Cryptexes/OS/usr/local/opt/fmt/lib/libfmt.9.dylib' (no such file),
          ...
```

The key parts of the error message are as follows:

- `Library not loaded`: Indicates that a required library could not be loaded.
- `Referenced from`: Specifies the path to the program that references the missing library.
- `Reason`: Lists the locations where the dynamic linker attempted to find the library but failed.

## Fixing the Error

To fix the `Library not loaded` error, you can follow these steps:

1. **Verify library installation**: Check if the library mentioned in the error message, such as `libfmt.9.dylib`, is installed on your system. Make sure the library file exists in the expected location, usually `/usr/local/opt/fmt/lib/`.

2. **Check library versions**: Ensure that the installed version of the library matches the one expected by the program. In the error message, `libfmt.9.dylib` suggests the program is looking for version 9. Reinstall or update the library if necessary.

3. **Reinstall/update the library**: Use a package manager like Homebrew to reinstall or update the library. Open a terminal and run the following commands:

   ```bash
   brew update
   brew reinstall fmt
   ```

This will update Homebrew and reinstall the `fmt` library, including the required `libfmt.9.dylib`.

4.**Verify library search paths**: Confirm that the program is configured to search for libraries in the correct locations. Update the program's configuration or script to include the expected library search path, if needed.

5.**Update the library reference**: If you have multiple versions of the library installed, ensure that the program references the correct version. Modify the program's configuration or code to reference the appropriate library version.

6.**Check environment variables**: Verify that environment variables, such as `DYLD_LIBRARY_PATH`, are correctly set to include the directory where the library is located. Adjust the environment variables to include the necessary paths.

7.**Restart the program**: After performing the above steps, restart the program that encountered the error. A fresh start can often resolve library loading issues.

By following these steps, you should be able to fix the `Library not loaded` error on macOS and allow the program to load the required library successfully.

## Conclusion

Encountering the `Library not loaded` error on macOS can be frustrating, but with the troubleshooting steps outlined in this blog post, you can overcome the issue. Remember to verify library installation, check versions, reinstall/update the library, update references, adjust search paths, and restart the program.

I hope this guide helps you resolve the error and get your program up and running smoothly!

Happy coding!
