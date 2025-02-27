---
title: ZSH and PowerLevel10K for Beauty and Speed on MacOS & Debian Systems
date: 2023-05-22 11:33:00 +0800
categories: [Blogging, Tutorial]
tags: [cli, zsh, Linux, macOS, UNIX, Debian, Darwin]
pin: false
math: true
mermaid: true
image: 
---


In this comprehensive tutorial, I'll guide you through the process of installing/configuring `ZSH` shell both on `MacOS` and `Debian` systems, personalize it with the `ohmyzsh` framework and elevate your experience with the stunning `PowerLeve10K` theme.

Before proceeding with the installation, please ensure that `Git` is installed on your system. To install `Git` using [homebrew](https://brew.sh){: target="_blank"} on `macOS`, run the following command:

```shell
brew install git
```

For Linux users, you can install Git with homebrew or your Linux distro's default package manager, on debian systems simply run the following command:

```shell
sudo apt install git -y
```

Having Git installed is essential for the successful completion of the installation process. Make sure to execute the appropriate command for your operating system to ensure Git is properly set up.

For Mac users, I highly recommend `Homebrew` as a package manager. You can easily install it by running the following command in your terminal:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Additionally, I suggest using `iTerm2` as an alternative to the default macOS terminal. You can swiftly install iTerm2 using Homebrew with the following command:

```shell
brew install --cask iterm2
```

You have now gained access to a powerful package manager and an enhanced terminal experience on your Mac system. Get ready to unlock the potential of your command-line interface and embark on a journey of enhanced productivity and visual aesthetics.

Let's dive in!

Table of Contents

- [Step 1: Install ZSH on your system](#step-1-install-zsh-on-your-system)
- [Step 2: Change your default shell to `ZSH`](#step-2-change-your-default-shell-to-zsh)
  - [Step 2.1: Identify your current shell](#step-21-identify-your-current-shell)
  - [Step 2.2: Make sure it is set to `zsh`](#step-22-make-sure-it-is-set-to-zsh)
- [Step 3: Restart your terminal](#step-3-restart-your-terminal)
- [Step 4: Install `Oh-My-Zsh`](#step-4-install-oh-my-zsh)
- [Step 5: Install PowerLeve10K theme](#step-5-install-powerleve10k-theme)
- [Step 6: Download and install Nerd Patched fonts](#step-6-download-and-install-nerd-patched-fonts)
- [Step 7: Download Plugins for `autosuggestion`](#step-7-download-plugins-for-autosuggestion)
- [Step 8: Edit your `~/zshrc` file](#step-8-edit-your-zshrc-file)
- [Step 9: Change your terminal font from preferences](#step-9-change-your-terminal-font-from-preferences)
- [Step 10: `p10k` configuration](#step-10-p10k-configuration)
- [Bonus](#bonus)
  - [Customize the Font Family in the VSCode Terminal](#customize-the-font-family-in-the-vscode-terminal)
  - [Fix permission issue in ZSH](#fix-permission-issue-in-zsh)
  - [WebSearch with google from the terminal](#websearch-with-google-from-the-terminal)
- [Summary](#summary)
- [Source](#source)

### Step 1: Install ZSH on your system

Open your terminal, copy and paste the following commands

On Debian systems:

```bash
sudo apt install zsh
```

On MacOS `zsh` is the default shell environment, but you could install it with the following command:

```bash
brew install zsh
```

### Step 2: Change your default shell to `ZSH`

#### Step 2.1: Identify your current shell

```bash
echo $SHELL
```

#### Step 2.2: Make sure it is set to `zsh`

```bash
chsh -s $(which zsh)
```

### Step 3: Restart your terminal

Close your terminal and open it again to allow the changes to take effect.
Then type `echo $SHELL` at the prompt to verify the shell, it should output something similar to `/usr/bin/zsh` or `/usr/local/bin/zsh` depending on your environment.

### Step 4: Install `Oh-My-Zsh`

Paste this command in your terminal and hit enter to install `Oh-My-Zsh`

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### Step 5: Install PowerLeve10K theme

Clone the repository into the custom theme directory.

```bash
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```

### Step 6: Download and install Nerd Patched fonts

Download and install [FiraMono Nerd](https://github.com/ryanoasis/nerd-fonts/releases){:target="_blank"} font. It’s best and works everywhere. I highly recommend `FiraMono` for Linux (Ubuntu) systems otherwise your terminal may not display the font properly.

### Step 7: Download Plugins for `autosuggestion`

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

and `syntax highlighting`

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

### Step 8: Edit your `~/zshrc` file

- Use vim/nano editor to edit your `~/.zshrc` file to use the `PowerLeve10K` theme, `Awesome Patched` font, `Autocorrection`, `Autosuggestion` and `Syntax highlighting`.

```bash
vim ~/.zshrc
```

Find the `ZSH_THME` line and replace it with

```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```

Also add the below line to use `Nerd Patched fonts`

```bash
POWERLEVEL9K_MODE="nerdfont-complete"
```

To enable auto correction uncomment the line by removing the `#` from

```bash
#ENABLE_CORRECTION="true"
```

it should now look like this

```bash
ENABLE_CORRECTION="true"
```

Now we will add plugins so scroll down a little until you find `plugins=(git)`, or just search for it, add the plugins we just downloaded, like this

```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

that's it, save and exit the editor.

### Step 9: Change your terminal font from preferences

***<ins>On Debian systems</ins>***

I illustrate here with Ubuntu, however, the process should be the same on other `Debian` systems. Go to preferences of your terminal and change to the custom font you just installed. If it doesn’t shows up you can try this.

![Preference](/images/preference-ubuntu.png)

You can set any font using dconf (e.g. in dconf-editor), under `/org/gnome/terminal/legacy/profiles:/:<profile-id>/font`.

***<ins>On MacOS</ins>***

Go to the terminal preferences

![Terminal Preferences](/images/macOS-Term.png)

Click on `profiles`, find the change button under the Font section, search and select `FuraMono`.

![MacOS 13.3.. font selector](/images/macOS-change-button.png)

Set your new theme to default and restart your terminal.

### Step 10: `p10k` configuration

Run `p10k configure` command to setup your terminal looks.

```bash
p10k configure
```

Follow the instructions on the on screen. In the last step select option 3 which is verbose and then hit `Y`.

![p10k configure](/images/p10kconfigure.gif)

### Bonus

#### Customize the Font Family in the VSCode Terminal

Following the steps below to change the font family in the integrated terminal in Visual Studio Code to `"FuraMono Nerd Font"`.

![vscode terminal](/images/vscodeTerm.png)

1. Open Visual Studio Code.

2. Go to the "Settings" by clicking on the gear icon in the lower-left corner or by using the shortcut Ctrl + , (comma).

3. In the search bar at the top of the settings panel, type "terminal.integrated.fontFamily" and press Enter.

4. Locate the "terminal.integrated.fontFamily" setting and click on the "Edit in settings.json" button to open the configuration file.

5. In the `"terminal.integrated.fontFamily"` property, add `"FuraMono Nerd Font"` as the font family value.
   > Make sure to enclose it in quotation marks.
   {: .prompt-warning }
   > Example: `"terminal.integrated.fontFamily": "FuraMono Nerd Font"`
   {: .prompt-tip }

6. Save the changes and close the `settings.json` file.

7. Restart Visual Studio Code to allow the new font settings to take effect.

#### Fix permission issue in ZSH

If you encounter a permission issue in `ZSH`, it can be resolved by addressing insecure directory permissions and ownership. When such issues arise, `ZSH` may disable completions for safety reasons.

```bash
[oh-my-zsh] Insecure completion-dependent directories detected:
lrwxr-xr-x  1 rafael  admin  88 Apr 28 15:51 /usr/local/share/zsh/site-functions/_brew_services -> ../../../Homebrew/Library/Taps/homebrew/homebrew-services/completions/zsh/_brew_services
[oh-my-zsh] For safety, completions will be disabled until you manually fix all
[oh-my-zsh] insecure directory permissions and ownership and restart oh-my-zsh.
[oh-my-zsh] See the above list for directories with group or other writability.
```

To fix this, you need to manually rectify the directory permissions mentioned in the provided error message. By ensuring secure permissions and ownership, you can reinstate the completions functionality. After making the necessary adjustments, remember to restart `oh-my-zsh` to apply the changes. By taking these steps, you can resolve permission-related problems and restore the full functionality of ZSH.

Open your `.zshrc` file in your editor of choice, I personally like neovim

```bash
vim ~/.zshrc
```

and add this line before the `# Path to your oh-my-zsh installation.`

```bash
ZSH_DISABLE_COMPFIX=true
```

it should now look like this:

```bash
# Path to your oh-my-zsh installation.
ZSH_DISABLE_COMPFIX=true
export ZSH="/Users/"YourUserName"/.oh-my-zsh"
```

Restart your terminal and everything should work fine.

#### WebSearch with google from the terminal

Performing a Google search directly from the terminal is a nifty trick that can save you time. Follow these steps to set it up:

1- Open your favorite editor and access your `.zshrc` file:

```shell
vim ~/.zshrc
```

2- Locate the line containing the plugins and add `web-search` as shown below:

```shell
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
```

3- Save the changes and exit the editor. Then, reload your environment by running:

```shell
source ~/.zshrc
```

4- You are now ready to launch Google searches directly from your terminal. For example, to search for "cat memes", type the following command:

```shell
google cat memes
```

You are now able to quickly search Google without leaving the comfort of your terminal.

### <ins>Summary</ins>

By following the steps outlined in this tutorial, you've transformed your command-line interface on both `MacOS` and `Debian systems` using `ZSH` and `PowerLevel10K`.

Throughout the process, we installed `ZSH`, set it as the default shell, and incorporated `Oh-My-Zsh` to add extra functionalities.

We took things even further by personalizing our shell with the visually captivating `PowerLevel10K` theme, giving it a stylish and appealing look. Plus, we supercharged it with plugins for `autosuggestions` and syntax `highlighting`, making our command-line experience even more efficient.

To top it all off, we effortlessly changed the terminal font, enhancing the visual aesthetics to suit our preferences. Now armed with these fantastic enhancements, you can enjoy a seamless and visually appealing command-line journey that's both functional and stylish.

### Source

- [How To Make Your Boring Mac Terminal So Much Better. (VIDEO)](https://youtu.be/CF1tMjvHDRA){:target="_blank"}
- [Make your terminal beautiful and fast with ZSH shell and PowerLevel10K.](https://medium.com/@shivam1/make-your-terminal-beautiful-and-fast-with-zsh-shell-and-powerlevel10k-6484461c6efb){:target="_blank"}
  
