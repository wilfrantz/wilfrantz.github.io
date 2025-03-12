---
title: Practical Guide to Linux System Hardening
date: 2022-05-20 11:33:00 +0800
categories: [doc]
tags: [Linux]
toc: true
---

This guide provides practical insights and best practices to harden Debian-based (Ubuntu) Linux systems against cyber threats, focusing on the core security goals of the CIA Triad:

* **Confidentiality:** Protecting data access to authorized users.
* **Integrity:** Ensuring data remains unchanged and uncorrupted.
* **Availability:** Maintaining reliable access to resources.

## System Maintenance

### Keep Your System Up to Date

    * Apply security patches and updates regularly:

        ```bash
        sudo apt update && sudo apt upgrade
        ```

    * **Automatic Updates:**

        * Install `unattended-upgrades`:

            ```bash
            sudo apt install unattended-upgrades
            ```

        * Configure `/etc/apt/apt.conf.d/50unattended-upgrades` (e.g., enable automatic reboots by uncommenting `//Unattended-Upgrade::Automatic-Reboot`).
        * Enable the service:

            ```bash
            sudo dpkg-reconfigure --priority=low unattended-upgrades
            ```

    * **Manual Updates (Cron):**

        * Schedule updates using `cron` (e.g., daily at 2:00 AM):

            ```bash
            0 2 * * * apt update && apt upgrade -y
            ```

        * **Caution:** Schedule updates carefully to avoid disruption.

## User Account Security

    * **Strong Password Policy:**

        * Edit `/etc/pam.d/common-password` (e.g., using `pam_pwquality.so`):

            ```bash
            sudo vi /etc/pam.d/common-password
            ```

        * Example:

            ```
            password    requisite    pam_pwquality.so retry=3 minlen=8 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1
            ```

    * **Enforce Regular Password Changes:**

        * Edit `/etc/login.defs`:

            ```bash
            sudo vi /etc/login.defs
            ```

        * Example:

            ```
            PASS_MAX_DAYS   90
            ```

    * **Remove/Disable Unnecessary User Accounts:**

        * List accounts:

            ```bash
            cat /etc/passwd
            ```

        * Disable account (e.g., "user1"):

            ```bash
            sudo passwd --lock user1
            ```

    * **Multi-Factor Authentication (MFA) for Privileged Accounts:**

        * Install MFA software (e.g., `Google Authenticator`).
        * Configure MFA (e.g., `google-authenticator`).
        * Edit `/etc/ssh/sshd_config`:

            ```bash
            sudo vi /etc/ssh/sshd_config
            ```

        * Set `ChallengeResponseAuthentication` to `yes`.
        * Restart SSH:

            ```bash
            sudo service sshd restart
            ```

## Secure SSH Access

    * **Limit Root Access:**

        * Add non-root user to `sudoers` using `visudo`:

            ```bash
            visudo
            ```

        * Example:

            ```
            dede ALL=(ALL:ALL) ALL
            ```

    * **Use SSH Keys for Authentication:**

        * Generate key pair (e.g., ED25519):

            ```bash
            ssh-keygen -t ed25519 -C "yourEmail@example.com"
            ```

        * Copy public key:

            ```bash
            ssh-copy-id -i path/to/certificate username@remote_host
            ```

        * Disable password authentication in `/etc/ssh/sshd_config`:

            ```bash
            PasswordAuthentication no
            ```

        * Restart SSH:

            ```bash
            sudo service ssh restart
            ```

    * **Disable Direct Root Login:**

        * Edit `/etc/ssh/sshd_config`:

            ```bash
            sudo vi /etc/ssh/sshd_config
            ```

        * Set `PermitRootLogin` to `no`.
        * Restart SSH:

            ```bash
            sudo service sshd restart
            ```

    * **Restrict SSH Access by IP:**

        * Edit `/etc/ssh/sshd_config`.
        * Example:

            ```
            AllowUsers your_username@trusted_ip
            ```

        * Restart SSH.

    * **Use Strong Encryption Algorithms:**

        * Edit `/etc/ssh/sshd_config`.
        * Ensure `Ciphers` and `MACs` include strong algorithms (e.g., AES, ChaCha20-Poly1305, Diffie-Hellman, ECC, SHA-2).
        * Restart SSH.

    * **Change Default SSH Port:**

        * Edit `/etc/ssh/sshd_config`.
        * Change `Port` (e.g., to 2222).
        * Restart SSH.
        * **Remember:** Allow the new port through the firewall.

