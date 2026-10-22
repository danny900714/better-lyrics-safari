![Banner](https://res.cloudinary.com/boidu/image/upload/t_banner/v1759536833/bl/banner.png)

# Better Lyrics Safari

[![License: GPL-v3](https://img.shields.io/badge/license-GPL_v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)
[![GitHub Release](https://img.shields.io/github/v/release/danny900714/better-lyrics-safari)](https://github.com/danny900714/better-lyrics-safari/releases/latest)

Safari port of the [Better Lyrics](https://github.com/better-lyrics/better-lyrics) extension.

Better Lyrics upgrades your YouTube Music™ experience by providing beautiful time-synced lyrics for your favorite songs.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Enable Better Lyrics on Safari](#enable-better-lyrics-on-safari)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Trademarks](#trademarks)

## Features

🎵 Displays beautiful time-synced lyrics on YouTube Music™\
📦 Requires no external dependencies or configurations\
⏩ Lets you seek by clicking on any line\
🌏 Translations and romanization for foreign-language tracks\
🌐 UI available in multiple languages\
🪶 Runs lightweight and fast\
🖥️ Includes full-screen mode\
🎨 Theme Marketplace with community themes\
🔧 Customizable lyrics providers from multiple sources\
✨ And much more!

## Installation

There are two ways to install the extension:

### Method 1: Homebrew (Recommended)

If you have installed [Homebrew](https://brew.sh), you can install Better Lyrics with:

```shell
brew install danny900714/tap/better-lyrics
```

### Method 2: Download manually from Latest GitHub Release

#### Download the extension

1. Go to the [latest release](https://github.com/danny900714/better-lyrics-safari/releases/latest) page.
2. Under **Assets**, click the file whose name ends in `.dmg` to download it.
3. Open the downloaded `.dmg` file from your **Downloads** folder.
4. In the window that appears, drag the **Better Lyrics** icon onto the **Applications** folder.
5. Open **Better Lyrics** from your **Applications** folder.

#### Opening Better Lyrics for the First Time

Better Lyrics isn't notarized by Apple, so the first time you open it, macOS shows a warning that the app can't be verified.
This is expected. Use **one** of the options below to allow it. You only need to do this once.

**Option 1: System Settings (no Terminal needed)**

1. Try to open Better Lyrics once, then close the warning by clicking **Done**.
2. Open **System Settings** and go to **Privacy & Security**.
3. Scroll down to the **Security** section and click **Open Anyway** next to Better Lyrics.
4. Click **Open Anyway** again in the pop-up, then enter your password or use Touch ID.

**Option 2: Terminal**

1. Open **Terminal**: press `⌘ Space`, type `Terminal`, and press Return.
2. Copy the command below, paste it into the Terminal window, and press Return:
   ```
   xattr -dr com.apple.quarantine /Applications/Better Lyrics.app
   ```
3. Open Better Lyrics from your **Applications** folder as usual.

## Enable Better Lyrics on Safari

The first time you install the Safari extension, you'll need to enable it and grant the required permissions.

1. Open Better Lyrics from your **Applications** folder.
2. Click **Quit and Open Safari Settings...**.
3. Select the checkbox next to **Better Lyrics (Lyrics for YouTube Music)**.
4. Open [YouTube Music™](https://music.youtube.com), then click the Better Lyrics icon in Safari toolbar.
5. Click **Always Allow on This Website**.

## Usage

1. Open [YouTube Music™](https://music.youtube.com) and start playing a song.
2. Click on the lyrics tab to view time-synced lyrics. (This might take a few seconds to load)
3. Click on a specific line to seek to that part of the song.

## Contributing

Contributions are welcome!

If you have any ideas, suggestions, or bug reports, please open an issue or submit a pull request.

> [!NOTE]
> Only report bugs that are specific to the safari build.
> Bugs that can be reproduced in other browsers must be reported to the [upstream repository](https://github.com/better-lyrics/better-lyrics/issues/new/choose).

## License

This is a fork of [Better Lyrics](https://github.com/better-lyrics/better-lyrics).
It is distributed under the [GNU General Public License v3](https://www.gnu.org/licenses/gpl-3.0.en.html).

## Trademarks

YouTube Music™, YouTube™, Google™, and Chrome™ are trademarks of Google LLC. Firefox® is a trademark of the Mozilla Foundation. Microsoft Edge is a trademark of Microsoft Corporation. Musixmatch® is a trademark of Musixmatch S.p.A. Use of these trademarks is subject to their respective owners' guidelines.
