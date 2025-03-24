---
title: Dockerizing this Chirpy-Themed Jekyll Site Step by Step
date: 2025-03-07 11:33:00 +0800
mermaid: true
toc: true
categories: [doc]
---

This document outlines the steps to set up a Dockerized development environment for this portfolio (Chirpy-themed Jekyll site) on Debian Linux. The steps here were tested on a Parallels virtual machine (VM) running `Ubuntu 24.04.2 LTS`.

## Setting Up Ruby 3.2.2

This section details setting up `Ruby 3.2.2`, a foundational step for consistent Docker image builds.

### Installation Steps

4.  **Update Package Lists:**

    ```bash
    sudo apt update
    ```

5.  **Install Git and `rbenv`:**

    Git for repository management, `rbenv` for precise Ruby version control.

    ```bash
    sudo apt install git rbenv
    ```

6.  **Initialize `rbenv`:**

    Configuring `rbenv` for Ruby version management.

    ```bash
    rbenv init
    ```

7.  **Remove System-Installed `ruby-build`:**

    Removes potential system-installed `ruby-build` to ensure we use the latest version from Git.

    ```bash
    sudo apt remove ruby-build
    ```

8.  **Installs `ruby-build` from Git for the latest Ruby definitions:**

    ```bash
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    ```


9.  **Install Required Development Libraries:**

    ```bash
    sudo apt install libffi-dev zlib1g-dev libyaml-dev libreadline-dev ruby-dev
    ```

10. **Install Ruby 3.2.2:** Install the exact Ruby version required by the Jekyll site.

    ```bash
    rbenv install 3.2.2
    ```
11. **Set the global Ruby Version:**
    ```bash
    rbenv global 3.2.2
    ```

12. **Verify Ruby Installation:** Confirm the correct Ruby version.

    ```bash
    ruby -v
    ```
1. **Install Bundler:** Install Bundler for managing Ruby gem dependencies.

    ```bash
    gem install bundler
    ```


## Cloning Repository and Installing Dependencies

This section covers cloning the repository and installing its dependencies.

### Installation Steps

2.  **Clone the Jekyll Repository:**

    ```bash
    git clone git@github.com:wilfrantz/wilfrantz.github.io.git
    ```

3.  **Install Jekyll Dependencies:**

    cd into the repository and run the command below to install required Ruby gems specified in the `Gemfile`.

    ```bash
    bundle install
    ```


## Building the Docker Image

This section details building the Docker image. At the time of writing, `jekyll/jekyll:latest` resulted in an architecture mismatch error on `arm64` systems, use rosetta ubuntu image on silicon MacOS systems. `Dockerfile` use `ubuntu:latest`:

6.  **Build the Docker Image:**

    ```bash
    sudo docker build -t jekyll-local .
    ```

7.  **Run the Docker Container:**

    ```bash
    sudo docker run -p 4000:4000 -v "$PWD:/site" jekyll-local
    ```
    * Open a web browser on a device on your home network.
    * Enter the server's IP address and port 4000 (e.g., `http://10.211.55.43:4000`).
