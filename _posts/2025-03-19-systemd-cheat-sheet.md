---
title: Systemd Cheat Sheet
date: 2025-03-19 11:33:00 +0800
categories: [cheat Sheet]
toc: true
tag: [linux]
---

`Systemd` is a suite of fundamental building blocks for a Linux system. It provides a system and service manager that runs as **PID 1** and initializes the rest of the system. It has replaced older init systems like `SysV` in most modern Linux distributions.  

**Key Features**

- Parallel startup of services  
- On-demand activation of daemons  
- Dependency-based service control  

---

## Basic System Control  

Get system status  

```bash
systemctl status
```

Reboot the system  

```bash
systemctl reboot
```

Power off the system  

```bash
systemctl poweroff
```

Suspend the system  

```bash
systemctl suspend
```

Hibernate the system  

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
**Example:**  
```bash
systemctl start apache2.service
```

### Stop a service  
```bash
systemctl stop <serviceName>.service
```
**Example:**  
```bash
systemctl stop apache2.service
```

### Restart a service  
```bash
systemctl restart <serviceName>.service
```
**Example:**  
```bash
systemctl restart apache2.service
```

### Reload a service's configuration (without full restart)  
```bash
systemctl reload <serviceName>.service
```
**Example:**  
```bash
systemctl reload apache2.service
```

### Get the status of a service  
```bash
systemctl status <serviceName>.service
```
**Example:**  
```bash
systemctl status apache2.service
```

### Check if a service is enabled to start on boot  
```bash
systemctl is-enabled <serviceName>.service
```
**Example:**  
```bash
systemctl is-enabled apache2.service
```

### Enable a service to start on boot  
```bash
systemctl enable <serviceName>.service
```
**Example:**  
```bash
systemctl enable apache2.service
```

### Disable a service from starting on boot  
```bash
systemctl disable <serviceName>.service
```
**Example:**  
```bash
systemctl disable apache2.service
```

### Mask a service (prevent it from being started)  
```bash
systemctl mask <serviceName>.service
```
**Example:**  
```bash
systemctl mask apache2.service
```

### Unmask a service (allow it to be started)  
```bash
systemctl unmask <serviceName>.service
```
**Example:**  
```bash
systemctl unmask apache2.service
```

---

## Service Dependencies  

### Show a unit's dependencies  
```bash
systemctl list-dependencies <serviceName>.service
```
**Example:**  
```bash
systemctl list-dependencies apache2.service
```

---

## Unit Files  

### Show the location of a unit file  
```bash
systemctl show <serviceName>.service -p FragmentPath
```
**Example:**  
```bash
systemctl show apache2.service -p FragmentPath
```

### Edit a unit file  
```bash
systemctl edit <serviceName>.service
```
**Options:**  
- `--full`: Edit the main unit file instead of creating a snippet.  

**Example:**  
```bash
systemctl edit apache2.service --full
```

### Show the contents of a unit file  
```bash
systemctl cat <serviceName>.service
```
**Example:**  
```bash
systemctl cat apache2.service
```

### Reload systemd's unit files  
```bash
systemctl daemon-reload
```

---

## Journal Control (Logging)  

### Show all logs  
```bash
journalctl
```

### Show logs for a specific service  
```bash
journalctl -u <serviceName>.service
```
**Example:**  
```bash
journalctl -u apache2.service
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
**Example:**  
```bash
journalctl --since "10 min ago"
```