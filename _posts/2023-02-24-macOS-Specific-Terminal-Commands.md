---
title: macOS Specific Terminal Commands
date: 2023-02-24 11:33:00 +0800
categories: [Note, Doc]
tags: [MacOS, Unix, Darwin]
pin: false 
math: true
mermaid: true
image:
  path: MacOS-Terminal.png
  alt: MacOS Terminal
---


Apple's `macOS` operating system, built on a Unix foundation, offers a rich set of command-line utilities. While many commands are shared with other Unix-based systems, `macOS` brings its unique set of tools tailored for its environment. This article focuses on some macOS-specific terminal commands.

Table of Contents:

- [System Information Commands](#system-information-commands)
- [File Management and Spotlight](#file-management-and-spotlight)
- [Disk Utility Commands](#disk-utility-commands)
- [Network Utility Commands](#network-utility-commands)
- [Software Management](#software-management)
- [User and Group Management](#user-and-group-management)
- [Conclusion](#conclusion)

The power of macOS's Unix foundation shines when delving into Terminal commands. Let's uncover more macOS-specific commands to assist with various tasks.

## System Information Commands

- `sw_vers`: Display macOS version details.
- `system_profiler`: Detailed report about hardware and software.
- `hostinfo`: Summary of system configuration.

## File Management and Spotlight

- `mdfind`: Search using the Spotlight index.
- `mdls`: List metadata attributes for a file.
- `SetFile and GetFileInfo`: Change and view file attributes.
  - View file info:

    ```shell
    GetFileInfo /path/to/file
    ```

  - Hide a file in Finder:

    ```shell
    SetFile -a V /path/to/file
    ```

## Disk Utility Commands

- `diskutil`: Manage disks and volumes.
- `hdiutil`: Work with disk images (ISO, DMG).
  - Mount a disk image:

    ```shell
    hdiutil mount /path/to/diskimage.dmg
    ```

## Network Utility Commands

- `networksetup`: Configure network settings.
- `airport`: Interface with Wi-Fi settings.
  - View Wi-Fi network details:

    ```shell
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I
    ```

## Software Management

- `softwareupdate`: Interface with software update mechanism.
- `pkgutil`: Manage package receipts.
- `mas`: Command-line interface for the Mac App Store.
  - Search for an app:

    ```shell
    mas search "app name"
    ```

## User and Group Management

- `dscl`: Directory Service command-line utility.
  - List all users:

    ```shell
    dscl . -list /Users
    ```

  - Create a new user:

    ```shell
    sudo dscl . -create /Users/username
    ```

- `sysadminctl`: Administer sysadmin accounts.
  - Add a new user:

    ```shell
    sudo sysadminctl -addUser username -password userpassword -admin
    ```

- `dscacheutil`: Cache lookup tool.
  - Flush DNS cache:

    ```shell
    sudo dscacheutil -flushcache
    ```

## Conclusion

`macOS` is packed with versatile terminal commands, streamlining system administration and troubleshooting tasks. Delve into each command's manual with `man commandname` for deeper insights.
