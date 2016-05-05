---
layout: documentation
title: Events
---

# Events

Phpab makes use of an event dispatcher. The event dispatcher can be used to attach
event listeners to so that action can be taken when events happen within the library.

The library supports multiple implementations of an event dispatcher. By default the
following implementations exists:
- Default dispatcher: An event dispatcher composed by the phpab team;
- Symfony dispatcher: This event dispatcher makes use of
[Symfony's event-dispatcher library](https://github.com/symfony/event-dispatcher).
- Zend dispatcher: This dispatcher makes used of
[Zend Framework's event manager](https://github.com/zendframework/zend-eventmanager).

## Dispatching

### Simple Dispatcher

The, what we call, *Simple Dispatcher* is a dispatcher class that is implemented by
the PhpAb team itself. It's a very simple implementation to which you add listeners
and subscribers. When an event is dispatched, the listeners are invoked.

Usage is simple:

```php
$dispatcher = new \PhpAb\Event\Dispatcher();
```

To add a listener:

```php
$dispatcher->addListener('my-event', function() {
    // The callback that is invoked. Parameters depend on the event.
});
```

To add a subscriber:

```php
// The Google data collector implements SubscriberInterface but
// of course you can create your own as well.
$subscriber = new \PhpAb\Analytics\DataCollector\Google();
$dispatcher->addSubscriber($subscriber);
```

### Symfony Bridge

TODO

### Zend Framework

TODO

## Event Types

Note that all events are dispatched from the Engine class
(https://github.com/phpab/phpab/blob/master/src/Engine/Engine.php).
The library has the following events:

### phpab.participation.block

The `phpab.participation.block` event is dispatched when a user did not participate
in the test yet and when the [participation manager](participation.html) decided
that the user should not participate in the particular test.

### phpab.participation.blocked

The `phpab.participation.blocked` event is dispatched when the a user already was
excluded for a test by the [participation manager](participation.html) and the
user visits the page again in a new request.

### phpab.participation.variant_missing

The `phpab.participation.variant_missing` event is dispatched when no variant
has been chosen by the [variant chooser](variants.html) or when the variant no
longer exists. This can happen when the user has a cookie set but the code has
changed for example.

### phpab.participation.variant_run

The `phpab.participation.variant_run` event is dispatched when a variant is
activated. This will happen for new users as well as for existing users.
