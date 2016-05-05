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

By analyzing all this data, you can determine which variant is performing better.

PhpAb provides different ways to store this data. Continue reading to find out more.

## Google Analytics

Google Analytics is a a very powerful tool that can combine website usage with abtests (called Experiments). Read about [how to use Google Analytics](googleanalytics/index.md) to run your tests.

**Classic or Universal Analytics?** It's important that you know which version of Google Analytics your site is using else your data will not be saved.

### Google Classic Analytics

Use: 
* *PhpAb\Analytics\DataCollector\Google* to store user test participations
* *PhpAb\Analytics\Renderer\Google\GoogleClassicAnalytics* to render in your page the JavaScript required by Google to track participation.

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

Use GoogleUniversalAnalytics to render in your page the JavaScript required by Google to track participation. You simple have to inject to it the test data collected in your DataCollector.

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

TODO

## MongoDB

TODO
