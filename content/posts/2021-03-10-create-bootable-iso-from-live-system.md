---
title: Creating a Bootable ISO from a Live Linux System 
date: 2021-03-10 11:33:00 +0800
categories: [Blog]
tags: [Linux, Ubuntu]
pin: false
math: true
mermaid: true
image:
---

> ⚠️ This document is still a draft. Please note that there might be mistakes or inaccuracies.
{: .prompt-warning }

Creating a bootable ISO from a live Linux system can be a bit complex. However, if you follow the steps carefully, you can achieve your goal. Here's a step-by-step guide:

Table of Contents

- [Prerequisites](#prerequisites)
- [Steps](#steps)
  - [Install Required Packages](#install-required-packages)
  - [Backup your data](#backup-your-data)
  - [Prepare the Workspace](#prepare-the-workspace)
  - [Copy Necessary Files](#copy-necessary-files)
  - [Prepare the SquashFS Filesystem](#prepare-the-squashfs-filesystem)
  - [Create ISO Directory Structure](#create-iso-directory-structure)
  - [Move the SquashFS Filesystem to the ISO Directory](#move-the-squashfs-filesystem-to-the-iso-directory)
  - [Copy Bootloader Information](#copy-bootloader-information)
  - [Modify GRUB Configuration\*\* (if necessary)](#modify-grub-configuration-if-necessary)
  - [Create the ISO File](#create-the-iso-file)
  - [Cleanup](#cleanup)
  - [Test the ISO](#test-the-iso)

## Prerequisites

- A live system running Ubuntu or its derivative.
- Enough storage space to hold the contents of the live system and some additional tools.
- Root access or `sudo` privileges.

## Steps

### Install Required Packages

   Open a terminal and install the required packages:

   ```bash
   sudo apt update
   sudo apt install squashfs-tools genisoimage
   ```

### Backup your data

   Before proceeding further, ensure you've backed up any important data on your live system.

### Prepare the Workspace

   Create a workspace to hold necessary files:

   ```bash
   mkdir ~/livecdtmp
   ```

### Copy Necessary Files

   Copy the necessary files from your live system to the workspace:

   ```bash
   rsync --exclude=/proc/ --exclude=/tmp/ --exclude=/sys/ --exclude=/mnt/ --exclude=/dev/ --exclude=/home/ --exclude=/root/livecdtmp / ~/livecdtmp
   ```

   This command excludes directories that contain runtime system information or personal data.

### Prepare the SquashFS Filesystem

   SquashFS is a compressed read-only file system. We'll create a SquashFS image of the live system:

   ```bash
   sudo mksquashfs ~/livecdtmp/livefilesystem.squashfs ~/livecdtmp/
   ```

### Create ISO Directory Structure

   ```bash
   mkdir -p ~/livecdtmp/ISO/casper
   ```

### Move the SquashFS Filesystem to the ISO Directory

   ```bash
   mv ~/livecdtmp/livefilesystem.squashfs ~/livecdtmp/ISO/casper/
   ```

### Copy Bootloader Information

   This step will vary based on your bootloader. Assuming you are using GRUB:

   ```bash
   cp /boot/grub/grub.cfg ~/livecdtmp/ISO/boot/grub
   ```

### Modify GRUB Configuration** (if necessary)

   If you have custom boot parameters or specific kernel options, you'll need to edit the `grub.cfg` file appropriately.

### Create the ISO File

   Navigate to the ISO directory:

   ```bash
   cd ~/livecdtmp/ISO/
   ```

   Now, use `genisoimage` to create the ISO:

   ```bash
   sudo genisoimage -r -V "LiveSystem" -cache-inodes -J -l -b boot/grub/grub.cfg -c boot/grub/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../livesystem.iso .
   ```

   This command will create an ISO named "livesystem.iso" in the `~/livecdtmp` directory.

### Cleanup

   Remove the temporary directory:

   ```bash
   rm -rf ~/livecdtmp
   ```

### Test the ISO

   You can use virtualization software like VirtualBox or QEMU to test the newly created ISO to ensure it boots correctly.

> This is a basic guide, and there may be additional steps or modifications needed based on the specifics of your system and requirements. Always test the ISO in a safe environment before using it for any critical applications.
