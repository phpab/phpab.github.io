---
layout: documentation
title: Library Layout
---

# Library layout

In this document the layout of the library is described. It's good to understand this
layout if you want to extend the library or introduce new features.

## Engine

The most important component is the Engine. An instance of Engine will control all
your tests. Generally you would only have one instance of this Engine. The engine
should be started using the `Engine::start` method. By starting the engine, the
tests and their variants are activated. Some variants contain a callback method
which can contain code hook into your application. It's very important to realize
that starting this engine should happen as early as possible for this reason.

## Analytics

The analytics component collects the data about started tests and variants. This is
needed in order to handle this later on. Depending on your prefered analytics type,
the data is handled differently. For example when using Google Analytics, you need
to embed a JavaScript in your application in order to send the collected data to
Google. In case of PDO analytics the data needs to be written to a database and there
is nothing to render.

This library does not provide a way to analyze the collected data. It only registers
the data. It's up to user-domain to interpret the data and analyze it.

## Events

`PhpAb` provides an event dispatcher which makes it possible to add hooks to the
system. We provide various immplementations for event managers. There is a simple
event dispatcher but there is also support to use the Symfony Event dispatcher or
Zend Framework 2's event manager.

## Participation

In order to decide if users should participate, we have created a participation
manager. This participation manager makes use of filters in order to decide if a
user is included in a test.

## Storage

When a test has been activated, the actiavated test should be remembered. You don't
want to see version A of your application during a first request and a version B
when you visit a different page. In order to preserve the selected choice, we use a
storage provider to remember your choice. The most common storage is probably a
cookie storage but there are alternatives.

## Variants

Variants represent the choice that is made for a test. It's possible to run
additional code when a variation is activated. This way it becomes possible to change
certain parts of your application depending on the variant that is chosen.
