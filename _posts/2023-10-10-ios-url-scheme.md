---
title: The Power of URL Schemes in iOS 
date: 2023-10-10 11:33:00 +0800
categories: [Blogging]
tags: [iOS, Apple]
pin: false
math: true
mermaid: true
image:
---

In the vast ecosystem of `iOS`, there exist certain "shortcuts" known as URL schemes which allow for direct interaction with system and third-party apps. While most `iOS` users might be unfamiliar with them, understanding URL schemes can elevate the iOS experience, allowing for more direct interactions and automations.

Table of contents

- [What are URL Schemes?](#what-are-url-schemes)
- [1. Making Direct Calls with `tel://`](#1-making-direct-calls-with-tel)
- [2. SMS Shortcuts with `sms://`](#2-sms-shortcuts-with-sms)
- [3. The Enigmatic `diags://`](#3-the-enigmatic-diags)
- [Benefits of Using URL Schemes](#benefits-of-using-url-schemes)
- [Facetime with `facetime:` and `facetime-audio:`](#facetime-with-facetime-and-facetime-audio)
- [Accessing Mail Directly with `mailto:`](#accessing-mail-directly-with-mailto)
- [Navigating with `http://maps.apple.com/`](#navigating-with-httpmapsapplecom)
- [Music Shortcuts with `music://`](#music-shortcuts-with-music)
- [App Store with `itms-apps://`](#app-store-with-itms-apps)
- [Watching Content with `videos://`](#watching-content-with-videos)
- [Accessing Calendar with `calshow://`](#accessing-calendar-with-calshow)
- [System Preferences with `App-Prefs://`](#system-preferences-with-app-prefs)
- [Jumping into YouTube with `youtube://`](#jumping-into-youtube-with-youtube)
- [Wrapping Up](#wrapping-up)

### What are URL Schemes?

URL schemes provide a method to launch an app from another app, a website, or even interact dicely with the iOS system itself. They're essentially URLs that, instead of pointing to a website, instruct the system to perform specific tasks or open specific apps.

### 1. Making Direct Calls with `tel://`

One of the most straightforward URL schemes is `tel://`. This scheme can directly initiate a phone call. By entering something like `tel://1234567890` in Safari, the Phone app would launch and initiate a call to the number "1234567890".

This can be especially useful in certain automation scenarios, like QR codes for direct calls or web pages designed to initiate a customer support call with a single tap.

### 2. SMS Shortcuts with `sms://`

Similar to the `tel://` scheme, `sms://` will open up the Messages app ready to send a text to a specific number. So, `sms://1234567890` would launch a new message to that number. This can be handy for businesses or events that want to provide a direct line to SMS-based communication or support.

### 3. The Enigmatic `diags://`

While `tel://` and `sms://` are quite public and known, `diags://` is more mysterious. As of the last known updates, it's not a publicly recognized scheme in iOS's official documentation. It might be related to internal or proprietary tools used by Apple or certain app developers for diagnostics. Whenever encountering unfamiliar URL schemes, especially those potentially impacting system data or behavior, always proceed with caution.

### Benefits of Using URL Schemes

- **Automation**: For power users and developers, URL schemes can be combined with automation tools on iOS, like Shortcuts, to create sequences of actions that can be triggered with a tap.

- **Ease of Access**: Businesses can streamline user actions. For instance, a restaurant's contact page can have a "Call Now" button utilizing the `tel://` scheme to initiate direct calls.

- **Custom Integrations**: Third-party apps can also define their own URL schemes, allowing for unique inter-app interactions and deep linking.

### Facetime with `facetime:` and `facetime-audio:`

The `facetime:` scheme lets you initiate a FaceTime video call directly. For instance, typing `facetime://[email protected]` would open FaceTime and start a video call with the given email address. Similarly, `facetime-audio:` can be used to start a FaceTime audio call.

### Accessing Mail Directly with `mailto:`

`mailto:` isn't exclusive to iOS; it's a widely recognized scheme across platforms. By entering something like `mailto:[email protected]?subject=Hello` in a browser or hyperlink, the Mail app will open, ready to compose a message to the provided email address with a pre-filled subject line.

### Navigating with `http://maps.apple.com/`

Apple Maps can be launched using this URL scheme. For example, `http://maps.apple.com/?q=Central+Park` will open Apple Maps and search for Central Park.

### Music Shortcuts with `music://`

The `music://` scheme can open the Music app. You can use it to search for songs or artists, such as `music://search?term=beatles`, which will search for "The Beatles" in the Music app.

### App Store with `itms-apps://`

By using `itms-apps://`, you can direct someone straight into the App Store. You can even point them directly to an app's page by appending its identifier, for instance, `itms-apps://itunes.apple.com/app/id[APP_ID]`.

### Watching Content with `videos://`

The `videos://` scheme opens the Videos app. It's handy for accessing purchased or local video content.

### Accessing Calendar with `calshow://`

By using `calshow://`, users can be directed straight to the Calendar app. For instance, `calshow:602287104` will open the Calendar app and jump to a specific date based on the timestamp provided.

### System Preferences with `App-Prefs://`

This scheme can take users directly to specific sections of the Settings app, though its use is unofficial and can change between iOS versions.

### Jumping into YouTube with `youtube://`

If the YouTube app is installed, `youtube://` followed by certain parameters can open the app and search or play videos. For instance, `youtube://www.youtube.com/watch?v=dQw4w9WgXcQ` would directly open a particular video in the YouTube app.

### Wrapping Up

While URL schemes provide an advanced layer of interaction on iOS, they're just scratching the surface of what's possible when diving deep into the system's capabilities. Always remember to use these tricks responsibly, ensuring that user privacy and security are not compromised.

Whether you're an `iOS` power user looking to streamline your daily tasks or a curious enthusiast eager to uncover hidden iOS gems, understanding and harnessing the power of URL schemes can open a new realm of possibilities.
