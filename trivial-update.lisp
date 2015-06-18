;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp -*-
;;;
;;; The library that provides tools for easy modification of places with any
;;; given function.
;;;
;;; Copyright © 2014, 2015 Mark Karpov
;;;
;;; Permission is hereby granted, free of charge, to any person obtaining a
;;; copy of this software and associated documentation files (the
;;; "Software"), to deal in the Software without restriction, including
;;; without limitation the rights to use, copy, modify, merge, publish,
;;; distribute, sublicense, and/or sell copies of the Software, and to
;;; permit persons to whom the Software is furnished to do so, subject to
;;; the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be included
;;; in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
;;; OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(defpackage :trivial-update
  (:use     #:common-lisp)
  (:export  #:update))

(in-package #:trivial-update)

(defmacro update (place fn &rest args &environment env)
  "Replace value at PLACE by applying function FN to it. Value at PLACE is
used as the first argument for given function FN, other optional arguments
ARGS will be used to fill the rest of the argument list. Parameter ENV is
set by Common Lisp implementation during macro expansion.

If value at PLACE should not be put as first argument of given function, use
partial application to pad some arguments. Combination of currying and &REST
arguments will give you opportunity to pass old value at PLACE on any
position in the argument list.

Remember that keyword parameters are just pairs of normal arguments."
  (multiple-value-bind (vars forms result writer-form reader-form)
      (get-setf-expansion place env)
    (let ((g (gensym)))
      `(let* ((,g ,fn)
              ,@(mapcar #'list vars forms)
              (,(car result) (funcall ,g ,reader-form ,@args)))
         ,writer-form))))
