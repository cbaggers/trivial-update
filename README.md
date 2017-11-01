# trivial-update

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg)](http://opensource.org/licenses/MIT)
[![Build Status](https://travis-ci.org/mrkkrp/trivial-update.svg?branch=master)](https://travis-ci.org/mrkkrp/trivial-update)
[![Quicklisp](http://quickdocs.org/badge/trivial-update.svg)](http://quickdocs.org/trivial-update/)

Easily change *place* with any supplied function. This library is most
useful in cases when you have do deal with places that have complex
structure.

## Installation

Copy files of this library in any place where ASDF can find them. Then you
can use it in system definitions and ASDF will take care of the rest.

Via Quicklisp (recommended):

```common-lisp
(ql:quickload "trivial-update")
```

## Description

`update place fn &rest args &environment env`

Replace value at `place` by applying function `fn` to it. Value at `place`
is used as the first argument for the given function `fn`, other optional
arguments `args` will be used to fill the rest of the argument list.
Parameter `env` is set by Common Lisp implementation during macro expansion.

If value at `place` should not be put as first argument of given function,
use partial application to pad some arguments. Combination of partial
application and `&rest` arguments will give you the opportunity to pass old
value at `place` on any position in the argument list.

Remember that keyword parameters are just pairs of normal arguments.

## License

Copyright © 2014–2017 Mark Karpov

Distributed under MIT License.
