---
title: How to debug GitHub Actions and "layout home Index page" error.
date: 2023-05-18 11:33:00 +0800
categories: [Blogging, Tutorial]
tags: [Github pages, GitHub, Jekyll, Linux, Chirpy]
pin: false 
math: true
mermaid: true
image: 
  path: index-page-issue.png
  alt: --- layout home Index page ---
---

GitHub Actions provides a powerful way to automate the deployment of your Jekyll site to GitHub Pages. By configuring a workflow, you can streamline the process and ensure that updates to your `main` branch are automatically pushed to the `gh-pages` branch. I'll walk you through the steps for troubleshooting GitHub Actions for automatic and seamless deployment of GitHub Pages.

Before we proceed, if you're encountering the frustrating `--- layout: home # Index page ---` issue, it may be related to the image CDN path. 

In the `_config.yml` file, the `img_cdn` setting is currently set to `https://chirpy-img.netlify.app`, which might need to be changed.

In my case, I resolved this by creating a new directory within the `/assets` directory named `images` for all my post images. Then, I updated the img_cdn setting as follows:

from:

``` yml
img_cdn: "https://chirpy-img.netlify.app"
```

to

``` yml
img_cdn: "https://dede.dev/assets"
```

By making this modification, you can ensure that the image paths are correctly resolved for your Jekyll site. This will help resolve the '--- layout: home # Index page ---' issue you're facing. Remember to adjust the URL and directory names according to your specific setup.

### ***Let's get started !***

#### Step 1: Modify the Deployment Workflow

In your repository, navigate to the .github/workflows directory and locate the pages-deploy.yml file. Open the file and replace its contents with the following code:

``` yaml
name: Deploy to GitHub Pages

on:
  push:
    branches:
      - main

jobs:
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Setup deploy options
        id: setup
        run: |
          git config --global user.name "GitHub Action"
          git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"
          if [[ ${GITHUB_REF} = refs/pull/*/merge ]]; then # pull request
            echo "SRC_BRANCH=${GITHUB_HEAD_REF}" >> $GITHUB_OUTPUT
            echo "NO_PUSH=--no-push" >> $GITHUB_OUTPUT
          elif [[ ${GITHUB_REF} = refs/heads/* ]]; then # branch, e.g. main, source, etc.
            echo "SRC_BRANCH=${GITHUB_REF#refs/heads/}" >> $GITHUB_OUTPUT
          fi
          echo "DEPLOY_BRANCH=gh-pages" >> $GITHUB_OUTPUT

      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v1
```

#### Step 2: Grant Workflow Permissions

In your repository, go to "Settings" and click on "Actions" in the left sidebar. Under "Workflow permissions," select "Read and write" access for the GitHub Actions workflow.

#### Step 3: Configure GitHub Pages Branch

In your repository's settings, navigate to the "Pages" section. Under the "Build and deployment" heading, set the branch to "None" to prevent manual branch selection.

#### Step 4: Trigger the Workflow

Make a change to your site's content or configuration, and then push the changes to the main branch. This will trigger the GitHub Actions workflow to run, automatically generating the `gh-pages` branch.

#### Step 5: Select the Deployed Branch

Once the workflow completes successfully, go back to your repository's settings and navigate to the "Pages" section. Under "Build and deployment," select the `gh-pages` branch as the source.

### ***Conclusion***

By following this tutorial, you have successfully set up GitHub Actions to automatically deploy your Jekyll site to GitHub Pages. Enjoy the convenience of seamless updates and ensure that your GitHub Pages site is always up to date with your main branch.
