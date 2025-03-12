# Jekyll Development Environment with Docker

This repository contains a Jekyll website and a Dockerfile for setting up a local development environment.

## Purpose

This setup allows developers to easily run and test a Jekyll site within a Docker container, ensuring a consistent development environment. The site is hosted live on GitHub Pages, and this local setup is purely for development and testing purposes.

## Theme

This site uses the **Chirpy** theme, a feature-rich theme designed for a smooth out-of-the-box experience.

**Credit:** The Chirpy theme is developed and maintained by the Chirpy team. For more information, please visit the [theme's documentation](https://chirpy.cotes.page/).

**Note:** To fully utilize all features of the Chirpy theme, this repository includes critical files and configurations extracted from the theme's gem, as recommended by the theme's authors. This ensures a complete and functional development environment.

## AI Assistance

This project was developed with the assistance of **Gemini AI**, which provided guidance and code suggestions throughout the setup and documentation process.

## Prerequisites

* Docker installed on your development machine.
* Git installed.

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

This repository is automatically updated with new releases from the theme repository. If you encounter any issues or want to contribute to its improvement, please visit the [theme repository](https://www.google.com/url?sa=E&source=gmail&q=https://github.com/cotes2020/jekyll-theme-chirpy).

## License

This work is published under the **MIT License**.

