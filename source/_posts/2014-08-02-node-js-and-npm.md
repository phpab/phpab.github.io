---
title: Setting Up Node.js and npm
tags: [node.js, npm, osx]
categories: [server, development]
description: How to set up node.js and npm on osx using homebrew.

---
[Node.js](http://nodejs.org/) is gaining a lot of speed and is an exciting new development framework. Here's a quick overview of how to get Node.js working on OSX along with npm, the package manager for node.

## Install Homebrew

[Homebrew](http://brew.sh) is the package manager that Apple forgot. Written in Ruby, it allows you to quickly and easily compile software on your Mac. Instructions for installing Homebrew are in the [README](http://github.com/mxcl/homebrew/blob/master/README.md) and I have also written a guide [here](/archive/2014/07/19/Homebrew). You will need to install the Developer Tools for Mac which are installed as part of Xcode. Xcode is available for free - it is a pretty hefty download but you will need it and you can get it [here](https://developer.apple.com/xcode/downloads/).

## Install Node.js via homebrew

Once Homebrew is installed you can go ahead and install Node.js like this:

    brew install node

Easy! Now create a file called `server.js` and paste in the example server code

~~~
var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\n');
}).listen(8124, "127.0.0.1");
console.log('Server running at http://127.0.0.1:8124/');
~~~

Save the file and from the console run:

    node server.js

Now you can visit <http://127.0.0.1:8124/> with your favourite browser and you are up and running with server side JavaScript.

At this point it is probably a good idea to consult the excellent [Node.js documentation](http://nodejs.org/api). This will help you understand what Node.js is and what it can do.

## Installing npm

npm is Node's package manager. It is now installed automatically with Node.js so there is no need to do a separate installation.

If you are developing anything in Node.js there is a good chance there is already a library to help you. It might be a module to connect to MySQL, a templating library or a utility library.

You can search for modules like this:

    npm search [searchterm]

So to search for underscore do this:

    npm search underscore

There is also a [website for npm](https://npmjs.org/) where you can search for packages.

## Installing modules

Now we are set up we can install Node modules using npm. [Express](http://expressjs.com/) is a good place to start - it is a Node framework inspired by [Sinatra](http://www.sinatrarb.com/).

    npm install express

This provides a solid base to start developing with Node.js including [jade](http://jade-lang.com/) the haml inspired Node tempting engine. There is more [excellent documentation](http://expressjs.com/guide.html) available for express too.

That's all folks.

> I love this shit!

Kirk
