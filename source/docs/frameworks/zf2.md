---
layout: documentation
title: Zend Framework 2
---

# Zend Framework 2

We have implemented a module which you can hook into your Zend Framework 2 application.
This module basically wraps the [phpab/phpab](https://github.com/phpab/phpab) library
and adds some additional functionality which makes it possible to fully integrate the
library into your application while keeping support for all ZF2 functionality.

## Installation

Simply install the module using [Composer](https://getcomposer.org):

```bash
composer require phpab/phpab-module
```

Next make sure the module is actually loaded by adding `PhpAbModule` to application
config in *config/application.config.php*.

Installation without [Composer](https://getcomposer.org): is not officially supported.

## Configuration

Copy over the dist configuration file that is provided in the module.

```bash
cp vendor/phpab/phpab-module/config/phpab.global.php.dist config/autoload/phpab.global.php
```

You can edit this file to your needs.

## Configuration Options

### ['phpab']['analytics_collector']

The name of the service that loads the data collector. A data collector collects
information about which tests and variants are started for a user.

The default value is `phpab.default_analytics_collector`. You can either change
this value or change the service that gets loaded in the service manager.

### ['phpab']['analytics_handler']

The name of the service that loads the analytics handler. A handler uses the
collected data and writes it away.

The default value is `phpab.default_analytics_handler`. You can either change
this value or change the service that gets loaded in the service manager.

### ['phpab']['default_filter']

When creating tests, you pass a filter which decides if a user should participate.
When no filter is passed to tests, the default filter is used. That default filter
can be configured with this configuration option.

This is the name of the service that loads the default filter. The default value is
`phpab.default_filter`. You can either change this value or change the service that
gets loaded in the service manager.

### ['phpab']['default_variant_chooser']

Like with the `['phpab']['default_filter']` option, the same applies for default
variant chooser.

This is the name of the service that loads the default filter. The default value is
`phpab.default_filter`. You can either change this value or change the service that
gets loaded in the service manager.

### ['phpab']['storage']

The storage type to use. Supported values are:
- `cookie`: Stores the participations in a cookie;
- `runtime`: Stores the participations only for the current request;
- `session`: Stores the participations in a session.

### ['phpab']['storage_options']

An array with options for the storage type. Different options are required per
storage type:

#### Cookie

- `name`: The name of the cookie. This value is required.
- `ttl`: The lifetime of the cookie in seconds. This value is required.

#### Runtime

This storage has no options.

#### Session

- `name`: The name of the session. This value is required.

## Configuration Example

```php
<?php
return [
    'phpab' => [
        'storage' => 'cookie',
        'storage_options' => [
            'name' => 'phpab',
            'ttl' => 3600,
        ],
        'tests' => [
            'button-test' => [
                'filter' => 'phpab.default_filter',
                'variant_chooser' => 'phpab.default_variant_chooser',
                'variants' => [
                    '_control' => [
                        'type' => 'simple',
                    ],
                    'alternative' => [
                        'type' => 'simple'
                    ],
                ],
            ],
        ],
    ],
];

```
