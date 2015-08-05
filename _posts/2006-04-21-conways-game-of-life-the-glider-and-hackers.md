---
layout: post
title: Conway's "Game of Life", the Glider, and Hackers
type: post
published: true
status: publish
categories: []
tags:
- Graphics
- Hackers
author: Dan Bernier
date: 2006-04-21 17:04:00.000000000 -04:00
---

I just ran across [ESR's proposal](http://www.catb.org/hacker-emblem/) to adopt the [Glider from Conway's "Game of Life"](http://en.wikipedia.org/wiki/The_glider) as a "Universal Hacker Emblem".  I'm no hacker, but as he says, "hacker":
<blockquote>
...is a title of honor that generally has to be [conferred by others](http://www.catb.org/%7Eesr/jargon/html/H/hacker.html) rather than self-assumed.
</blockquote>

[If you're curious as to why anyone would want to associate or identify with hackers, you might be interested to see [how hackers define themselves](http://www.catb.org/%7Eesr/jargon/html/H/hacker.html).]

So for some time-boxed fun, I threw together a [my own version of Conway's Game of Life](http://www.myjavaserver.com/%7Edanbernier/processing/conwaysGameOfLife/), using [processing](http://www.processing.org).  The [source](http://www.myjavaserver.com/%7Edanbernier/processing/conwaysGameOfLife/conwaysGameOfLife.pde) is available for the curious.  I love how easy it is to do graphics with processing, even if the editor is horrible.  But modeling it in Java really made me want to use Ruby, mostly because it got pretty verbose at the end.  I've squeezed it down some, but it still feels clunky to me.  Once I get around to bolting JRuby into processing, I'll revise it.  In the meantime, I'd be interested in hearing what people think of it...
