---
title: Installing Composer on your Mac
tags: [composer, php, osx]
categories: [server, development]
description: How to set up composer on osx.

---
This is probably a no brainer as long as you have already installed [homebew](http://brew.sh). If you haven't install homebrew you can find the instructions [here](/archive/2014/07/21/Homebrew/).

Once you have homebrew installed issue the following commands in the terminal noting that Composer is part of the homebrew-php project:

    brew update
    brew tap homebrew/homebrew-php
    brew tap homebrew/dupes
    brew tap homebrew/versions
    brew install php55-intl
    brew install homebrew/php/composer
    
That's all folks!!

