---
layout: post
title: Personal Design Rules
type: post
published: false
status: draft
categories: []
tags: []
author: Dan Bernier
---

[Josh Susser](http://blog.hasmanythrough.com/) suggested that the [ruby rogues](http://rubyrogues.com/) spend an [episode on personal design rules](http://rubyrogues.com/personal-design-rules/) that  they find useful.

Some of my own, mostly about MVC controllers:

Controller private methods should only act on their parameters, and only return values - don't get or set @vars.

Its corollary: Controller actions are all about application flow: no persistence or complicated logic.

Controllers shouldn't call ActiveRecord methods on models directly (cribbed from Corey Haines). This can be generalized to, Controllers shouldn't query the database directly - they should ask the Model for everything. (Even though Rails models have ActiveRecord methods, that doesn't count.)

The same goes for partials: a partial is basically a method that only returns markup. It can take parameters via :locals=>{}, and it should rely on those in preference to relying on @member_variables.

As I'm writing these down, I'm remembering times I've read someone else' checklist, and dreaded trying to remember it all, and wondering why I should care. So here are some benefits for these:

The more your code relies on other parts of the app, the more you have to think about, when reading or changing that code.
