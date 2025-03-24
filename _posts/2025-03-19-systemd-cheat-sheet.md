---
title: Systemd Cheat Sheet
date: 2025-03-19 11:33:00 +0800
categories: [cheatSheet]
toc: true
tag: [linux]
---

`Systemd` is a suite of fundamental building blocks for a Linux system. It provides a system and service manager that runs as **PID 1** and initializes the rest of the system. It is replacement to `SysV` in most modern Linux distributions.  

**Key Features**

- Parallel startup of services.
- On-demand activation of daemons.
- Dependency-based service control.

---

## Basic System Control  

### Get system status  

```bash
systemctl status
```

### Reboot the system  

```bash
systemctl reboot
```

### Power off the system  

```bash
systemctl poweroff
```

### Suspend the system  

```bash
systemctl suspend
```

### Hibernate the system  

```bash
systemctl hibernate
```

### Mixed sleep (hybrid sleep)  

```bash
systemctl hybrid-sleep
```

### List all units  

```bash
systemctl list-units
```

### List all active units  
```bash
systemctl list-units --state=active
```

### List all failed units  

```bash
systemctl list-units --state=failed
```

---

## Service Management  

### Start a service  

```bash
systemctl start <serviceName>.service
```

### Stop a service  
```bash
systemctl stop <serviceName>.service
```

### Restart a service  

```bash
systemctl restart <serviceName>.service
```

### Reload a service's configuration (without full restart)  

```bash
systemctl reload <serviceName>.service
```

### Get the status of a service  

```bash
systemctl status <serviceName>.service
```

### Check if a service is enabled to start on boot  

```bash
systemctl is-enabled <serviceName>.service
```

### Enable a service to start on boot  

```bash
systemctl enable <serviceName>.service
```

### Disable a service from starting on boot  

```bash
systemctl disable <serviceName>.service
```

### Mask a service (prevent it from being started)  

```bash
systemctl mask <serviceName>.service
```

### Unmask a service (allow it to be started)  

```bash
systemctl unmask <serviceName>.service
```

---

## Service Dependencies  

### Show a unit's dependencies  

```bash
systemctl list-dependencies <serviceName>.service
```

---

## Unit Files  

### Show the location of a unit file  

```bash
systemctl show <serviceName>.service -p FragmentPath
```

### Edit a unit file  

```bash
systemctl edit <serviceName>.service
```

Example:
```bash
# Set the EDITOR at runtime
# `--full`: Edit the main unit file instead of creating a snippet.  
EDITOR=vim systemctl edit apache2.service --full
```

### Show the contents of a unit file  

```bash
systemctl cat <serviceName>.service
```

### Reload systemd's unit files  

```bash
systemctl daemon-reload
```
---

## Journal Control (Logging)  

`Journalctl` is a command-line utility that allows you to view and query logs stored in the systemd journal. The journal is a structured, binary log format that collects logs from various sources, including the kernel, system services, and applications.

### Show all logs  

```bash
journalctl
```

### Show logs for a specific service  

```bash
journalctl -u <serviceName>.service
```

### Show logs from boot  

```bash
journalctl -b
```

### Follow logs in real-time  

```bash
journalctl -f
```

### Show recent logs (e.g., last 10 minutes)  

```bash
journalctl --since "10 min ago"
```

### Show logs since a specific time

``` bash
journalctl --since "2025-03-15"
```

### Show logs until a specific time

```bash
journalctl --until "2025-03-15 12:00:00"
```

### Show logs within a time range

```bash
journalctl --since "yesterday" --until "now"
```

### Show kernel logs

```bash
journalctl -k
```

### Show logs and with explanations

```bash
journalctl -x
```
## Disk Usage

### Show journal disk usage

```bash
journalctl --disk-usage
```

## Time Synchronization

### Check the status of the time synchronization service

```bash
systemctl status systemd-timesyncd.service
```

## Other Useful Commands

### Show system uptime

```bash
uptime
```

### Show current system limits

```bash
ulimit -a
```
 

## Conclusion

I find this systemd cheat sheet incredibly useful for managing systems and services in Linux. It serves as a quick reference for the common tasks I handle daily. While systemd offers a wide range of features and options, this cheat sheet helps me easily recall essential commands, which significantly enhances my workflow. For more detailed information, I often refer to the official systemd documentation or use the `man systemd` command.