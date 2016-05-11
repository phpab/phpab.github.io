---
layout: documentation
title: Storage and adapters
---

# Storage and adapters 

When a user visits the application, the participation manager decides whether or not
the user will participate in a test. And if so, in which test the user will
participate. That choice will be remembered so that the user will have the same
experience even when the page is reloaded.

In order to remember that choice *PhpAb* make use of storage providers. You can
configure the library to use a specific storage adapter.

## Cookie

The `Cookie` storage provider saves the tests and variants in which the user
participates, in a cookie. Only one cookie is used and you can configure the name
and lifetime of it.

### Usage

```php
use PhpAb\Storage\Adapter\Cookie;
use PhpAb\Storage\Storage;
use PhpAb\Participation\Manager;

// Create a Storage and its Adapter
$adapter = new Cookie('phpab');
$storage = new Storage($adapter);

// Create a Participation Manager
$manager = new Manager($storage);

//...
```

Decide the name and the ttl of the cookie:

```php
$nameOfCookie = 'myCookie';
$ttl = 86400; // in seconds
$adapter = new Cookie($nameOfCookie, $ttl);
```

## Session

### Installation

This implements [Aura Sessions library](https://github.com/auraphp/Aura.Session), reason which it must be include as external dependency.
To add it simply use composer as:

```bash
composer require phpab/storage-aurasession
```

### Usage
```php
use PhpAb\Storage\Adapter\AuraSession;
use PhpAb\Storage\Storage;
use PhpAb\Participation\Manager;

// Create a Storage and its Adapter
$adapter = new AuraSession();
$storage = new Storage($adapter);

// Create a Participation Manager
$manager = new Manager($storage);

//...
```

The `AuraSession` storage provider remembers the choices just for the current session. When a new session
is generated, the choices of the tests are cleared and phpab will re-evaluate if the user should participate.

## Runtime

The `Runtime` storage provider remembers the choices only for the current request. It
could be useful to use this provider for testing or development. In production you
should avoid this storage provider.

```php
use PhpAb\Storage\Adapter\Runtime;
use PhpAb\Storage\Storage;
use PhpAb\Participation\Manager;

// Create a Storage and its Adapter
$adapter = new Runtime();
$storage = new Storage($adapter);

// Create a Participation Manager
$manager = new Manager($storage);

//...
```