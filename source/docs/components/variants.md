---
layout: documentation
title: Variants
---

# Variants

## Types

### Callback

WHen the callback variant is activated, it will trigger a callback function. You can
execute logic at that moment.

```php
$test = new \PhpAb\Test\Test('foo_test');
$test->addVariant(new \PhpAb\Variant\CallbackVariant('_control', function () {
    echo '_control';
}));
$test->addVariant(new \PhpAb\Variant\CallbackVariant('v2', function () {
    echo 'v2';
}));
```

### Simple

The simple variant type has no extra logic. It's simply activated and the name is
stored in the [storage](storage.html).

```php
$test = new \PhpAb\Test\Test('foo_test');
$test->addVariant(new \PhpAb\Variant\SimpleVariant('_control'));
```

### Custom Type

A custom variant type can easily be created by implementing `PhpAb\Variant\VariantInterface`

## Choosers

How a variant is chosen depends on the *variant chooser* that has been set for a test.
We support two variant choosers out of the box.

### Static

A static chooser has a predefined choice set. Simply pass the index of the variant of
choice to the constructor.

### Random

The random variant chooser picks a random (like the name says) variant from the given
list of variants.

### Custom

To create your own variant chooser, create a class that implements `PhpAb\Variant\Chooser\ChooserInterface`.

```php
<?php

namespace Awesome;

use PhpAb\Variant\Chooser\ChooserInterface;

class AlwaysFirstVariant implements ChooserInterface
 {
    public function chooseVariant($variants)
    {
        return $variants[0];
    }
 }
```
