---
layout: documentation
title: Getting started
---

# Getting started with phpab

Hello world! This guide will help you get started with using php in your project.

Before you start using phpab/phpab, you need to know what A/B testing is. If you are new to
A/B testing we recommend you read the following article which we have dedicated especially to you:
[Understanding A/B testing](understanding-ab-testing.md). This article explains the basics and gives
tips to implement good tests.

## Installation

The recommended way of installing phpab/phpab is via [Composer](http://getcomposer.org/doc/00-intro.md).

```
composer require phpab/phpab
```

## Basic usage

### 1. Participation and Storage

It's common to only run tests for a selected group of people. This can be done using a participation
manager. When tests are activated, we need to store the choice that has been made for the user. This
is done using a storage type. In this case we use cookies.

```php
$storage = new \PhpAb\Storage\Cookie('phpab');
$participationManager = new \PhpAb\Participation\Manager($storage);
```

We have implemented several storage types, you can read more about them [here](storage.md).

### 2. Analytics Collecting

It makes no sense to run tests without analyzing the results. A common way is to use Google Analytics to
meassure what tests are used. Phpab makes used of data collectors to collect the started tests.

```php
$analyticsData = new \PhpAb\Analytics\Google\DataCollector();
```

### 3. Events

An event dispatcher must be created which is used later on. This event dispatcher can be used to hook
into the API and listen to tests. The analytics data collector should be attached to the event dispatcher
so that it registers statistics about the tests.

```php
$dispatcher = new \PhpAb\Event\Dispatcher();
$dispatcher->addSubscriber($analyticsData);
```

### 4. Engine

The engine is used to run tests. You can pass along a default variant chooser and participation filter
here as well. More about that later on.

```php
$filter = new \PhpAb\Participation\PercentageFilter(50);
$chooser = new \PhpAb\Variant\RandomChooser();
$engine = new PhpAb\Engine\Engine($participationManager, $dispatcher, $filter, $chooser);
```

### 5. Adding Tests

Adding a test is simple,

```php
$test = new \PhpAb\Test\Test('foo_test');
$test->addVariant(new \PhpAb\Variant\SimpleVariant('_control'));
$test->addVariant(new \PhpAb\Variant\CallbackVariant('v1', function () {
    echo 'v1';
}));
$test->addVariant(new \PhpAb\Variant\CallbackVariant('v2', function () {
    echo 'v2';
}));
$test->addVariant(new \PhpAb\Variant\CallbackVariant('v3', function () {
    echo 'v3';
}));

$engine->addTest($test);
```

### 6. Start your engines

The last step is to start the engine and render the Google Analytics script.

```php
$engine->start();
```
```php
$analytics = new \PhpAb\Analytics\Renderer\GoogleUniversalAnalytics($analyticsData->getTestsData());
echo $analytics->getScript();
```

## What's next

You can head over to [the documentation index](index.md). You can also read
the [Best practices guide](best-practices.md), it's a good way to get a good view on when to
use each of phpab's features.
