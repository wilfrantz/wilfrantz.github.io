---
title: Step By Step Guide To Installing Lamp Stack On Ubuntu. 
date: 2023-05-17 11:33:00 +0800
categories: [Blogging, Tutorial]
tags: [Lamp, Linux, PHP, MySQL, Apache]
pin: false
math: true
mermaid: true
image: 
    path: lamp_stack.png
    alt: lamp stack.
---

## Introduction

The LAMP stack, which stands for Linux, Apache, MySQL, and PHP, is a popular open-source web development environment. In this tutorial, we will walk you through the step-by-step process of installing LAMP on a Linux system. Let's get started!

### Step 1: Update System Packages

Before we begin, it's always a good practice to update the system packages to ensure you have the latest versions. Open the terminal and run the following command:

``` bash
sudo apt update
sudo apt upgrade
```

### Step 2: Install Apache

Apache is the web server component of the LAMP stack. To install Apache, run the following command:

``` bash
sudo apt install apache2
```

Once the installation is complete, Apache will start automatically. You can verify its status by entering your server's IP address in a web browser. If Apache is installed correctly, you will see the default Apache landing page.

### Step 3: Install MySQL

MySQL is a widely-used open-source relational database management system. To install MySQL, run the following command:

``` bash
sudo apt install mysql-server
```

During the installation process, you will be prompted to set a root password for MySQL. Make sure to choose a strong password and remember it.

After the installation, run the following command to secure your MySQL installation:

``` bash
sudo mysql_secure_installation
```

This script will guide you through securing various aspects of MySQL, including setting a new root password, removing anonymous users, and disabling remote root login.

### Step 4: Install PHP

PHP is a server-side scripting language used to develop dynamic web applications. To install PHP, run the following command:

``` bash
sudo apt install php libapache2-mod-php php-mysql
```

This command will install PHP, the Apache module for PHP, and the PHP extension for MySQL.

### Step 5: Test PHP

To ensure PHP is installed and working correctly, create a test PHP file. Use the following command to create the file:

``` bash
sudo nano /var/www/html/info.php
```

In the text editor, add the following line:

``` bash
<?php phpinfo(); ?>
```

Save and close the file. Now, open a web browser and enter your server's IP address followed by `"/info.php"`. If PHP is installed properly, you will see the PHP information page.

### Step 6: Configure Apache for PHP

By default, Apache does not recognize PHP files. We need to configure Apache to process PHP files correctly. Open the Apache configuration file using the following command:

``` bash
sudo nano /etc/apache2/mods-enabled/dir.conf
```

Move the "index.php" file before "index.html" within the `<IfModule mod_dir.c>` section. Save and close the file.

Restart Apache to apply the changes:

``` bash
sudo systemctl restart apache2
```

### Step 7: Finalize Installation

At this point, you have successfully installed the LAMP stack on your Linux system. You can now start developing and deploying web applications using Apache, MySQL, and PHP.

## Conclusion

In this tutorial, we walked through the step-by-step process of installing the LAMP stack on a Linux system. By following these instructions, you now have a fully functional web development environment that can be used for creating dynamic and powerful web applications. Enjoy coding with your new LAMP stack!
