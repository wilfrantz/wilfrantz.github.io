# **Wilfrantz's Blog - Hugo Coder**

[![GitHub license](https://img.shields.io/github/license/wilfrantz/wilfrantz.github.io?color=blue)](LICENSE)

This repository hosts my personal blog, built with **Hugo** and the **Hugo-Coder** theme. The site is deployed on **GitHub Pages** and available at **[dede.dev](https://dede.dev/)**.

---

## **🚀 Features**

- 🔥 **Built with Hugo** - A fast, lightweight static site generator
- 🎨 **Hugo-Coder Theme** - A clean, developer-friendly theme
- 🌍 **Custom Domain** - Hosted at **dede.dev**
- 📌 **GitHub Pages Deployment** - Uses `gh-pages` branch
- 🛠 **Continuous Deployment** - Auto-deploys on every push

---

## **📌 Prerequisites**

To run this project locally, you need:

- **Hugo** ([Install Hugo](https://gohugo.io/getting-started/installing/))
- **Git** ([Install Git](https://git-scm.com/))

---

## **💡 Installation & Setup**

### **1️⃣ Clone the Repository**

```sh
git clone https://github.com/wilfrantz/wilfrantz.github.io.git
cd wilfrantz.github.io
```

### **2️⃣ Install Hugo**

On Ubuntu:

```sh
sudo apt install hugo
```

On macOS (Homebrew):

```sh
brew install hugo
```

### **3️⃣ Run the Site Locally**

```sh
hugo server --bind 0.0.0.0 --baseURL http://localhost:1313/
```

Your site should be available at `http://localhost:1313/`.

---

## **📤 Deploy to GitHub Pages**

### **1️⃣ Build the Static Site**

```sh
hugo --minify
```

This generates the site inside the `public/` directory.

### **2️⃣ Commit and Push to GitHub Pages**

```sh
git add -f public
git commit -m "Deploy Hugo site"
git push origin `git subtree split --prefix public hugo-migration`:gh-pages --force
```

This will deploy the `public/` folder to the `gh-pages` branch.

### **3️⃣ Configure GitHub Pages**

1. Go to GitHub → Repository → Settings → Pages
2. Configure:
   - Branch: `gh-pages`
   - Custom Domain: `dede.dev`
   - Enforce HTTPS: ✅ Checked

---

## **📄 License**

This project is licensed under the [MIT License](LICENSE).
