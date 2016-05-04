---
layout: documentation
title: Google Analytics
---

# Google Analytics

PhpAb supports both **Classic Google Analytics Experiments** (legacy) and **Universal Analytics Experiments** (new version).
Google provides different ways to interact with it. This refers to the **server-side** implementation.

To implement any of the two we assume:
* you are familiar with Google Analytics;
* you are familiar with Google Analytics Experiments.

If you aren't, worry not, Google provides extensive documentation about how these topics.
Read more:
* [Classic Google Analytics Experiments](https://developers.google.com/analytics/devguides/collection/gajs/experiments)
* [Universal Google Analytics Experiments](https://developers.google.com/analytics/devguides/collection/analyticsjs/experiments?hl=en)

Now that you are familiar with it, let's summarize the steps required to use PhpAb with Google Analytics (GA):
* In GA: Integrate Google Analytics tracking
* In GA: Set your Goals in control panel
* In GA: Create experiments against a created goal.
* In PhpAB: Create tests that have as identifier the **Experiment ID** provided by GA for the experiment.
* Run the PhpAb
* Use GoogleClassicAnalytics or GoogleUniversalAnalytics to render the JavaScript that will let Google Analytics know, which variant users are expericing.