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

Use GoogleClassicAnalytics to render in your page the JavaScript required by Google to track participation. You simple have to inject to it the test data collected in your DataCollector.

```php
use PhpAb\Analytics\Renderer\Google\GoogleClassicAnalytics;
//...
$analytics = new GoogleUniversalAnalytics($analyticsData->getTestsData());
```

If you haven't include Google Analytics JavaScript API Client, you can tell the class to include it too.

```php
use PhpAb\Analytics\Renderer\Google\GoogleClassicAnalytics;
//...
$analytics = new GoogleUniversalAnalytics($analyticsData->getTestsData());
$analytics->setApiCLientInclusion(true);
```
After all this, you just have to echo it in your views and Analytics will process your data for you.
```php
echo $analytics->getScript();
```

### Google Universal Analytics

Use GoogleUniversalAnalytics to render in your page the JavaScript required by Google to track participation. You simple have to inject to it the test data collected in your DataCollector.

```php
use PhpAb\Analytics\Renderer\Google\GoogleUniversalAnalytics;
//...
$analytics = new GoogleUniversalAnalytics($analyticsData->getTestsData());
```

If you haven't include Google Analytics JavaScript API Client, you can tell the class to include it too.

```php
use PhpAb\Analytics\Renderer\Google\GoogleUniversalAnalytics;
//...
$analytics = new GoogleUniversalAnalytics($analyticsData->getTestsData());
$analytics->setApiCLientInclusion(true);
```
After all this, you just have to echo it in your views and Analytics will process your data for you.
```php
echo $analytics->getScript();
```


### Rendering

TODO

## PDO

TODO

## MongoDB

TODO
