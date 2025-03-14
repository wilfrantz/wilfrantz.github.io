---
title: My Go-To Guide for Linux System Hardening 
date: 2022-05-20 11:33:00 +0800
categories: [doc]
toc: true
tag: [Linux]
---

This guide provides practical insights and best practices to harden Debian-based (Ubuntu) Linux systems against cyber threats, focusing on the core security goals of the CIA Triad:

| **Security Goal** | **Description** |
|-------------------|-----------------|
| **Confidentiality** | Protecting data access to authorized users. |
| **Integrity** | Ensuring data remains unchanged and uncorrupted. |
| **Availability** | Maintaining reliable access to resources. |

## System Maintenance

Apply security patches and updates regularly:

```bash
sudo apt update && sudo apt upgrade
```

**Automatic Updates:**

- Install `unattended-upgrades`:

```bash
sudo apt install unattended-upgrades
```

- Configure `/etc/apt/apt.conf.d/50unattended-upgrades` (e.g., enable automatic reboots by uncommenting `//Unattended-Upgrade::Automatic-Reboot`).

```bash
sudo vim /etc/apt/apt.conf.d/50unattended-upgrades
```

- Enable the service:

```bash
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

- Manual Updates (Cron):

Schedule updates using `cron` (e.g., daily at 2:00 AM):

```bash
crontab -e
```

```bash
0 2 * * * apt update && apt upgrade -y
```

> Caution: Schedule updates carefully to avoid disruption.
{: .prompt-warning }

---

## User Account Security

Strong Password Policy:

Edit `/etc/pam.d/common-password` (e.g., using `pam_pwquality.so`):

```bash
sudo vim /etc/pam.d/common-password
```

Example:

```sh
password    requisite    pam_pwquality.so retry=3 minlen=8 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1
```

Enforce Regular Password Changes:

Edit `/etc/login.defs`:

```bash
sudo vim /etc/login.defs
```

Example:

```
PASS_MAX_DAYS   90
```

Remove/Disable Unnecessary User Accounts:

List accounts:

```bash
cat /etc/passwd
```

Disable account (e.g., "user1"):

```bash
sudo passwd --lock user1
```

Multi-Factor Authentication (MFA) for Privileged Accounts:

- Install MFA software (e.g., `Google Authenticator`).
- Configure MFA (e.g., `google-authenticator`).

Edit `/etc/ssh/sshd_config`:

```bash
sudo vim /etc/ssh/sshd_config
```

Set `ChallengeResponseAuthentication` to `yes`.

Restart SSH:

```bash
sudo service sshd restart
```
---

## Secure SSH Access

Limit Root Access:

Add non-root user to `sudoers` using `visudo`:

```bash
sudo visudo
```

Example:

```
dede ALL=(ALL:ALL) ALL
```

### Use SSH Keys for Authentication:

Generate key pair (e.g., ED25519):

```bash
ssh-keygen -t ed25519 -C "contact@dede.dev"
```

Copy public key:

```bash
ssh-copy-id -i path/to/certificate username@remote_host
```

Disable password authentication:

```bash 
vim /etc/ssh/sshd_config
```

```bash
PasswordAuthentication no
```

Restart SSH:

```bash
sudo service ssh restart
```

### Disable Direct Root Login:

Edit `/etc/ssh/sshd_config`:

``` bash
sudo vim /etc/ssh/sshd_config
```

Set `PermitRootLogin` to `no`.

Restart SSH:

```bash
sudo service sshd restart
```

### Restrict SSH Access by IP:

Edit `/etc/ssh/sshd_config`.

Example:

```
AllowUsers your_username@trusted_ip
```

Restart SSH.

### Use Strong Encryption Algorithms:

Edit `/etc/ssh/sshd_config`.

Ensure `Ciphers` and `MACs` include strong algorithms (e.g., AES[^footnote], ChaCha20-Poly1305[^fn-nth-2], Diffie-Hellman[^fn-nth-3], ECC[^fn-nth-4], SHA-2[^fn-nth-5]).
Restart SSH.

### Change Default SSH Port:

- Edit `/etc/ssh/sshd_config`. 

```bash
sudo vim /etc/ssh/sshd_config
```
- Change `Port` (e.g., to 2222).

- Restart SSH.

```bash
sudo service sshd restart
```

> Remember: Allow the new port through the firewall.
{: .prompt-tip }

---

## Firewall Configuration (UFW)

Choose a Firewall Tool (e.g., `iptables`, `UFW` [^fn-nth-6]).

```bash
sudo apt update
sudo apt install ufw
```

- Enable:

```bash
sudo ufw enable
```

- Default Policies:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

- Allow Specific Services/Ports (e.g., SSH):

```bash
sudo ufw allow ssh
```

- Review/Update Rules (UFW):

```bash
sudo ufw status numbered
```

- Modify/delete:

```bash
sudo ufw delete [rule_number]
sudo ufw insert [rule_number] [new_rule]
```

- Reload:

```bash
sudo ufw reload
```

---

## File System Hardening

### File System Encryption (e.g., `dm-crypt`, `LUKS`):

Install `cryptsetup`:

```bash
sudo apt-get install cryptsetup
```

Encrypt partition (e.g., `/dev/sdb1`):

```bash
sudo cryptsetup luksFormat /dev/sdb1
```

Open encrypted partition (e.g., `secure_data`):

```bash
sudo cryptsetup open /dev/sdb1 secure_data
```

Format (e.g., `ext4`) and mount (e.g., `/mnt/secure`):

```bash
sudo mkfs.ext4 /dev/mapper/secure_data
sudo mount /dev/mapper/secure_data /mnt/secure
```

Update `/etc/fstab` for automatic mounting.

### File Permissions/Access Restriction:

Identify sensitive files.
Set permissions (e.g., `database.conf`):

```bash
sudo chmod 600 /path/to/database.conf
```

### File Integrity Monitoring (e.g., `AIDE`, `Tripwire`):

Install `AIDE`:

```bash
sudo apt-get install aide -y
```

Initialize database:

```bash
sudo aideinit
```

Schedule checks (e.g., daily at midnight):

```bash
sudo crontab -e
```

Add to crontab:

```
0 0 * * * /usr/sbin/aide --check
```

---

## Network Services

List enabled services:

```bash
sudo systemctl list-unit-files --type=service | grep enabled
```

Disable Unnecessary Services (e.g., `avahi-daemon`, `cups`):

```bash
sudo systemctl disable avahi-daemon.service
sudo systemctl disable cups.service
```

> Caution: Verify service necessity before disabling.
{: .prompt-warning }

Update/Patch Software:

```bash
sudo apt update
sudo apt upgrade
```

Use Secure Protocols:

Use `HTTPS` for web management, `SFTP` for file transfer, `SSH` instead of `Telnet`.

---

## Logging and Auditing

Enable System Logging (`rsyslog`):

Check status:

```bash
sudo systemctl status rsyslog
```

Start:

```bash
sudo systemctl start rsyslog
```

Enable on boot:

```bash
sudo systemctl enable rsyslog
```

Secure Log Files:

```bash
sudo chown root:root /var/log
sudo chmod 0700 /var/log
```

Review Logs:

View recent entries (`/var/log/syslog`):

```bash
sudo tail -f /var/log/syslog
```

Search for patterns (e.g., `/var/log/auth.log`):

```bash
sudo cat /var/log/auth.log | grep 'Failed password'
```

Automate reviews (`logcheck`):

```bash
sudo apt-get install logcheck
```
**Centralized Log Management:**
**Logstash:**
Install:

```bash
wget -qO - [https://artifacts.elastic.co/GPG-KEY-elasticsearch](https://artifacts.elastic.co/GPG-KEY-elasticsearch) | sudo apt-key add -
echo "deb [https://artifacts.elastic.co/packages/7.x/apt](https://artifacts.elastic.co/packages/7.x/apt) stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update && sudo apt-get install logstash
```

Configure (e.g., `/etc/logstash/conf.d/01-netflow-input.conf`, `10-syslog-filter.conf`, `30-elasticsearch-output.conf`).
Start:

```bash
sudo systemctl start logstash
```

Enable on boot:

```bash
sudo systemctl enable logstash
```

Graylog:

Install MongoDB:

```bash
sudo apt update
sudo apt install -y mongodb
```

Install Elasticsearch:

```bash
wget -qO - [https://artifacts.elastic.co/GPG-KEY-elasticsearch](https://artifacts.elastic.co/GPG-KEY-elasticsearch) | sudo apt-key add -
echo "deb [https://artifacts.elastic.co/packages/7.x/apt](https://artifacts.elastic.co/packages/7.x/apt) stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update
sudo apt install -y elasticsearch
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl restart elasticsearch.service
```

Install Graylog:

```bash
wget [https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.deb](https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.deb)
sudo dpkg -i graylog-4.0-repository_latest.deb
sudo apt-get update
sudo apt-get install graylog-server
```

Configure (`/etc/graylog/server/server.conf`):

Set `password_secret` (e.g., using `pwgen -N 1 -s 96`).
* Set `root_password_sha2` (e.g., using `echo -n "Enter Your Password: " | sha256sum`).

Start:

```bash
sudo systemctl daemon-reload
sudo systemctl enable graylog-server.service
sudo systemctl start graylog-server.service
```

Access web interface: `http://your_server_ip:9000`

---

## Backup Strategy: Rclone & Google Drive

The transition from on-premises to cloud-based backup solutions is driven by scalability, flexibility, cost-effectiveness, and global accessibility. 

[Rclone](https://rclone.org/){: target="_blank"} is a command-line tool designed to manage files on cloud storage, it offers encryption, which makes it particularly well-suited for backups. It supports a wide range of cloud services, including Google Drive. 

Google Drive is known for its flexibility, portability, and reliability. 

#### Installation and Configuration

 * Install Rclone:

    ```bash
    sudo apt update
    sudo apt install rclone
    ```

 * Configure Rclone for Google Drive:
   * Run `rclone config` and follow the prompts.
   * Choose `"n) New remote"` and give it a name (e.g., "gdriveBackup").
   * Select `Google Drive` as the storage type.
   * When prompted for "client_id" and "client_secret," you can leave them blank for automatic configuration. 
     `Rclone` will open a browser window for authentication. On headless systems, please follow the prompt.
   * Grant `Rclone` access to your Google Drive.
   * Confirm the configuration.

### What to Backup
   * Identify critical data: `/etc/`, `/home/`, databases, application data, etc...
   * Consider using a combination of full and incremental backups.
 * Encryption:
   * Rclone supports server-side and client-side encryption. 

> Client-side encryption is highly recommended for Google Drive backups.
{: .prompt-tip }

   * When configuring your backup script, use the `--crypt-server-side` flag to encrypt the data before it leaves the system.
   * Example of creating an encrypted remote:

      ```bash
      rclone config create gdrive_encrypted crypt remote=gdrive_backup password=YOURPASSWORD password2=YOURSALTPASSWORD
      ```

   * Be sure to store your passwords in a secure location.
 * Compression:
   * Compress your data before uploading it to Google Drive to save space and reduce upload time.
   * Use `tar` or `gzip` for compression.
- Automation:
 * Create a Backup Script:
   * Write a shell script that performs the following:
     * Compresses the data.
     * Encrypts the compressed data.
     * Uses rclone to upload the encrypted data to Google Drive.
     * Deletes old backups (recommended).
   * Example script:

    ```bash
    #! /usr/bin/env bash

    # Configuration File (backupConfig.sh)
    source /path/to/backupConfig.sh

    # Log file location
    logFile="/var/log/backup.log"

    # Log function
    log() {
        echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$logFile"
    }

    # Validation
    if [[ -z "$backupDir" || -z "$rcloneRemote" || -z "$dataToBackup" || -z "$rcloneCryptRemote" ]]; then
        log "ERROR: Configuration missing. Check backupConfig.sh."
        exit 1
    fi

    # Create Temporary Directory
    tmpDir=$(mktemp -d /tmp/backup.XXXXXX)
    if [[ -z "$tmpDir" ]]; then
        log "ERROR: Failed to create temporary directory."
        exit 1
    fi

    dateStamp=$(date +%Y%m%d%H%M)
    fileName="serverBackup_$dateStamp.tar.gz"
    backupFile="$tmpDir/$fileName"
    encryptedFile="$tmpDir/$fileName.enc"

    # Check if data exists
    for dir in $dataToBackup; do
        if [[ ! -e "$dir" ]]; then
            log "ERROR: Directory/File '$dir' does not exist."
            rm -rf "$tmpDir"
            exit 1
        fi
    done

    # Compress Data
    log "INFO: Starting compression."
    tar -czvf "$backupFile" $dataToBackup
    if [[ $? -ne 0 ]]; then
        log "ERROR: Compression failed."
        rm -rf "$tmpDir"
        exit 1
    fi
    log "INFO: Compression complete."

    # Encrypt the file
    log "INFO: Starting encryption."
    rclone cryptcheck "$backupFile" "$rcloneCryptRemote" # Check if rclone crypt is set up correctly
    if [[ $? -ne 0 ]]; then
        log "ERROR: Encryption check failed. Ensure rclone crypt is configured."
        rm -rf "$tmpDir"
        exit 1
    fi

    rclone copy "$backupFile" "$rcloneCryptRemote" --progress
    if [[ $? -ne 0 ]]; then
        log "ERROR: Encryption failed."
        rm -rf "$tmpDir"
        exit 1
    fi

    log "INFO: Encryption complete."


    # Upload to Google Drive
    log "INFO: Starting upload to Google Drive."
    rclone copy "$backupFile" "$rcloneCryptRemote" --progress
    if [[ $? -ne 0 ]]; then
        log "ERROR: Upload to Google Drive failed."
        rm -rf "$tmpDir"
        exit 1
    fi
    log "INFO: Upload to Google Drive complete."

    # Cleanup
    rm -rf "$tmpDir"
    log "INFO: Backup complete."

    exit 0
    ```
  * Configuration File (backupConfig.sh):

    ```bash
    #! /usr/bin/env bash

    # Configuration Variables
    export backupDir="/path/to/backup" 
    export rcloneRemote="gdriveBackup:" # or "gdrive_backup:" if you do not use crypt
    export rcloneCryptRemote="gdrive_encrypted:" # rclone encrypted remote
    export dataToBackup="/etc /home " # Add data 
    ```

 * Schedule Backups with Cron:
   * Run `crontab -e` and add a line like this to run the script weekly at 2:00 AM on Sundays.

    ```bash
    # Weekly @ 2:00 AM on Sundays:
    0 2 * * 0 /path/to/backup_script.sh
    ```

#### Security Considerations
 * Rclone Configuration:
   Store your Rclone configuration file (`~/.config/rclone/rclone.conf`) securely. Restrict access to the backup script and Rclone configuration.
 * Encryption Keys:
   Protect your encryption keys and passwords, consider using a password manager.
 * Google Account Security:
   Enable two-factor authentication (2FA) on your Google account, use a strong, unique password for your Google account.

#### Logging & Monitoring

It's crucial to log backup activity, and `systemd` is very efficient for monitoring backup services. It is equally important to test restores to verify integrity and functionality of backups.

---

## Conclusion

Securing a Linux system is an ongoing process that requires vigilance and adaptation. This guide outlined essential hardening techniques, from basic system updates to some advanced security measures. These practices can significantly reduce attack surface and protect sensitive data.

Remember that staying informed about the latest security threats and regularly reviewing security posture are crucial for maintaining a robust defense. As technology evolves and new vulnerabilities emerge, continuous learning and adaptation are key to ensuring the long-term security of your Linux environment.

## Resources

- [Limit SSH access to specific clients by IP address](https://unix.stackexchange.com/questions/406245/limit-ssh-access-to-specific-clients-by-ip-address){:target="\_blank"}
- [How To Secure A Linux Server by imthenachoman](https://github.com/imthenachoman/How-To-Secure-A-Linux-Server?utm_source=pocket_saves){:target="\_blank"}
- [40 Linux Server Hardening Security Tips \[2023 edition\]](https://www.cyberciti.biz/tips/linux-security.html){:target="\_blank"}
- [Linux Security and Hardening, The Practical Security Guide by Jason Cannon](https://www.udemy.com/course/linux-security/){:target="\_blank"}
- [The Future of Cloud Backup: a Multi-Cloud Perspective](https://n2ws.com/blog/future-of-cloud){:target="\_blank"}
- [Gemini AI](https://blog.google/technology/ai/google-gemini-ai/){:target="\_blank"}

---

## Reverse Footnote

[^footnote]: **AES (Advanced Encryption Standard):** AES is a widely used symmetric encryption algorithm that provides strong security. It supports key sizes of 128, 192, and 256 bits.
[^fn-nth-2]: **ChaCha20-Poly1305:** This is a modern symmetric encryption algorithm that offers high security and performance. It is often considered as an alternative to AES.
[^fn-nth-3]: **Diffie-Hellman (DH) Key Exchange:** DH is a secure key exchange algorithm used to establish a shared secret key between the client and server. It ensures secure communication by allowing the parties to generate a shared secret without transmitting it over the network.
[^fn-nth-4]: **Elliptic Curve Cryptography (ECC):** ECC is a modern public-key cryptography algorithm that offers strong security with relatively shorter key lengths compared to traditional algorithms like RSA. It is widely used in SSH for key exchange and authentication.
[^fn-nth-5]: **SHA-2 (Secure Hash Algorithm 2):** SHA-2 family of hash functions, such as SHA-256 and SHA-512, are widely used for generating message digests and providing integrity in SSH connections.
[^fn-nth-6]: **UFW**: `UFW` stands for Uncomplicated Firewall. It is a user-friendly command-line tool for managing firewall rules on Linux systems.
