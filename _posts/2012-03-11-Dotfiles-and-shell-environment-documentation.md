---
title: My Dotfiles and Shell Environment.
date: 2023-05-18 11:33:00 +0800
categories: [doc]
tags: [Linux, Shell, cli, zsh, vim]
---

> ⚠️ **Please note that there might be mistakes or inaccuracies.**
{: .prompt-warning }

This documentation provides an overview and detailed information about the my dotfiles  shell environment. The dotfiles repository contains a collection of configuration files and scripts used to customize and personalize my development environment over the years.

By utilizing these dotfiles, you can quickly set up and synchronize your preferred settings across different machines.

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Introduction](#introduction)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Available Options](#available-options)
- [Customization](#customization)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Introduction

Dotfiles are configuration files that define settings and preferences for various applications and tools. I forked the project from [Nick Nisi](https://github.com/nicknisi/dotfiles){:target="_blank"} a while back. These files are typically hidden files in the user's home directory and are named with a dot (e.g., `.bashrc`, `.vimrc`). Managing dotfiles in a centralized repository offers several benefits:

- **Consistency**: With dotfiles stored in a repository, you can easily maintain a consistent configuration across multiple machines.
- **Version Control**: Git version control enables tracking changes to dotfiles over time, allowing for easy rollback or reference.
- **Portability**: The dotfiles can be quickly deployed on new machines or shared with others, simplifying the setup process.
- **Customization**: Dotfiles are highly customizable, enabling you to tailor your environment to suit your specific needs and preferences.

This dotfiles project provides a well-organized structure and a set of scripts to streamline the installation and management of dotfiles.

## Getting Started

### Prerequisites

Before using these dotfiles, ensure that the following software is installed on your machine:

- Git
- Curl
- NeoVim
- NodeJS
- Homebrew
- Bash (version 4 or later)
- Zsh (optional, but recommended)

### Installation

To install and set up the dotfiles, follow these steps:

1. Clone the dotfiles repository to your local machine:

   ```bash
   git clone https://github.com/wilfrantz/dotfiles.git
   ```

2. Change into the dotfiles directory:

   ```bash
   cd dotfiles
   ```

3. Make the installation script executable:

   ```bash
   chmod +x install.sh
   ```

4. Run the installation script with the desired options. The available options are explained in the [Usage](#usage) section.

   ```bash
   ./install.sh <options>
   ```

   Example usage:

   ```bash
   ./install.sh all
   ```

   This command will execute all the available steps in the installation script.

   **Note:** It's essential to review and modify the installation script according to your preferences and requirements.

## Usage

The installation script provides several options to customize the installation process. You can execute specific steps individually or combine them using the available options.

### Available Options

- `backup`: Creates backups of existing dotfiles and configurations.
- `link`: Creates symlinks for the dotfiles.
- `git`: Sets up Git configuration.
- `homebrew`: Installs Homebrew and dependencies from the Brewfile.
- `shell`: Configures the default shell (Zsh).
- `terminfo`: Configures terminfo for better terminal support.
- `macos`: Configures macOS settings (optional).
- `all`: Executes all the steps mentioned above.

You can pass one or more options to the installation script to perform the desired actions. For example:

```bash
./install.sh backup link git
```

This command will create backups, set up symlinks, and configure Git.

## Customization

You can customize the dotfiles project to suit your specific requirements and preferences. Here are a few ways to do so:

- Modify the configuration files in the `config` directory to reflect your desired settings.
- Add or remove dotfiles according to your needs by modifying the `get_linkables` function in the installation script.
- Update the Git configuration in the installation script to match your name, email, and GitHub username.

Feel free to explore the dotfiles repository, understand the structure, and adapt it to fit your personal workflow.

## License

This project is licensed under the `MIT License`.

## Acknowledgments

The dotfiles project draws inspiration from various dotfiles repositories and contributions made by the community. The collaborative efforts of developers sharing their configurations have significantly influenced this project. You are encouraged to explore and adapt these dotfiles to enhance your own development environment.
