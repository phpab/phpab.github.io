---
layout: documentation
title: Google Analytics Experiments
---

# Google Analytics Experiments

PhpAb supports both **Classic Google Analytics Experiments** (legacy version) and **Universal Analytics Experiments** (current version).
Google provides different ways to interact with it. This refers to the **server-side** implementation, which means you will have to create the definition of the tests using Google Analytics and implement it in PHP using PhpAb.

To implement the experiments we assume:
* you are familiar with Google Analytics;
* you are familiar with Google Analytics Experiments.

If you aren't, worry not, Google provides extensive documentation about how these topics.
Read more:
* [Classic Google Analytics Experiments](https://developers.google.com/analytics/devguides/collection/gajs/experiments)
* [Universal Google Analytics Experiments](https://developers.google.com/analytics/devguides/collection/analyticsjs/experiments?hl=en)

Now that you are familiar with it, let's summarize the steps required to use PhpAb with Google Analytics (GA):
* In GA: [Integrate Google Analytics tracking](#integrate-google-analytics-tracking)
* In GA: [Set the goal](#create-goals) your test will try to improve.
* In GA: [Set up an experiments](#set-up-an-experiment) against a goal.
* In PhpAB: Create tests indicating the **Experiment ID** provided by GA for the experiment.
* Run the PhpAb
* Use GoogleClassicAnalytics or GoogleUniversalAnalytics to render the JavaScript that will let GA know which variant users are expericing.

After that, you will be able to read the result of your tests in GA.
Note: keep in mind that GA updates experiments data hours later and not in real time.

## Integrate Google Analytics Tracking

Google Analytics allows you to have insights about your website usage and to perform tests that can alter the behaviour of your website users. All combined in a powerful yet simple interface.

Follow [Google's instructions](https://support.google.com/analytics/answer/1008080?hl=en) to set up an account.

## Create goals

The whole purpose of running tests is to see if a variation performs better than another variation. If it does, adopt it and start again.
However, "better" might have different meanings. You might want to test the engagement of users, the amount of people that visit a page or, of course, how many buy a product.
This is why setting your goals is mandatory in Google Analytics.
Follow up [these instructions](https://support.google.com/analytics/answer/1032415?hl=en) to set them.

## Set up an experiment

We strongly recommend you to read the following page before you go any further: [https://support.google.com/analytics/answer/1745154](https://support.google.com/analytics/answer/1745154).
It will illustrate what a typical experiment cycle is.

Once you're familiar with it, you can create experiments using the [Content Experiment Interface](https://support.google.com/analytics/answer/1745154).

Pay special attention to the **Experiment ID** shown in the interface since that will have to be the identifier of the test you create.

```php
// ...
$test = new Test(
	$test1Name, 
    [], 
    [Google::EXPERIMENT_ID => '0OOzcd7jRImEIZuAcSgQmA']
);
// ..
```

![Create content experiment](/img/create-experiments-interface.png)

Now that you know what GA Experiments are, go to [Getting started](/docs/getting-started.html) for how to add tests or to [Analytics page](analytics.html) for the full Google Analytics implementation.

