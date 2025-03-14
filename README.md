
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Docker Build Status](https://img.shields.io/docker/build/yourusername/jekyll-local?style=flat-square)](https://hub.docker.com/r/yourusername/jekyll-local)
[![GitHub Pages Status](https://img.shields.io/badge/GitHub%20Pages-Active-brightgreen.svg?style=flat-square)](https://github.com/wilfrantz/wilfrantz.github.io)

This repository is a Dockerized deployment of `Chirpy` on a Debian-based environment.

## Theme

**Chirpy** is a clean and modern theme designed for a smooth out-of-the-box experience. It is developed and maintained by **Cotes Chung**. For more information, please visit the [theme's documentation](https://chirpy.cotes.page/).

## AI Assistance

This project was developed with the assistance of **Gemini AI**.

## Prerequisites

* [Docker](https://www.docker.com/get-started) installed on your development machine.
* [Git](https://git-scm.com/downloads) installed.

## Getting Started

1.  **Clone the Repository:**

    ```bash
    git clone https://github.com/rbenv/ruby-build.git
    ```

    Replace `https://github.com/rbenv/ruby-build.git` with the URL of this repository.

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

## Contributing

This repository is automatically updated with new releases from the theme repository. If you encounter any issues or want to contribute to its improvement, please visit the [theme repository](https://github.com/cotes2020/jekyll-theme-chirpy).

## License

This work is published under the **MIT License**.
