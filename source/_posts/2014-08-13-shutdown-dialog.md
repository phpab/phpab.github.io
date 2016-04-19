---
title: Bring Back The Shutdown Dialog
tags: [osx, mac]
categories: [hints]
description: Bring Back The Shutdown Dialog When You Press The Mac Power Button.

---

Pressing the Mac power button in OS X Mavericks puts your Mac to sleep. A simple Terminal command can change it to display the shutdown dialog instead. 

The Mac power button currently has three behaviours: sleep, shutdown dialog and force shutdown. Pressing the power button for about a second puts your Mac to sleep. Pressing it down for about three seconds brings up the shutdown dialog. If you prefer to disable the power button’s sleep mode and have the shutdown dialog appear instead, open a Terminal window and enter the following command:

    defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool no

If you change your mind, you can switch it back with this command:

    defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool yes

Remember, you can also bring up the shutdown dialog with the Control-power button shortcut. If you have a Media Eject key, you can use the Control-Media Eject shortcut too.
