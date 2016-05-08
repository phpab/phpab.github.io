---
layout: documentation
title: Analytics
---

# Analytics

In order to determine how your tests are doing, you will need to store tests user participation somewhere.
What you are usually storing is:

* a user identifier
* a test identifier
* a variant identifier (this could be control too)
* a scenario (typically a web url)
* a timestamp

By analyzing all this data, you can determine which variant is performing better and which one gets users closer to your goals.

PhpAb provides different ways to store this data.
You can use more than one Analytics implementation simultaneously too. For instance, you might want to to use Google Analytics and MongoDB, so you could also create your own business intelligence data crunching.

## Google Analytics

Google Analytics (GA) is a a very powerful tool that can combine website usage with A/B tests (in GA called "Experiments"). Read about [how to use Google Analytics Experiments](google-analytics-experiments/index.md) to run your tests.

**Classic or Universal Analytics?** It's important that you know which version of Google Analytics your site is using else your data will not be saved.

### Google Classic Analytics

Use:
*  `PhpAb\Analytics\DataCollector\Google` to store user test participations
*  `PhpAb\Analytics\Renderer\Google\GoogleClassicAnalytics` to render in your page the JavaScript required by Google to track participation.

```php
// This illustrates a test with:
// * Cookie storage
// * Random Variant Chooser
// * Simple variants
// * Google Classic Analytics

use PhpAb\Storage\Cookie;
use PhpAb\Participation\Manager;
use PhpAb\Analytics\DataCollector\Google;
use PhpAb\Event\Dispatcher;
use PhpAb\Participation\Filter\Percentage;
use PhpAb\Variant\Chooser\RandomChooser;
use PhpAb\Engine\Engine;
use PhpAb\Variant\SimpleVariant;
use PhpAb\Test\Test;
use PhpAb\Analytics\Renderer\Google\GoogleClassicAnalytics;

$storage = new Cookie('phpab');
$manager = new Manager($storage);

$analyticsData = new Google();

$dispatcher = new Dispatcher();
$dispatcher->addSubscriber($analyticsData);

$filter = new Percentage(100);
$chooser = new RandomChooser();

$engine = new Engine($manager, $dispatcher, $filter, $chooser);

$test = new Test(
    'buttonColour',
    [],
    [Google::EXPERIMENT_ID => 'ABC123']
);

$test->addVariant(new SimpleVariant('control'));
$test->addVariant(new SimpleVariant('variant'));

$engine->addTest($test);
$engine->start();

$analytics = new GoogleClassicAnalytics($analyticsData->getTestsData());

// In your views run
// echo $analytics->getScript()

```

### Google Universal Analytics

Use:
* `PhpAb\Analytics\DataCollector\Google` to store user test participations
* `PhpAb\Analytics\Renderer\Google\GoogleUniversalAnalytics` to render in your page the JavaScript required by Google to track participation.


```php
// This illustrates a test with:
// * Cookie storage
// * Random Variant Chooser
// * Simple variants
// * Google Universal Analytics

use PhpAb\Storage\Cookie;
use PhpAb\Participation\Manager;
use PhpAb\Analytics\DataCollector\Google;
use PhpAb\Event\Dispatcher;
use PhpAb\Participation\Filter\Percentage;
use PhpAb\Variant\Chooser\RandomChooser;
use PhpAb\Engine\Engine;
use PhpAb\Variant\SimpleVariant;
use PhpAb\Test\Test;
use PhpAb\Analytics\Renderer\Google\GoogleUniversalAnalytics;

$storage = new Cookie('phpab');
$manager = new Manager($storage);

$analyticsData = new Google();

$dispatcher = new Dispatcher();
$dispatcher->addSubscriber($analyticsData);

$filter = new Percentage(100);
$chooser = new RandomChooser();

$engine = new Engine($manager, $dispatcher, $filter, $chooser);

$test = new Test(
    'buttonColour',
    [],
    [Google::EXPERIMENT_ID => 'ABC123']
);

$test->addVariant(new SimpleVariant('control'));
$test->addVariant(new SimpleVariant('variant'));

$engine->addTest($test);
$engine->start();

$analytics = new GoogleUniversalAnalytics($analyticsData->getTestsData());

// In your views run
// echo $analytics->getScript()
```

## PDO

PDO is a Database Abstraction Layer (DBAL) and, as such, allows you to interact with different database services using the same api.
To store PhpAb test participations using PDO you must:

### Install module
Due to its requirements, PDO Analytics is shipped as a separate library.
Install it via composer with:

```bash
$ composer require phpab/analytics-pdo
```
**Note:** Make sure you have installed the database driver you intend to use.

### Usage

This example uses `Sqlite` as storage service.

