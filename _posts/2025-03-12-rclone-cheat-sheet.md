---
title: rClone Cheat Sheet
date: 2025-03-12 11:33:00 +0800
toc: true
categories: [cheat sheet]
tag: [linux]
---

rclone is a versatile command-line program to manage files on cloud storage. This cheat sheet covers essential commands for common tasks.

### Configuration

* **Configure rclone:**
    ```bash
    rclone config
    ```
* **List configured remotes:**
    ```bash
    rclone listremotes
    ```

### Basic File Operations

* **Copy files:**
    ```bash
    rclone copy source:path/to/source destination:path/to/destination
    ```
    * Copies files from `source` to `destination`.
* **Move files:**
    ```bash
    rclone move source:path/to/source destination:path/to/destination
    ```
    * Moves files from `source` to `destination` (deletes source files after successful transfer).
* **Sync directories:**
    ```bash
    rclone sync source:path/to/source destination:path/to/destination
    ```
    * Makes `destination` identical to `source`, deleting extra files in `destination`.
* **Delete files:**
    ```bash
    rclone delete remote:path/to/file
    ```
    * Deletes a single file.
* **Purge directory:**
    ```bash
    rclone purge remote:path/to/directory
    ```
    * Deletes a directory and all its contents. Use with caution!
* **Check for differences:**
    ```bash
    rclone check source:path/to/source destination:path/to/destination
    ```
    * Checks if source and destination are identical.

### Listing and Information

* **List files and directories:**
    ```bash
    rclone ls remote:path/to/directory
    ```
* **List files with size and modification time:**
    ```bash
    rclone lsl remote:path/to/directory
    ```
* **List directories only:**
    ```bash
    rclone lsd remote:path/to/directory
    ```
* **Display directory tree:**
    ```bash
    rclone tree remote:path/to/directory
    ```
* **Show remote usage statistics:**
    ```bash
    rclone about remote:
    ```

### Filtering and Options

* **Include files:**
    ```bash
    rclone copy source: destination: --include "*.txt"
    ```
* **Exclude files:**
    ```bash
    rclone copy source: destination: --exclude "*.tmp"
    ```
* **Verbose output:**
    ```bash
    rclone copy source: destination: -v
    ```
* **Progress display:**
    ```bash
    rclone copy source: destination: --progress
    ```
* **Dry run (no actual transfer):**
    ```bash
    rclone copy source: destination: --dry-run
    ```
* **Transfers number:**
    ```bash
    rclone copy source: destination: --transfers 8
    ```
    * Increase number of transfers for faster copies.
* **Check sums:**
    ```bash
    rclone copy source: destination: --checksum
    ```
    * Check sums after transfer.
* **Max age:**
    ```bash
    rclone copy source: destination: --max-age 7d
    ```
    * Only copy files newer than 7 days.
* **Min age:**
    ```bash
    rclone copy source: destination: --min-age 30d
    ```
    * Only copy files older than 30 days.

### Encryption (rclone crypt)

* **Create encrypted remote:**
    ```bash
    rclone config create encrypted crypt remote=remote:
    ```
    * Follow prompts to set encryption passwords.
* **Copy encrypted files:**
    ```bash
    rclone copy source: destination_encrypted:
    ```
* **Decrypt files:**
    ```bash
    rclone copy destination_encrypted: destination_decrypted:
    ```
* **Check encryption setup:**
    ```bash
    rclone cryptcheck source: destination_encrypted:
    ```

### Remote-to-Remote Transfers

* **Copy between remotes:**
    ```bash
    rclone copy remote1:path/to/source remote2:path/to/destination
    ```
* **Sync between remotes:**
    ```bash
    rclone sync remote1:path/to/source remote2:path/to/destination
    ```

### Mounting Remotes

* **Mount remote as a local directory:**
    ```bash
    rclone mount remote:path/to/directory /path/to/local/mount
    ```
* **Unmount remote:**
    ```bash
    fusermount -u /path/to/local/mount
    ```

### Useful Tips

**Example: Backing up a local directory to Google Drive (encrypted)**

```bash
rclone sync /path/to/local/directory gdrive_encrypted:backup/ --progress
```

**Example: Restoring from Google Drive (encrypted)**

```bash
rclone sync gdrive_encrypted:backup/ /path/to/restore/ --progress
```

Remember to replace placeholders like `source:`, `destination:`, `remote:`, and paths with your actual values. This cheat sheet provides a solid foundation for using rclone. Experiment with different commands and options to find the best workflow for your needs.
