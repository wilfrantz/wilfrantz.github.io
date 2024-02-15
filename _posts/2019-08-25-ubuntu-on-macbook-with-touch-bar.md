---
title: Installing Ubuntu on touch bar MacBook Pro models
date: 2019-08-25 11:33:00 +0800
categories: [Blog]
tags: [MacOS, Darwin, Unix, XNU]
pin: false
math: true
mermaid: true
image:
---

Installing Ubuntu on a MacBook Pro, especially one with a Touch Bar, can be a bit tricky due to the proprietary hardware used in Macs. Here's a step-by-step guide to get you started. This guide will take you through creating a bootable USB, installing Ubuntu, and dealing with potential post-installation tweaks:

Table of Content

- [Requirements](#requirements)
- [Create a Bootable USB](#create-a-bootable-usb)
- [Boot from USB](#boot-from-usb)
- [Install Ubuntu](#install-ubuntu)
- [Post-Installation Tweaks](#post-installation-tweaks)
  - [Touch Bar](#touch-bar)
  - [WiFi](#wifi)
  - [Graphics and Power Management](#graphics-and-power-management)
  - [Sound](#sound)
- [Updates and Maintenance](#updates-and-maintenance)
- [Notes](#notes)

## Requirements

- A USB drive with at least 8 GB of space.
- An active internet connection.
- A MacBook Pro 13" with Touch Bar.
- A copy of the Ubuntu ISO, which can be downloaded from the official Ubuntu website.

## Create a Bootable USB

1. Insert your USB drive.
2. Open `Disk Utility`, select the USB drive, and format it as `ExFAT`.
3. Download and install an application called [Balena Etcher](https://www.balena.io/etcher/){: target="_blank"}.
4. Open Balena Etcher, select the downloaded Ubuntu ISO, and flash it onto the USB drive.

## Boot from USB

1. Turn off your MacBook Pro.
2. Press and hold the `Option/Alt` key and power on the MacBook Pro.
3. At the boot menu, select the USB drive (It might be labeled `EFI Boot`).
4. Choose "Try Ubuntu without installing" to make sure everything works fine before installing.

## Install Ubuntu

1. Double-click on the "Install Ubuntu" icon on the desktop.
2. Follow the installation prompts. Choose "Erase disk and install Ubuntu" if you wish to replace macOS, or "Install alongside" to keep both.
3. After the installation completes, restart your MacBook Pro.

## Post-Installation Tweaks

MacBook Pro's with a Touch Bar might require additional tweaks post-installation:

### Touch Bar

- To get basic Touch Bar support, you can use a tool called [Touchbar for Linux](https://github.com/roadrunner2/macbook12-spi-driver){: target="_blank"}. It doesn't provide the same functionality as macOS, but it does offer basic support.

### WiFi

- If WiFi doesn't work out of the box, you might need to install additional drivers. Broadcom chips, common in Macs, usually require proprietary drivers. You can use a wired connection or tether to another device temporarily to download the necessary drivers.

### Graphics and Power Management

- For better power management and graphics performance, consider installing TLP and graphics drivers:
  
  ```bash
  sudo apt install tlp tlp-rdw
  sudo tlp start
  ```

### Sound

- The sound might not work out-of-the-box. A workaround for many Mac models is to install the `pulseaudio` package
  
  ```bash
  sudo apt install pulseaudio
  ```

## Updates and Maintenance

- Once your system is set up, always keep it updated for best performance and security:
  
  ```bash
  sudo apt update
  sudo apt upgrade
  ```

## Notes

- Due to the proprietary nature of Apple's hardware, not all features will work flawlessly on Ubuntu.
- Always make a backup of your data before beginning any OS installation or major system change.
- If you're looking for a more macOS-like experience on Ubuntu, consider looking into distributions like [elementary OS](https://elementary.io/){: target="_blank"}.
 