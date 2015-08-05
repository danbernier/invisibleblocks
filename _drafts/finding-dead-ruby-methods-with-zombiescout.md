---
layout: post
title: Finding Dead Ruby Methods with ZombieScout
type: post
published: false
status: draft
categories: []
tags: []
author: Dan Bernier
---

Ever come across a screwy-looking method, and try fixing it, only to eventually realize it's never called in your application? Ever wish you could get that time back?

[ZombieScout](http://rubygems.org/gems/zombie_scout) is a gem that parses your ruby source files, gathers all the defined methods, greps for them in your *.rb, *.erb, and *.rake files, and tells you which ones are never called.

How does it find method definitions?

It recognizes instance & class methods like `def foo` and `def self.foo`, `attr_reader` and friends, forwardable delegators, and Rails scopes (if you're still into those). It doesn't support Rails delegators yet, because their syntax is more complicated. I need to make it look for `define_method`, too.

What if you have some meta-programming that generates methods? ZombieScout won't know that it's creating methods. I'd love to add a way to define AST patterns that create methods. If you have any ideas, pull requests are welcome.

It uses the [parser](http://rubygems.org/gems/parser) gem, but I'm trying a port to [Ripper](http://www.ruby-doc.org/stdlib-2.1.1/libdoc/ripper/rdoc/Ripper.html), so it always matches the version of ruby you're running.

How does it find method calls?

It greps for whole-word matches on each method name in all your project's code. If you have ruby code in files other than *.rb, *.erb, *.rake, or a Rakefile, and it's a common file format, pull requests are welcome. If it's an odd-ball file format, we'll have to add configuration for that.

TODO whitelisting
