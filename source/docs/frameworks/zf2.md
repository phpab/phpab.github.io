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

### ['phpab']['tests']

This is a map with tests that exist within the application. The key of each element
represents the name of the test. The value should be an array with options. A test
has the following options:
- `filter`: The name of the service that loads the participation filter.
- `variant_chooser`: The name of the service that loads the variant chooser.
- `variants`: A map with variants that can be chosen from.

The `filter` and `variant_chooser` work the same as the default filter and default
variant chooser.

The map with variants is an array where each key represents the name of the variant.
The value of the variant is an array with variant options. Each variant can have
one of the following options:
- `type`: The type of the variant.
- `options`: An array with options for the variant type.

## Variants

The module supports the following variant types:

### Callback

The callback variant will invoke a callback when activated. It has one required option
called `callback`:

```php
'my-variant' => [
    'type' => 'callback',
    'options' => [
        'callback' => function() {
        },
    ],
],
```

### Event Manager

The event manager variant will attach a listener to an event manager when executed.
Since the phpab engine is started at the startup of the application, you can listen
to every event.

```php
'my-variant' => [
    'type' => 'event_manager',
    'options' => [
        'event_manager' => 'my_event_manager',
        'event' => 'my_event',
        'priority' => 100,
        'callback' => function() {
        },
    ],
],
```

Only the `event` and the `callback` options are required. When no `event_manager`
option is provided, the event manager from the application is used. The default value
for the priority option is `0`.

When the callback is a string and is not a callable function, it will be loaded
from the service manager. In other words, you can specify a valid service name as
well.

### Simple

The simple variant will note execute any further logic when activated.

```php
'my-variant' => [
    'type' => 'simple',
],
```

### Service Manager

The service manager variant is a fallback variant. When the type is not known, it will
try to load the variant from the service manager with the type as the service name.

```php
'my-variant' => [
    'type' => 'my_service_name',
],
```

Alternatively you can specify the service name straight away like this:

```php
'my-variant' => 'my_service_name',
```

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
