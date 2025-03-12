# Jekyll Development Environment with Docker

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Docker Build Status](https://img.shields.io/docker/build/yourusername/jekyll-local?style=flat-square)](https://hub.docker.com/r/yourusername/jekyll-local)
[![GitHub Pages Status](https://img.shields.io/badge/GitHub%20Pages-Active-brightgreen.svg?style=flat-square)](https://<your-github-username>.github.io/<your-repo-name>/)

This repository provides a Dockerized Jekyll development environment for local testing and previewing your site before deploying to GitHub Pages.

## Purpose

This setup enables a consistent and isolated environment for developing and testing your Jekyll site using Docker. It's designed for local development, with the live site hosted on GitHub Pages.

## Theme

This site uses the **Chirpy** theme, a clean and modern theme designed for a smooth out-of-the-box experience.

**Credit:** The Chirpy theme is developed and maintained by **Cotes Chung**. For more information, please visit the [theme's documentation](https://chirpy.cotes.page/).

**Note:** To ensure full functionality, this repository includes critical files and configurations extracted from the Chirpy theme's gem, as recommended by the author, ensuring a complete development environment.

## AI Assistance

This project was developed with the assistance of **Gemini AI**, which provided guidance and code suggestions throughout the setup and documentation process.

## Prerequisites

* [Docker](https://www.docker.com/get-started) installed on your development machine.
* [Git](https://git-scm.com/downloads) installed.

## Getting Started

1.  **Clone the Repository:**

    ```bash
    git clone <repository_url>
    cd <repository_name>
    ```

    Replace `<repository_url>` with the URL of this repository.

2.  **Build the Docker Image:**

    ```bash
    sudo docker build -t jekyll-local .
    ```

3.  **Run the Docker Container:**

    ```bash
    sudo docker run -p 4000:4000 -v "$PWD:/site" jekyll-local
    ```

4.  **Access the Site:**

    Open your web browser and go to `http://<your_machine_ip>:4000`.

    Replace `<your_machine_ip>` with the IP address of your machine.

## Development Workflow

1.  **Make Changes:**

    Modify the Jekyll site files in your local repository.

2.  **Preview Changes:**

    The changes will be reflected immediately in your browser, as the Docker container mounts your local directory.

3.  **Test Thoroughly:**

    Ensure all features and pages are working correctly.

4.  **Commit and Push:**

    ```bash
    git add .
    git commit -m "Describe your changes"
    git push origin <your_branch>
    ```

    Replace `<your_branch>` with your branch name.

5.  **GitHub Pages Deployment:**

    GitHub Pages will automatically deploy the updated site.

## Dockerfile Explanation

The `Dockerfile` sets up an Ubuntu-based environment with Ruby, Jekyll, and necessary dependencies.

```dockerfile
FROM ubuntu:latest

WORKDIR /site

# Install necessary packages
RUN apt-get update && apt-get install -y build-essential nodejs ruby-full ruby-dev bundler git && rm -rf /var/lib/apt/lists/*

# Copy only the Gemfile and Gemfile.lock (for faster builds)
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy your site files
COPY . .

# Expose the Jekyll server port
EXPOSE 4000

# Start the Jekyll server
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
```

* `FROM ubuntu:latest`: Uses the latest Ubuntu image as the base.
* `RUN apt-get ...`: Installs necessary packages, including Ruby, Jekyll, and Git.
* `COPY Gemfile ...`: Copies gem dependencies.
* `RUN bundle install`: Installs the Ruby gems.
* `COPY . .`: Copies the Jekyll site files.
* `EXPOSE 4000`: Exposes port 4000.
* `CMD ...`: Starts the Jekyll server.

## Contributing

This repository is automatically updated with new releases from the theme repository. If you encounter any issues or want to contribute to its improvement, please visit the [theme repository](https://github.com/cotes2020/jekyll-theme-chirpy).

## License

This work is published under the **MIT License**.
