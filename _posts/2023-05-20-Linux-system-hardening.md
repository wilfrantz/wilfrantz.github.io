---
title: Practical Guide to Linux System Hardening
date: 2022-05-20 11:33:00 +0800
categories: [doc]
tags: [Linux]
toc: true
---

In an era of rising cyber threats, securing your Linux system is crucial to protect sensitive data and prevent unauthorized access. This comprehensive guide focuses on Debian-based (Ubuntu) systems and offers practical insights and best practices to fortify your system's defenses.

From secure authentication and user privilege management to firewall configuration and system log monitoring, this guide provides the knowledge and tools necessary to effectively harden your Linux environment.

***Table of contents***:

- [Keep Your System Up to Date](#keep-your-system-up-to-date)
  - [Enable automatic updates](#enable-automatic-updates)
  - [Set up a schedule for manual updates](#set-up-a-schedule-for-manual-updates)
- [Secure User Accounts](#secure-user-accounts)
  - [Create a strong password policy](#create-a-strong-password-policy)
  - [Enforce regular password changes](#enforce-regular-password-changes)
  - [Remove or disable unnecessary user accounts](#remove-or-disable-unnecessary-user-accounts)
  - [Implement multi-factor authentication (MFA) for privileged accounts](#implement-multi-factor-authentication-mfa-for-privileged-accounts)
- [Secure SSH Access](#secure-ssh-access)
  - [Limit Root Access](#limit-root-access)
  - [Use SSH keys for authentication](#use-ssh-keys-for-authentication)
  - [Disable direct root login via SSH](#disable-direct-root-login-via-ssh)
  - [Restrict `SSH` access to specific IP addresses or ranges](#restrict-ssh-access-to-specific-ip-addresses-or-ranges)
  - [Use strong encryption algorithms](#use-strong-encryption-algorithms)
  - [Change the default SSH port](#change-the-default-ssh-port)
- [Firewall Configuration](#firewall-configuration)
  - [Choose a Firewall Tool](#choose-a-firewall-tool)
  - [Install the Firewall Tool](#install-the-firewall-tool)
  - [Enable the Firewall](#enable-the-firewall)
  - [Define Default Policies](#define-default-policies)
  - [Allow Specific Services and Ports](#allow-specific-services-and-ports)
  - [Review and Update Firewall Rules](#review-and-update-firewall-rules)
- [File System Hardening](#file-system-hardening)
  - [Utilize File System Encryption (e.g., `dm-crypt`, `LUKS`)](#utilize-file-system-encryption-eg-dm-crypt-luks)
  - [Set Appropriate File Permissions and Restrict Access](#set-appropriate-file-permissions-and-restrict-access)
  - [Implement File Integrity Monitoring Tools (e.g., `AIDE`, `Tripwire`)](#implement-file-integrity-monitoring-tools-eg-aide-tripwire)
- [Network Services](#network-services)
  - [Disable unnecessary network services](#disable-unnecessary-network-services)
  - [Regularly update and patch the software](#regularly-update-and-patch-the-software)
  - [Utilize secure protocols for remote management and data transfer](#utilize-secure-protocols-for-remote-management-and-data-transfer)
- [Logging and Auditing](#logging-and-auditing)
  - [Enabling Comprehensive System Logging](#enabling-comprehensive-system-logging)
  - [Securing Log Files](#securing-log-files)
  - [Review Logs for Suspicious Activities](#review-logs-for-suspicious-activities)
  - [Implement Centralized Log Management](#implement-centralized-log-management)
    - [Install Logstash](#install-logstash)
    - [Install Graylog](#install-graylog)
- [Set up Regular Backups](#set-up-regular-backups)
  - [Determine Critical Data](#determine-critical-data)
  - [Choose a Backup Tool](#choose-a-backup-tool)
  - [Automate Backups](#automate-backups)
  - [Secure Backup Storage](#secure-backup-storage)
  - [Offsite Storage](#offsite-storage)
  - [Test Restoration](#test-restoration)
  - [Review and Adjust](#review-and-adjust)
- [Continuous Monitoring](#continuous-monitoring)
- [Resources](#resources)
- [Footnote](#footnote)

## Keep Your System Up to Date

One useful way of considering security is to define goals. System security attempts to satisfy three primary goals:

- Confidentiality
- Integrity, and
- Availability.

These goals are known as the CIA Triad.

**Confidentiality** ensures that only the authorized user has access to data. Establishing confidentiality  may include encryption of network traffic against interception, permissions to manage access to files or databases, and authentication to manage access to system resources and other sensitive assets.

**Integrity** ensures that data has not changed unexpectedly. Such changes may occur because of data corruption during network transfer, malicious users altering data, non-malicious users accidentally changing or deleting data, and other similar activities.

**Availability** ensures that users and services have access to the resources they need when they need them. Availability includes system uptime, appropriate network performance, and access to resources. Solutions such as backups, load balancing, and low latency network connections are all part of the availability goal.

Regularly apply security patches and updates to your Linux distribution, including the kernel, system libraries, and applications.

```bash
sudo apt update && sudo apt upgrade
```

### Enable automatic updates

To enable automatic updates, you can configure the system to automatically install security updates or enable unattended upgrades. Install the necessary packages by running the following command:

```bash
sudo apt install unattended-upgrades
```

Once the installation is complete, edit the configuration file for unattended upgrades using a text editor like `vim` or `nano`.
Run the following command to open the configuration file in `vim`:

```bash
sudo vim /etc/apt/apt.conf.d/50unattended-upgrades
```

> If prompted, enter your password.
{: .prompt-warning }

In the configuration file, locate the line that starts with `//Unattended-Upgrade::Automatic-Reboot`; and remove the `//` comment characters at the beginning of the line to uncomment it.

> This line enables automatic reboots after updates if necessary.
{: .prompt-warning }

You can also modify other settings in the configuration file according to your preferences. For example, you can enable/disable specific types of updates or set a schedule for automatic updates.

Save the changes and exit the text editor.

Enable the unattended upgrades service by running the following command:

```bash
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

This command will reconfigure the package to enable automatic updates. The automatic updates are now enabled. `Ubuntu` will periodically check for updates and install them automatically according to the configuration settings.

### Set up a schedule for manual updates

To set up a schedule for manual updates, you can use the `cron` utility to schedule the execution of the apt command at specific intervals. Here's how you can do it:

- Open a terminal. You can do this by pressing `Ctrl+Alt+T` or searching for `Terminal` in the application launcher.
- Create a new cron job by running the following command:

```bash
crontab -e
```

If prompted, choose your preferred text editor. I recommend `vim` or any of its variants.

- In the text editor, add a new line with the following format to schedule the updates at a specific interval. For example, to schedule updates every day at 2:00 AM, you would use:

```bash
0 2 * * * apt update && apt upgrade -y
```

The format for the schedule is as follows:

```bash
minute (0-59) hour (0-23) day_of_month (1-31) month (1-12) day_of_week (0-6)
```

Modify the values accordingly to set the desired schedule. Save the file and exit the text editor.

The `cron` job is now set up to run `apt update and apt upgrade -y` at the specified schedule. This will update the package lists and upgrade installed packages.

> Please note that setting up a schedule for manual updates means that the system will automatically run the updates according to the specified interval. You won't receive notifications or prompts during the update process.
{: .prompt-tip}
> Be cautious when scheduling updates, especially if you're scheduling them during times when the system is typically in use or when critical tasks are being performed.
{: .prompt-warning}

## Secure User Accounts

You can enhance the security of user accounts in a Linux system by enforcing:

- strong passwords,
- regular password changes,
- removing unnecessary accounts, and
- implementing multi-factor authentication (MFA) for privileged accounts.

### Create a strong password policy

  1. Open the terminal and log in as the root user or use the `sudo`.
  2. Open the password policy configuration file using a text editor such as `vim` or `nano`. For example:
    `sudo vi /etc/pam.d/common-password`
  3. Look for the line that starts with `password` and contains the keyword `pam_unix.so`.
  4. Modify the line to include password complexity rules, such as minimum length, requirement for uppercase and lowercase letters, numbers, and special characters. For example:
     `password    requisite    pam_pwquality.so retry=3 minlen=8 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1`
  5. Save and exit the file.

### Enforce regular password changes

   1. Open the terminal and log in as the root user or use the `sudo` command for administrative privileges.
   2. Open the password expiration configuration file using a text editor. For example: `sudo vi /etc/login.defs`.
   3. Locate the line that begins with "PASS_MAX_DAYS" and set the desired maximum number of days for password validity. For example, to set it to 90 days:

      ```shell
      PASS_MAX_DAYS   90
      ```

   4. Save and exit the file.

### Remove or disable unnecessary user accounts

   1. Open the terminal and log in as the root user or use `sudo`.
   2. List all user accounts on the system using the `cat` command on the "/etc/passwd" file. For example: `cat /etc/passwd`.
   3. Identify any accounts that are no longer needed or are not associated with specific purposes.
   4. Disable or delete unnecessary accounts using the appropriate command. For example, to disable an account named "user1":

      ```shell
      sudo passwd --lock user1
      ```

   5. Repeat this step for each unnecessary account.

### Implement multi-factor authentication (MFA) for privileged accounts

  1. Install the necessary software for MFA. One popular option is `Google Authenticator` which can be installed using package management tools like `apt` or `yum`.
  2. Configure MFA for privileged accounts. For example, if you want to enable MFA for the `admin` account:
  3. Open the terminal and log in as the root user or use `sudo`.
  4. Run the command to enable MFA for the account: `google-authenticator`.
  5. Follow the prompts to set up MFA, which usually involves scanning a QR code with an authenticator app on a mobile device.
  6. Edit the SSH configuration file to require MFA for SSH logins. Open the file using a text editor, such as `vi` or `nano`: `sudo vi /etc/ssh/sshd_config`.
  7. Find the line that begins with `ChallengeResponseAuthentication` and change its value to `yes`.
  8. Save and exit the file.
  9. Restart the SSH service to apply the changes: `sudo service sshd restart`.

## [Secure SSH Access](#secure-ssh-access)

Ensuring the security of SSH access is crucial for protecting your system from unauthorized access and potential security breaches. Follow these step-by-step instructions to enhance the security of your SSH connections:

### Limit Root Access

The root account has unrestricted access to the entire system, making it a potential target for unauthorized access. Instead, use the `sudo` command to execute administrative tasks, granting privileges on an as-needed basis.

- Add your non-root user to the sudoers file:

In order to grant administrative privileges to your regular user account, you need to add it to the sudoers file. The sudoers file defines which users are allowed to use the sudo command.

Open the terminal and log in as the root user or switch to the root user using the `su` command:

```bash
su
```

Now, you need to edit the sudoers file using the visudo command, which will open the file in a safe text editor.

```bash
visudo
```

> To set vim as default text editor use `sudo update-alternatives --set editor /usr/bin/vim.basic`
{: .prompt-tip}

The sudoers file will be opened in the editor (usually `nano` or `vim`). Locate the section that specifies user privileges, which typically contains lines with the format:

```bash
user  host=(runas)  command
```

We want to grant all administrative privileges to the user `dede` on all hosts (localhost) and for all commands. Add the following line in the sudoers file:

```bash
dede ALL=(ALL:ALL) ALL
```

- Save and exit the file.

> It's important to use the `visudo` command instead of directly editing the sudoers file with a text editor. Visudo performs syntax checking and prevents you from accidentally introducing errors that could lock you out of your system.
{: .prompt-tip}

### Use SSH keys for authentication

- Generate an SSH key pair on your local machine using a tool like `ssh-keygen`.

  ```shell
  # Generate an ED25519 key with email as a comment:
    ssh-keygen -t ed25519 -C "yourEmail@example.com"
  ```

- Copy the public key (`id_ed25519.pub`) to the remote server using the `ssh-copy-id` command or by manually appending it to the `authorized_keys` file in the remote user's `.ssh` directory.

  ```shell
  # Copy the given public key to the remote:
  ssh-copy-id -i path/to/certificate username@remote_host
  ```

- Disable password authentication in the SSH server configuration file (`/etc/ssh/sshd_config`). Set `PasswordAuthentication` to `no`.

- Restart the SSH service for the changes to take effect

  ```shell
  sudo service ssh restart
  ```

### Disable direct root login via SSH

Directly logging in as root over SSH increases the risk of unauthorized access since the root account is a prime target for attackers. It is recommended to use a non-root user account to log in and escalate privileges when necessary.

- Open the terminal and log in as the root user or use a non-root user account with administrative privileges.
- Edit the SSH configuration file using a text editor, such as `vi` or `nano`:

   ```shell
   sudo vi /etc/ssh/sshd_config
   ```

- Locate the line that begins with `PermitRootLogin` and change its value to `no`:

     ```shell
     PermitRootLogin no
     ```

- Save and exit the file.
- Restart the SSH service to apply the changes

  ```shell
  sudo service sshd restart
  ```

### Restrict `SSH` access to specific IP addresses or ranges

- Update the SSH server configuration file (`/etc/ssh/sshd_config`) on the remote server.

  ```shell
    sudo vim /etc/ssh/sshd_config
  ```

- Add the following lines to allow SSH access only from specific IP addresses or ranges:

    ```shell
    AllowUsers your_username@trusted_ip
    ```

- Save the file and restart the SSH service (`sudo service ssh restart`).

### Use strong encryption algorithms

- Open the SSH server configuration file (`/etc/ssh/sshd_config`) on the remote server.
- Look for the `Ciphers` and `MACs` lines and ensure they include only strong encryption algorithms including AES[^footnote], ChaCha20-Poly1305[^fn-nth-2], Diffie-Hellman (DH) Key Exchange[^fn-nth-3], Elliptic Curve Cryptography (ECC)[^fn-nth-4], and SHA-2 (Secure Hash Algorithm 2)[^fn-nth-5]. Remove any weak or outdated algorithms from the list.
- Save the file and restart the SSH service

  ```shell
      sudo service ssh restart
  ```

### Change the default SSH port

- Open the SSH server configuration file (`/etc/ssh/sshd_config`) on the remote server.

  ```shell
  sudo vim /etc/ssh/sshd_config
  ```

- Locate the line that starts with `Port` and change its value to a non-standard port number (e.g., 2222).

  ```shell
    port 2222
  ```

  > Rememeber to add permission via firewall. See [Firewall Configuration below 👇](#firewall-configuration)
  {: .prompt-tip}

- Save the file and restart the SSH service

  ```shell
  sudo service ssh restart
  ```

## [Firewall Configuration](#firewall-configuration)

To configure the firewall on your system and control inbound and outbound network traffic, follow these step-by-step instructions:

### Choose a Firewall Tool

There are various firewall tools available for Linux systems, such as `iptables` and UFW[^fn-nth-6]. Choose the tool that best suits your needs and preferences.

### Install the Firewall Tool

If the chosen firewall tool is not already installed on your system, you can install it using the package manager. For example, to install `UFW`, run the following command:

```shell
sudo apt update
sudo apt install ufw
```

### Enable the Firewall

Once the firewall tool is installed, enable it by running the appropriate command. For `UFW`, use the following command:

```shell
sudo ufw enable
```

### Define Default Policies

Set the default policies for inbound and outbound traffic. It is recommended to block all incoming traffic by default and allow only necessary services and ports. Use the following commands for `UFW` as an example:

```shell
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

### Allow Specific Services and Ports

To allow incoming traffic for specific services or ports, use the appropriate commands for your firewall tool. For example, to allow incoming `SSH` connections (port 22) for `UFW`, run the following command:

``` shell
sudo ufw allow ssh
```

> Repeat this step for any other services or ports that you want to allow incoming traffic for.
{: .prompt-info}

### Review and Update Firewall Rules

Regularly review and update your firewall rules to reflect changes in your system's requirements. This can include adding or removing allowed services/ports or modifying existing rules. Use the appropriate commands for your firewall tool to make these changes.

For `UFW`, you can list the current firewall rules using:

```shell
sudo ufw status numbered
```

To modify or delete a rule, use the following commands:

```shell
sudo ufw delete [rule_number]
sudo ufw insert [rule_number] [new_rule]
```

Remember to reload the firewall after making any changes to apply the updated rules:

```shell
sudo ufw reload
```

## [File System Hardening](#file-system-hardening)

File system hardening is a critical aspect of securing your system against unauthorized access and data breaches. By implementing measures such as file system encryption, setting appropriate file permissions, and using file integrity monitoring tools, you can significantly enhance the security of your system.

### Utilize File System Encryption (e.g., `dm-crypt`, `LUKS`)

File system encryption ensures that sensitive data stored on your system remains protected even if the physical storage media is compromised. The two popular tools for Linux-based systems are `dm-crypt` and `LUKS` (Linux Unified Key Setup).

- We will use `LUKS` to encrypt a partition containing sensitive data.
  - Install required packages
    : Ensure that LUKS tools are installed on your system. On most Linux distributions, you can install them using the package manager (e.g., `apt` for Debian/Ubuntu or `dnf` for Fedora):

    ```shell
    sudo apt-get install cryptsetup
    ```

  - Create the encrypted partition
    : Assuming you have a partition named /dev/sdb1 that you want to encrypt, use the following command to set up LUKS encryption:

    ```shell
    sudo cryptsetup luksFormat /dev/sdb1
    ```

    You will be prompted to create a passphrase. Choose a strong passphrase and confirm it.
  
  - Open the encrypted partition
    : After creating the LUKS header on the partition, you need to open it with a mapping name (e.g., `secure_data`):

    ```shell
    sudo cryptsetup open /dev/sdb1 secure_data
    ```

    You will be asked to enter the passphrase you set during the format.

  - Format and mount the encrypted partition
    : Now, you can format the opened encrypted partition (e.g., as `ext4`) and mount it to a directory (e.g., `/mnt/secure`):

    ```shell
    sudo mkfs.ext4 /dev/mapper/secure_data
    sudo mount /dev/mapper/secure_data /mnt/secure
    ```

    Make sure to update `/etc/fstab` to automatically mount the encrypted partition on system boot.

### Set Appropriate File Permissions and Restrict Access

Proper file permissions help prevent unauthorized access to critical system files and directories, reducing the risk of unauthorized modifications.

- We will set file permissions for sensitive configuration files.

  - Identify the sensitive files
    : Determine which files contain critical configuration or system information that should be protected.

  - Set the appropriate permissions
    : For example, set the permissions for a sensitive file named "database.conf" so that only the owner has read and write permissions, and other users have no access:

    ```shell
    sudo chmod 600 /path/to/database.conf
    ```

### Implement File Integrity Monitoring Tools (e.g., `AIDE`, `Tripwire`)

File integrity monitoring tools help detect any unauthorized changes to system files, ensuring the integrity of critical components.

- We will install and configure AIDE (Advanced Intrusion Detection Environment).

  - Install `AIDE`
    : Install the AIDE package on your system using the package manager:

    ```shell
    sudo apt-get install aide -y
    ```

  - Initialize `AIDE` database
    : Initialize the AIDE database to store baseline information about the current state of your files:

    ```shell
    sudo aideinit
    ```

  - Regularly run integrity checks
    : Set up a cron job to run periodic integrity checks. For example, you can run the check every day at midnight:

    ```shell
    sudo crontab -e
    ```

    Add the following line to the crontab file:

    ```shell
    0 0 * * * /usr/sbin/aide --check
    ```

    This will run AIDE daily and compare the current state of files against the baseline database, notifying you of any modifications.

## [Network Services](#network-services)

Network services and daemons are essential components of a system that provide various functionalities. However, they can also present potential security risks if not properly managed. Here are some steps to secure your network services effectively

### Disable unnecessary network services

One of the fundamental steps to minimize the attack surface is to disable any network services and daemons that are not required for the system's intended purpose. Running unnecessary services increases the potential entry points for attackers and exposes the system to additional vulnerabilities.

To illustrate, let's consider a Linux server with some default services running:

```shell
sudo systemctl list-unit-files --type=service | grep enabled
```

- Output:

  ```shell
    accounts-daemon.service                    enabled         enabled
    alsa-utils.service                         masked          enabled
    anacron.service                            enabled         enabled
    apache-htcacheclean.service                disabled        enabled
    apache-htcacheclean@.service               disabled        enabled
    apache2.service                            enabled         enabled
    apache2@.service                           disabled        enabled
    apparmor.service                           enabled         enabled
    avahi-daemon.service                       enabled         enabled
    binfmt-support.service                     enabled         enabled
    bluetooth.service                          enabled         enabled
    brltty.service                             disabled        enabled
  ```

In this example, the `avahi-daemon` and `cups` services may not be necessary for the server's core functionality. Use the following commands to disable them:

```shell
sudo systemctl disable avahi-daemon.service
sudo systemctl disable cups.service
```

> Always exercise caution when disabling services, as some might be necessary for specific applications or functionalities.
{: .prompt-danger}

### Regularly update and patch the software

Keeping the software running the network services up-to-date is crucial to address known security vulnerabilities. Hackers often exploit outdated software to gain unauthorized access to systems.

- To [ensure software is regularly updated](#enable-automatic-updates), use the package manager specific to your operating system. For instance, on a Debian-based system, use `apt`:

```shell
sudo apt update
sudo apt upgrade
```

- For a Red Hat-based system, use `yum` or `dnf`:

```shell
sudo yum update
sudo dnf upgrade
```

Regularly applying security patches and updates ensures that known vulnerabilities are fixed, reducing the risks of attack.

---

### Utilize secure protocols for remote management and data transfer

When remotely managing your system or transferring sensitive data, it's essential to use secure protocols to safeguard information from potential eavesdropping and interception.

Secure protocols, such as `HTTPS` for web-based management and `SFTP` for secure file transfer, encrypt data during transmission.

- For example, when setting up remote `SSH` access to a server, avoid using the less secure `Telnet` protocol and opt for `SSH` instead:

```shell
# Insecure Telnet
telnet 192.168.0.100

# Secure SSH
ssh user@192.168.0.100
```

- Similarly, when transferring files, use `SFTP` instead of `FTP`:

```shell
# Insecure FTP
ftp 192.168.0.100

# Secure SFTP
sftp user@192.168.0.100
```

## Logging and Auditing

System logs can be a vital source of information, helping to identify unauthorized activities, potential system errors, and various security events.

### Enabling Comprehensive System Logging

For an all-inclusive system log, Linux offers the `rsyslog` service. To ensure it's running, use the following command:

```bash
sudo systemctl status rsyslog
```

If it's not running, start it:

```bash
sudo systemctl start rsyslog
```

To make `rsyslog` start on boot, use:

```bash
sudo systemctl enable rsyslog
```

### Securing Log Files

Logs often contain sensitive data, so it's vital to store them securely. Change the permissions and ownership of the log files to restrict access using:

```bash
sudo chown root:root /var/log
sudo chmod 0700 /var/log
```

This gives only root access to the log directory.

### Review Logs for Suspicious Activities

Logs are a gold mine of information. Regular review can help identify issues before they become major problems.

`/var/log/syslog` is a file systems where the syslog daemon, such as `rsyslogd`, stores all system messages and events for later review. This file typically contains log data from various system services, kernel messages, and other logs not specifically categorized into other files within `/var/log/`.

Use the `tail` command to view the most recent entries:

```bash
sudo tail -f /var/log/syslog
```

The `grep` command can help you search for specific patterns, like errors or failed attempts:

```bash
sudo cat /var/log/auth.log | grep 'Failed password'
```

You can automate log reviews using `logcheck`, a tool that scans logs and sends anomalies via email. To install logcheck:

```bash
sudo apt-get install logcheck
```

### Implement Centralized Log Management

Centralized log management allows you to collect and analyze logs from multiple systems in one place. Tools like `Logstash` or `Graylog` can help you achieve this.

#### Install Logstash

`Logstash` is an open-source data collection engine that you can use to centralize your data.

- Step 1: Install `Logstash`

Add the Elastic repository to your system. Here, we'll install version 7.x of Logstash.

Download and install the Public Signing Key:

```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
```

Save the repository definition to your system:

```bash
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
```

Update your system and install `Logstash`:

```bash
sudo apt-get update && sudo apt-get install logstash
```

- Step 2: Configure Logstash

Create a new configuration file. We'll call ours `01-netflow-input.conf` and input the configurations to set up the network flow.

```bash
sudo nano /etc/logstash/conf.d/01-netflow-input.conf
```

In this file, you can enter something like:

```bash
input {
  udp {
    port  => 2055
    codec => netflow {
      versions => [5, 9]
    }
    type  => netflow
  }
}
```

Save and exit the file.

Create a filter configuration file. We'll call ours `10-syslog-filter.conf`:

```bash
sudo vim /etc/logstash/conf.d/10-syslog-filter.conf
```

In this file, you can enter something like:

```bash
filter {
  if [type] == "syslog" {
    grok {
      match => { "message" => "%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}" }
      add_field => [ "received_at", "%{@timestamp}" ]
      add_field => [ "received_from", "%{host}" ]
    }
    syslog_pri { }
    date {
      match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
    }
  }
}
```

Save and exit the file.

- Create an output configuration file. We'll call ours `30-elasticsearch-output.conf`:

```bash
sudo nano /etc/logstash/conf.d/30-elasticsearch-output.conf
```

In this file, you can enter something like:

```bash
output {
  elasticsearch {
    hosts => ["localhost:9200"]
    manage_template => false
    index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
  }
}
```

Save and exit the file.

- Step 3: Start Logstash

Finally, start the Logstash service:

```bash
sudo systemctl start logstash
```

To enable Logstash to start on boot, use:

```bash
sudo systemctl enable logstash
```

> Note: Logstash configurations can be quite complex depending on your specific use case. The provided examples are basic and meant to provide an overview. Always tailor your configuration to suit your specific requirements.
{: .prompt-tip}

#### Install Graylog

Graylog is an open-source tool that offers centralized log management, designed to process logs sent by applications, and present them in a human-readable and structured format.

To set up Graylog, you'll need to have MongoDB and Elasticsearch running. Here are the steps to install Graylog on a Ubuntu system:

- Step 1: Installing MongoDB

Graylog uses MongoDB to store configurations and meta information.

```bash
sudo apt update
sudo apt install -y mongodb
```

- Step 2: Installing Elasticsearch

Graylog uses Elasticsearch to store the actual log data.

```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update
sudo apt install -y elasticsearch
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl restart elasticsearch.service
```

- Step 3: Installing Graylog

Download and install the Graylog repository configuration:

```bash
wget https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.deb
sudo dpkg -i graylog-4.0-repository_latest.deb
sudo apt-get update
```

Install the Graylog server package:

```bash
sudo apt-get install graylog-server
```

- Step 4: Configuring Graylog

You'll need to edit the server configuration file located at `/etc/graylog/server/server.conf`:

```bash
sudo nano /etc/graylog/server/server.conf
```

Find and set the `password_secret` and `root_password_sha2` values:

```bash
password_secret = <Enter a strong secret>
root_password_sha2 = <Enter the sha256 hash of your admin password>
```

To generate a strong secret and a SHA2 hash of your password, you can use the following commands:

```bash
pwgen -N 1 -s 96
echo -n "Enter Your Password: " | sha256sum
```

Save and exit the configuration file.

- Step 5: Starting Graylog

Finally, start the Graylog service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable graylog-server.service
sudo systemctl start graylog-server.service
```

- Step 6: Accessing Graylog Web Interface

You can now access the Graylog web interface by typing your server’s IP address followed by the port `9000`:

```bash
http://your_server_ip:9000
```

> Note: Always replace `your_server_ip` with your actual server IP address.
{: .prompt-info}
> Remember, Graylog can be quite a complex system to set up and maintain, so you should only attempt this if you are confident in your Linux and system administration skills. Always ensure to follow best practices and keep your system secure.
{: .prompt-tip}

## Set up Regular Backups

`Regular backups` is a crucial step in hardening a Linux system. Without a secure and reliable backup system in place, even the most fortified system remains vulnerable to data loss. Here's a step-by-step guide to ensure your data is backed up, stored securely, and restorable:

### Determine Critical Data

Identify which files, configurations, and data are critical to your system's operation and your organization's functionality.

- System configurations (`/etc/`)
- User data (commonly found in `/home/`)
- Database files
- Custom applications and their configurations

### Choose a Backup Tool

Linux provides a variety of tools for creating backups:

- **rsync**: A fast, versatile tool ideal for creating mirror backups.
- **tar**: Useful for creating compressed archives of files.
- **duplicity**: Provides encrypted, bandwidth-efficient backup using the rsync algorithm.
- **BorgBackup**: Deduplicates and compresses your data, and supports encryption.

### Automate Backups

To ensure that backups occur regularly, automate the process:

- Use **cron jobs** to run your backup commands at specified intervals. For example, to backup `/home/` daily at 2 AM using rsync:

  ```bash
  0 2 * * * rsync -a /home/ /path/to/backup/location/
  ```

- Tools like **BorgBackup** and **duplicity** also support scheduling and automation natively.

### Secure Backup Storage

Storing backups securely is just as important as creating them:

- If storing backups on-site, consider using a dedicated backup server or a physically separate drive.
- For added security, encrypt backups. Tools like **duplicity** and **BorgBackup** support encryption out-of-the-box.
- Consider cloud storage solutions, but ensure they provide encryption, both at rest and in transit.
- Rotate backups and implement retention policies to avoid running out of storage space and to retain only the necessary backups.

### Offsite Storage

Storing backups offsite ensures data integrity even in catastrophic events like natural disasters:

- Consider cloud storage solutions that emphasize security and privacy.
- If opting for physical offsite storage, regularly transport backup media (like external hard drives) to a secure, offsite location.

### Test Restoration

A backup is only as good as its restorability:

- Periodically attempt to restore data from backups to a test environment. This ensures that the backup is not only complete but also functional.
- Document the restoration process, noting any potential issues or steps that might be non-intuitive.
- If using encryption, ensure decryption keys are securely stored and accessible for restoration.

### Review and Adjust

Backup needs can change over time:

- Regularly review the content of backups to ensure all critical data is included.
- Adjust backup schedules and storage locations as necessary, considering the importance and size of the data.

In conclusion, while system hardening often emphasizes preventing unauthorized access and securing the system, it's equally critical to prepare for scenarios where recovery is necessary. By setting up regular, secure, and testable backups, you safeguard your data and ensure business continuity.

- Set up automated backups of critical system files, configurations, and user data.
- Store backups securely, ideally offsite or in a separate location from the production environment.
- Test the restoration process periodically to ensure backups are reliable.

## Continuous Monitoring

- Implement intrusion detection systems (IDS) or intrusion prevention systems (IPS) to monitor network traffic and detect malicious activities.
- Utilize security information and event management (SIEM) tools to aggregate and analyze security events from various sources.

> Remember, system hardening is an ongoing process. Stay updated with the latest security best practices, regularly assess and review your system's security posture, and adapt your hardening measures as needed to address emerging threats and vulnerabilities.
{: .prompt-tip}

## Resources

- [Limit SSH access to specific clients by IP address](https://unix.stackexchange.com/questions/406245/limit-ssh-access-to-specific-clients-by-ip-address){:target="_blank"}
- [How To Secure A Linux Server by imthenachoman](https://github.com/imthenachoman/How-To-Secure-A-Linux-Server?utm_source=pocket_saves){:target="_blank"}
- [40 Linux Server Hardening Security Tips [2023 edition]](https://www.cyberciti.biz/tips/linux-security.html){:target="_blank"}
- [Linux Security and Hardening, The Practical Security Guide by Jason Cannon](https://www.udemy.com/course/linux-security/learn/lecture/4624500?start=0#overview){:target="_blank"}

## Footnote

 [^footnote]: **AES (Advanced Encryption Standard):** AES is a widely used symmetric encryption algorithm that provides strong security. It supports key sizes of 128, 192, and 256 bits.
 [^fn-nth-2]: **ChaCha20-Poly1305:** This is a modern symmetric encryption algorithm that offers high security and performance. It is often considered as an alternative to AES.
 [^fn-nth-3]: **Diffie-Hellman (DH) Key Exchange:** DH is a secure key exchange algorithm used to establish a shared secret key between the client and server. It ensures secure communication by allowing the parties to generate a shared secret without transmitting it over the network.
 [^fn-nth-4]: **Elliptic Curve Cryptography (ECC):** ECC is a modern public-key cryptography algorithm that offers strong security with relatively shorter key lengths compared to traditional algorithms like RSA. It is widely used in SSH for key exchange and authentication.
 [^fn-nth-5]: **SHA-2 (Secure Hash Algorithm 2):** SHA-2 family of hash functions, such as SHA-256 and SHA-512, are widely used for generating message digests and providing integrity in SSH connections.
 [^fn-nth-6]: **UFW**: `UFW` stands for Uncomplicated Firewall. It is a user-friendly command-line tool for managing firewall rules on Linux systems.
