---
title: Social Media Downloader Bot using C++ and Telegram API [Draft]
date: 2023-05-18 11:33:00 +0800
categories: [Blogging, Doc, Draft]
tags: [telegram, twitter, instagram, youTube, facebook, tikTok]
pin: true
math: true
mermaid: true
image: 
  path: sipeto.png 
  alt: sipeto AiBot
---


> ⚠️ **This document is still a draft. Please note that there might be mistakes or inaccuracies.**
{: .prompt-warning }

### Introduction

The Social Media Downloader Bot is a C++ application that utilizes Telegram as an interface through the Telegram API to interact with users and allow them to download images and videos from social media platforms such as Twitter, Facebook, Instagram, etc. I named it `Sipeto`.

This document outlines the design and structure of the program, including its main components, dependencies, and interactions. The [source code](https://github.com/wilfrantz/sipetoBot){:target="_blank"} is available on GitHub.

<ins>Table of Content</ins>:

- [Introduction](#introduction)
- [Dependencies](#dependencies)
- [Program Flow](#program-flow)
- [Program Components](#program-components)
  - [Telegram Bot API Interface](#telegram-bot-api-interface)
  - [Social Media API Handler](#social-media-api-handler)
    - [TikTok](#tiktok)
    - [Twitter](#twitter)
    - [Instagram](#instagram)
    - [Facebook](#facebook)
  - [Media Downloader](#media-downloader)
  - [URL Parser](#url-parser)
  - [Main Program](#main-program)

### Dependencies

- TikTok API
- Twitter API
- Boost library
- Facebook Graph API
- Instagram Private API
- C++ (minimum version 17)
- Spdlog - Logging library.
- tdlib - Telegram Bot API library.
- JSONCPP for Modern C++ library (JSON parsing)

### Program Flow

![Program Flow](Sipeto-flowchart.png)

The user sends a link either via the `Telegram bot` or through the [web application](https://sipeto.com){:target="_blank"}. The program conducts an automatic detection process to identify the social media platform associated with the link, including platforms such as `Twitter`, `Facebook`, `TikTok`, or `Instagram`.

If the platform is supported, the URL is parsed and routed to the appropriate social media API within the `Media Handler class`. In case the program detects an unsupported platform, it promptly communicates an error message to the user.

The `Media Handler class` takes over from this point. It establishes authentication with the related API and extracts the media URL(s) contained within the post. Subsequently, the `Media Downloader class` is responsible for downloading the media content and temporarily storing it.

Finally, utilizing either the `Telegram bot` or the `web application`, the `Interface class` delivers the downloaded media file to the user, ensuring a seamless and convenient user experience.

<ins>LaTeX Format</ins>

```latex
\documentclass{article}
\usepackage{tikz}
\usepackage{pdflscape}
\usetikzlibrary{shapes.geometric, arrows}

\tikzstyle{startstop} = [rectangle, rounded corners, minimum width=3cm, minimum height=1cm,text centered, draw=black, fill=red!30]
\tikzstyle{process} = [rectangle, minimum width=3cm, minimum height=1cm, text centered, draw=black, fill=orange!30]
\tikzstyle{arrow} = [thick,->,>=stealth]

\begin{document}

\begin{landscape}
\begin{figure}
\centering
\begin{tikzpicture}[node distance=2cm]

% Nodes
\node (detect) [process] {Detect platform};
\node (api) [process, below of=detect] {Media handler: API};
\node (authenticate) [process, below of=api] {Authenticate with API};
\node (fetch) [process, below of=authenticate] {Fetch media URL(s)};
\node (download) [process, below of=fetch] {Media downloader};
\node (store) [process, below of=download] {Store media temporarily};
\node (send) [process, below of=store] {Send media to user};
\node (interface) [process, left of=fetch, xshift=-4cm] {Interface (Telegram, webApp)};
\node (start) [startstop, left of=interface, xshift=-4cm] {User};

% Arrows
\draw [arrow] (start) -- (interface);
\draw [arrow] (interface) |- (detect);
\draw [arrow] (detect) -- (api);
\draw [arrow] (api) -- (authenticate);
\draw [arrow] (authenticate) -- (fetch);
\draw [arrow] (fetch) -- (download);
\draw [arrow] (download) -- (store);
\draw [arrow] (store) -- (send);
\draw [arrow] (send) -| (interface);
\draw [arrow] (interface) -- (start);

\end{tikzpicture}
\caption{Flowchart}
\end{figure}
\end{landscape}

\end{document}
```

### Program Components

The program consists of the following main components:

#### Telegram Bot API Interface

- Handles user input and output, i.e., sending and receiving messages from users.
- Provides methods to send images and videos to users.

#### Social Media API Handler

- Interfaces with the respective social media APIs (Facebook, Twitter, Instagram etc...) to fetch the required media (images and videos).
- Handles authentication and API rate limits.

##### TikTok

For the purpose of this application, we need the link provided in the `downloadAddr` field to download the media. However, The specific behavior and structure of the TikTok API response, including the `downloadAddr` field, can vary over time as the TikTok platform and API evolve.

TikTok doesn't seem to provide an official API for accessing user media or specific details about the API response structure. If like me, you encounter a scenario where the `downloadAddr` field in the TikTok API response provides a link with empty media, it could be due to various reasons:

- <ins>Unavailable or Deleted Media</ins>: The media associated with the TikTok video might have been removed or deleted from the TikTok platform. In such cases, the `downloadAddr` value may exist, but the actual media file may no longer be accessible.

- <ins>Limited Access Permissions</ins>: TikTok might have implemented access restrictions or permissions for certain media files. It's possible that you may not have the necessary permissions or authorization to download or access the specific media.

- <ins>API Changes</ins>: TikTok may have updated its API. The response structure and behavior of the API could have changed, leading to unexpected or empty downloadAddr values.

##### Twitter

`# TODO`

##### Instagram

`# TODO`

##### Facebook

`# TODO`

#### Media Downloader

- Downloads the media (images and videos) using libcurl and stores them temporarily.

#### URL Parser

- Extracts the relevant URLs for media content from the provided social media post URLs.

#### Main Program

- Combines all components and manages their interactions.