## Firewall Configuration

    * **Choose a Firewall Tool** (e.g., `iptables`, `UFW`).
    * **Install** (if needed):

        ```bash
        sudo apt update
        sudo apt install ufw
        ```

    * **Enable:**

        ```bash
        sudo ufw enable
        ```

    * **Default Policies:**

        ```bash
        sudo ufw default deny incoming
        sudo ufw default allow outgoing
        ```

    * **Allow Specific Services/Ports** (e.g., SSH):

        ```bash
        sudo ufw allow ssh
        ```

    * **Review/Update Rules** (UFW):

        * List rules:

            ```bash
            sudo ufw status numbered
            ```

        * Modify/delete:

            ```bash
            sudo ufw delete [rule_number]
            sudo ufw insert [rule_number] [new_rule]
            ```

        * Reload:

            ```bash
            sudo ufw reload
            ```

## File System Hardening

    * **File System Encryption** (e.g., `dm-crypt`, `LUKS`):

        * Install `cryptsetup`:

            ```bash
            sudo apt-get install cryptsetup
            ```

        * Encrypt partition (e.g., `/dev/sdb1`):

            ```bash
            sudo cryptsetup luksFormat /dev/sdb1
            ```

        * Open encrypted partition (e.g., `secure_data`):

            ```bash
            sudo cryptsetup open /dev/sdb1 secure_data
            ```

        * Format (e.g., `ext4`) and mount (e.g., `/mnt/secure`):

            ```bash
            sudo mkfs.ext4 /dev/mapper/secure_data
            sudo mount /dev/mapper/secure_data /mnt/secure
            ```

        * Update `/etc/fstab` for automatic mounting.

    * **File Permissions/Access Restriction:**

        * Identify sensitive files.
        * Set permissions (e.g., `database.conf`):

            ```bash
            sudo chmod 600 /path/to/database.conf
            ```

    * **File Integrity Monitoring** (e.g., `AIDE`, `Tripwire`):

        * Install `AIDE`:

            ```bash
            sudo apt-get install aide -y
            ```

        * Initialize database:

            ```bash
            sudo aideinit
            ```

        * Schedule checks (e.g., daily at midnight):

            ```bash
            sudo crontab -e
            ```

        * Add to crontab:

            ```
            0 0 * * * /usr/sbin/aide --check
            ```

## Network Services

    * **Disable Unnecessary Services:**

        * List enabled services:

            ```bash
            sudo systemctl list-unit-files --type=service | grep enabled
            ```

        * Disable service (e.g., `avahi-daemon`, `cups`):

            ```bash
            sudo systemctl disable avahi-daemon.service
            sudo systemctl disable cups.service
            ```

        * **Caution:** Verify service necessity before disabling.

    * **Update/Patch Software:**

        * Debian-based:

            ```bash
            sudo apt update
            sudo apt upgrade
            ```

        * Red Hat-based:

            ```bash
            sudo yum update
            sudo dnf upgrade
            ```

    * **Use Secure Protocols:**

        * Use `HTTPS` for web management, `SFTP` for file transfer, `SSH` instead of `Telnet`.

## Logging and Auditing

    * **Enable System Logging** (`rsyslog`):

        * Check status:

            ```bash
            sudo systemctl status rsyslog
            ```

        * Start:

            ```bash
            sudo systemctl start rsyslog
            ```

        * Enable on boot:

            ```bash
            sudo systemctl enable rsyslog
            ```

    * **Secure Log Files:**

        ```bash
        sudo chown root:root /var/log
        sudo chmod 0700 /var/log
        ```

    * **Review Logs:**

        * View recent entries (`/var/log/syslog`):

            ```bash
            sudo tail -f /var/log/syslog
            ```

        * Search for patterns (e.g., `/var/log/auth.log`):

            ```bash
            sudo cat /var/log/auth.log | grep 'Failed password'
            ```

        * Automate reviews (`logcheck`):

            ```bash
            sudo apt-get install logcheck
            ```

    * **Centralized Log Management:**

        * **Logstash:**

            * Install:

                ```bash
                wget -qO - [https://artifacts.elastic.co/GPG-KEY-elasticsearch](https://artifacts.elastic.co/GPG-KEY-elasticsearch) | sudo apt-key add -
                echo "deb [https://artifacts.elastic.co/packages/7.x/apt](https://artifacts.elastic.co/packages/7.x/apt) stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
                sudo apt-get update && sudo apt-get install logstash
                ```

            * Configure (e.g., `/etc/logstash/conf.d/01-netflow-input.conf`, `10-syslog-filter.conf`, `30-elasticsearch-output.conf`).
            * Start:

                ```bash
                sudo systemctl start logstash
                ```

            * Enable on boot:

                ```bash
                sudo systemctl enable logstash
                ```

        * **Graylog:**

            * Install MongoDB:

                ```bash
                sudo apt update
                sudo apt install -y mongodb
                ```

            * Install Elasticsearch:

                ```bash
                wget -qO - [https://artifacts.elastic.co/GPG-KEY-elasticsearch](https://artifacts.elastic.co/GPG-KEY-elasticsearch) | sudo apt-key add -
                echo "deb [https://artifacts.elastic.co/packages/7.x/apt](https://artifacts.elastic.co/packages/7.x/apt) stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
                sudo apt update
                sudo apt install -y elasticsearch
                sudo systemctl daemon-reload
                sudo systemctl enable elasticsearch.service
                sudo systemctl restart elasticsearch.service
                ```

            * Install Graylog:

                ```bash
                wget [https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.deb](https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.deb)
                sudo dpkg -i graylog-4.0-repository_latest.deb
                sudo apt-get update
                sudo apt-get install graylog-server
                ```

            * Configure (`/etc/graylog/server/server.conf`):

                * Set `password_secret` (e.g., using `pwgen -N 1 -s 96`).
                * Set `root_password_sha2` (e.g., using `echo -n "Enter Your Password: " | sha256sum`).

            * Start:

                ```bash
                sudo systemctl daemon-reload
                sudo systemctl enable graylog-server.service
                sudo systemctl start graylog-server.service
                ```

            * Access web interface: `http://your_server_ip:9000`