```php

use PhpAb\Storage\Cookie;
use PhpAb\Participation\Manager;
use PhpAb\Analytics\DataCollector\Generic;
use PhpAb\Event\Dispatcher;
use PhpAb\Participation\Filter\Percentage;
use PhpAb\Variant\Chooser\RandomChooser;
use PhpAb\Engine\Engine;
use PhpAb\Test\Test;
use PhpAb\Variant\SimpleVariant;
use PhpAb\Variant\CallbackVariant;

$storage = new Cookie('phpab');
$manager = new Manager($storage);

$analyticsData = new Generic();

$dispatcher = new Dispatcher();
$dispatcher->addSubscriber($analyticsData);

$filter = new Percentage(50);
$chooser = new RandomChooser();

$engine = new Engine($manager, $dispatcher, $filter, $chooser);

$test = new Test('foo_test');
$test->addVariant(new SimpleVariant('_control'));
$test->addVariant(new CallbackVariant('v1', function () {
    echo 'v1';
}));
$test->addVariant(new CallbackVariant('v2', function () {
    echo 'v2';
}));
$test->addVariant(new CallbackVariant('v3', function () {
    echo 'v3';
}));

// Add some tests
$engine->addTest($test);

$engine->start();

// Here starts PDO interaction
$pdo = new PDO('sqlite:./phpab.db');

$options = [
    'runTable' => 'Run',
    'testIdentifierField' => 'testIdentifier',
    'variantIdentifierField' => 'variantIdentifier',
    'userIdentifierField' => 'userIdentifier',
    'scenarioIdentifierField' => 'scenarioIdentifier',
    'runIdentifierField' => 'runIdentifier',
    'createdAtField' => 'createdAt'
];

// Inject PDO instance together with Analytics Data
$analytics = new \PhpAb\Analytics\PDO(
    $analyticsData->getTestsData(),
    $pdo,
    $options
);

// Store it providing a user identifier and a scenario
// typically a URL or a controller name

$analytics->store('1.2.3.4-abc', 'homepage.php');
```

The class `\PhpAb\Analytics\PDO` expects 3 parameters:
* The the participation data array
* The PDO instance
* The table and fialds definition (optional)

Once these parameters are passed, execute the `store($userIdentifier, $scenarioIdentifier)` passing two parameters:
* User identifier, a string that will represent a website visitor. Usually these are stored in a cookie.
* Scenario identifier, this is typically a url, either a complete one, or a normalized one.

Note: You can check the code and examples at [Analytics-PDO](https://github.com/phpab/analytics-pdo).

## MongoDB

To store PhpAb test participations using `MongoDB` you must:

### Install module
Due to its requirements, MongoDB Analytics is shipped as a separate library.
Install it via composer with:

```bash
$ composer require phpab/analytics-mongodb
```

### Usage

```php
use PhpAb\Storage\Cookie;
use PhpAb\Participation\Manager;
use PhpAb\Analytics\DataCollector\Generic;
use PhpAb\Event\Dispatcher;
use PhpAb\Participation\Filter\Percentage;
use PhpAb\Variant\Chooser\RandomChooser;
use PhpAb\Variant\SimpleVariant;
use PhpAb\Variant\CallbackVariant;
use PhpAb\Engine\Engine;
use PhpAb\Test\Test;

$storage = new Cookie('phpab');
$manager = new Manager($storage);

$analyticsData = new Generic();

$dispatcher = new Dispatcher();
$dispatcher->addSubscriber($analyticsData);

$filter = new Percentage(50);
$chooser = new RandomChooser();

$engine = new Engine($manager, $dispatcher, $filter, $chooser);

$test = new Test('foo_test');
$test->addVariant(new SimpleVariant('_control'));
$test->addVariant(new CallbackVariant('v1', function () {
    echo 'v1';
}));
$test->addVariant(new CallbackVariant('v2', function () {
    echo 'v2';
}));
$test->addVariant(new CallbackVariant('v3', function () {
    echo 'v3';
}));

// Add some tests
$engine->addTest($test);

$engine->start();

// Here starts MongoDB interaction

// Provide a MongoDB Collection to be injected
$mongoCollection = (new \MongoDB\Client)->phpab->run;

// Inject together with Analytics Data
$analytics = new \PhpAb\Analytics\MongoDB(
        $analyticsData->getTestsData(), $mongoCollection
);

// Store it providing a user identifier and a scenario
// typically a URL or a controller name

$result = $analytics->store('1.2.3.4-abc', 'homepage.php');
```

The class `\PhpAb\Analytics\MongoDB` expects 2 parameters:
* The the participation data array
* The `MongoDB` collection name where participation will be stored

Once these parameters are passed, execute the `store($userIdentifier, $scenarioIdentifier)` passing two parameters:
* User identifier, a string that will represent a website visitor. Usually these are stored in a cookie.
* Scenario identifier, this is typically a url, either a complete one, or a normalized one.

Note: You can check the code and examples at [Analytics-MongoDB](https://github.com/phpab/analytics-mongodb).


