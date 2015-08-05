---
layout: post
title: Examples of DOM Hacking
type: post
published: true
status: publish
categories:
- Programming
tags:
- JavaScript
author: Dan Bernier
date: 2006-03-06 21:27:00.000000000 -05:00
---

Finally!  You can see a full-blown example of the techniques I've been discussing [here]({{ site.baseurl }}/assets/2006/07/domhacking.txt) (the code's for IE only).

Sorry this took awhile, I've been a little behind lately. The good news is the code took me all of an hour to sling together...the real time was spent organizing, cleaning, and documenting it so it's easy to follow.

DOM hacking is of course most widely used as part of [Ajax](http://en.wikipedia.org/wiki/AJAX), to update the page with whatever data the asynchronous HTTP call brings back -- but you can still do a lot without ever leaving the client.  For example, check out the [JavaScript Tabifier](http://www.barelyfitz.com/projects/tabber/).  I haven't looked at the code too much, but it looks like it's in a similar vein.

There's also [code to make HTML tables sortable](http://www.kryogenix.org/code/browser/sorttable/) from Kryogenix.com, which I've used before -- very handy. I believe it uses some of the same techniques. Maybe I'll look them both over, and do a compare/contrast with what I've written here.
