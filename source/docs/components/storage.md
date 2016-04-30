---
layout: documentation
title: Storage types
---

# Storage types

When a user visits the application, the participation manager decides whether or not
the user will participate in a test. And if so, in which test the user will
participate. That choice will be remembered so that the user will have the same
experience even when the page is reloaded.

In order to remember that choice *phpab* make use of storage providers. You can
configure the library to use a specific storage provider.

## Cookie

The `Cookie` storage provider saves the tests and variants in which the user
participates, in a cookie. Only one cookie is used and you can configure the name
and lifetime of it.

## Session

The `Session` storage provider remembers the choices just for the current session. When a new session
is generated, the choices of the tests are cleared and phpab will re-evaluate if the user should participate.

## Runtime

The `Runtime` storage provider remembers the choices only for the current request. It
could be useful to use this provider for testing or development. In production you
should avoid this storage provider.
