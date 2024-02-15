---
title: Comprehensive Guide to Configuring Let's Encrypt SSL Certificate
date: 2021-08-13 11:33:00 +0800
categories: [Blogging, Doc]
tags: [Linux, SSL, Apache]
pin: false 
math: true
mermaid: true
---

## Step-by-Step Guide: Configuring Let's Encrypt Certificate

Let's Encrypt is a free and open certificate authority that provides digital certificates for securing websites. This step-by-step guide will walk you through the process of configuring a Let's Encrypt certificate for your website. By the end of this guide, you will have a valid SSL certificate installed and configured on your web server.

Table of contents

- [Step-by-Step Guide: Configuring Let's Encrypt Certificate](#step-by-step-guide-configuring-lets-encrypt-certificate)
- [Prerequisites](#prerequisites)
- [Install Certbot](#install-certbot)
- [Choose Web Server Plugin](#choose-web-server-plugin)
- [Generate and Configure the Certificate](#generate-and-configure-the-certificate)
- [Verify Certificate Installation](#verify-certificate-installation)
- [Automate Certificate Renewal (optional)](#automate-certificate-renewal-optional)
- [Conclusion](#conclusion)

## Prerequisites

Before proceeding with the Let's Encrypt configuration, ensure you have the following:

1. A web server (e.g., Apache, Nginx) installed and running.
2. Root access or administrative privileges to configure the server.
3. A registered domain name pointed to the server's IP address.

## Install Certbot

Certbot is a command-line tool used to automate the Let's Encrypt certificate issuance and installation process. To install Certbot, follow these general steps:

1. Open a terminal or SSH session to your server.
2. Update the package manager

    for Ubuntu/Debian

    ```shell
    sudo apt update
    ```

    for CentOS/RHEL

   ```shell
   sudo yum update
   ```

3. Install Certbot

    for Ubuntu/Debian

    ```shell
    sudo apt install certbot
    ```

    for CentOS/RHEL

    ```shell
    sudo yum install certbot
    ```

## Choose Web Server Plugin

Certbot provides different plugins based on your web server. Select the appropriate plugin for your web server:

1. For Apache, use the Apache plugin

    for Ubuntu/Debian

   ```shell
   sudo apt install python3-certbot-apache
   ```

    for CentOS/RHEL

   ```shell
   sudo yum install python3-certbot-apache
   ```

2. For Nginx, use the Nginx plugin

    for Ubuntu/Debian

   ```shell
   sudo apt install python3-certbot-nginx
   ```

    for CentOS/RHEL

   ```shell
   sudo yum install python3-certbot-nginx
   ```

3. If you have a different web server, consult Certbot's documentation for the relevant plugin.

## Generate and Configure the Certificate

Now, let's generate and configure the Let's Encrypt certificate:

1. Stop your web server temporarily to avoid conflicts:

    for Apache

    ```shell
    sudo systemctl stop apache2
    ```

    for Nginx

    ```shell
    sudo systemctl stop nginx
    ```

2. Run Certbot to generate and configure the certificate:

    for Apache

    ```shell
    sudo certbot --apache 
    ```

    for Nginx

   ```shell
   sudo certbot --nginx
   ```

Follow the on-screen prompts to provide the necessary information (e.g., domain name, email address).

1. Certbot will automatically communicate with Let's Encrypt, generate the certificate, and configure your web server to use it.
2. Start your web server again: `sudo systemctl start apache2` (for Apache) or `sudo systemctl start nginx` (for Nginx).

## Verify Certificate Installation

To ensure the Let's Encrypt certificate is installed correctly, perform the following checks:

1. Open a web browser and navigate to your website using HTTPS (e.g., `https://www.example.com`).
2. Verify that the browser displays a padlock icon indicating a secure connection.
3. Use an SSL checker tool online to verify the SSL certificate installation and expiration date.

## Automate Certificate Renewal (optional)

Let's Encrypt certificates expire every 90 days. Automating the renewal process ensures your website remains secure. Use Certbot's automatic renewal feature by setting up a cron job:

1. Open a terminal or SSH session to your server.
2. Run the following command to edit the crontab: `sudo crontab -e`
3. Add the following line to the crontab file to schedule the renewal check:

   ```shell
   0 0 1 * * certbot renew
   ```

4. Save the crontab file and exit the editor.

## Conclusion

Congratulations! You have successfully configured a Let's Encrypt certificate for your website. Your website is now secured with an SSL certificate, enabling encrypted communication between your visitors and the server. Remember to monitor certificate expiration and set up automatic renewal to ensure ongoing security.
