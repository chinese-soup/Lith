Lith - Multiplatform WeeChat relay client
====

Lith is a project mostly focused on bringing a fast and user-friendly WeeChat client to all major desktop and mobile operating systems. The main focus of this project is to bring a full-featured native relay client to iOS (due to the lack of a native client there).

![Lith in Linux](https://github.com/LithApp/LithApp.github.io/raw/main/assets/main.png)

## Getting Started

Lith is supposed to be run in addition to an existing WeeChat instance. In case you're planning to run Lith on your desktop-type device, WeeChat can be running locally and in case of both of mobile and desktop systems, WeeChat can be connected to over the network. In this case, it's necessary for WeeChat server to be directly reachable from your Lith device directly over the network.

Setup is necessary on the WeeChat side, please consult the following sources:
 - [WeeChat official user documentation](https://weechat.org/files/doc/stable/weechat_user.en.html#relay_plugin)

### Binary Packages

Lith currently supports the following platforms:
 - (Beta) **iOS** and **iPadOS**: https://testflight.apple.com/join/QfcVgNHD (AppStore version coming soon)
 - (Alpha) Android: https://github.com/LithApp/Lith/releases
 - (Beta) **Linux**: https://flathub.org/apps/details/app.lith.Lith
 - (Alpha) Windows: https://github.com/LithApp/Lith/releases
 - (Alpha) macOS: https://github.com/LithApp/Lith/releases
 
## Features

- Inline preview of images and videos
- Fast buffer list filtering
- Dark and light mode support
- Native local notifications on desktop platforms

## Limitations

- Message text is not selectable
- Keyboard shortcuts can only be tweaked by editing the config file
- Android: Builds are not signed
- macOS: Builds are not signed + Some keyboard shortcuts are broken
- Windows: Builds are not signed + There is no installer
- More: https://github.com/LithApp/Lith/issues

## Future plans

- Full App Store release
- Push notification support (first on iOS, then Android, probably)

## Build instructions

Lith is written using C++ and the Qt framework with QML. The only supported version is Qt 6.2 and newer.

When building for all supported platforms, only the following steps should be necessary (provided you have set up your Qt environment correctly):
```
mkdir build && cd build
qmake ..
make # nmake on Windows
```
Alternatively, you can just open the project file in Qt Creator.

There is also a package for Arch Linux in the AUR: https://aur.archlinux.org/packages/lith-git

## Get in touch

For bug reports and questions, feel free to use the Issues page here on GitHub.

There's also an IRC channel: `#lith` on [libera.chat](https://libera.chat) (irc.libera.chat:6697 with SSL)

You can contact me directly on `m@rtinbriza.cz`