## Regular Backups

    * **Determine Critical Data:**

        * System configurations (`/etc/`)
        * User data (`/home/`)
        * Database files
        * Custom applications/configurations

    * **Choose a Backup Tool:**

        * `rsync`
        * `tar`
        * `duplicity`
        * `BorgBackup`

    * **Automate Backups** (e.g., `cron`):

        * Example (rsync, daily at 2 AM):

            ```bash
            0 2 * * * rsync -a /home/ /path/to/backup/location/
            ```

    * **Secure Backup Storage:**

        * Dedicated backup server/drive (on-site).
        * Encrypt backups (e.g., `duplicity`, `BorgBackup`).
        * Cloud storage (with encryption).
        * Rotate backups/retention policies.

    * **Offsite Storage:**

        * Cloud storage (secure).
        * Physical media (secure transport).

    * **Test Restoration:**

        * Periodically test in a test environment.
        * Document the restoration process.
        * Securely store decryption keys (if used).

    * **Review and Adjust:**

        * Regularly review backup content.
        * Adjust schedules/storage as needed.

## Continuous Monitoring

    * Intrusion Detection Systems (IDS)/Intrusion Prevention Systems (IPS).
    * Security Information and Event Management (SIEM) tools.
     
## Resources

- [Limit SSH access to specific clients by IP address](https://unix.stackexchange.com/questions/406245/limit-ssh-access-to-specific-clients-by-ip-address){:target="\_blank"}
- [How To Secure A Linux Server by imthenachoman](https://github.com/imthenachoman/How-To-Secure-A-Linux-Server?utm_source=pocket_saves){:target="\_blank"}
- [40 Linux Server Hardening Security Tips \[2023 edition\]](https://www.cyberciti.biz/tips/linux-security.html){:target="\_blank"}
- [Linux Security and Hardening, The Practical Security Guide by Jason Cannon](https://www.udemy.com/course/linux-security/learn/lecture/4624500?start=0#overview){:target="\_blank"}
- **Gemini AI**

## Footnote

[^footnote]: **AES (Advanced Encryption Standard):** AES is a widely used symmetric encryption algorithm that provides strong security. It supports key sizes of 128, 192, and 256 bits.
[^fn-nth-2]: **ChaCha20-Poly1305:** This is a modern symmetric encryption algorithm that offers high security and performance. It is often considered as an alternative to AES.
[^fn-nth-3]: **Diffie-Hellman (DH) Key Exchange:** DH is a secure key exchange algorithm used to establish a shared secret key between the client and server. It ensures secure communication by allowing the parties to generate a shared secret without transmitting it over the network.
[^fn-nth-4]: **Elliptic Curve Cryptography (ECC):** ECC is a modern public-key cryptography algorithm that offers strong security with relatively shorter key lengths compared to traditional algorithms like RSA. It is widely used in SSH for key exchange and authentication.
[^fn-nth-5]: **SHA-2 (Secure Hash Algorithm 2):** SHA-2 family of hash functions, such as SHA-256 and SHA-512, are widely used for generating message digests and providing integrity in SSH connections.
[^fn-nth-6]: **UFW**: `UFW` stands for Uncomplicated Firewall. It is a user-friendly command-line tool for managing firewall rules on Linux systems.
