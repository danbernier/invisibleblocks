---
layout: post
title: Chaos, Order, and Software Development
type: post
published: true
status: publish
categories:
- Software Thinking
tags:
- chaos
- complexity
- order
- simplicity
author: Dan Bernier
date: 2012-09-10 18:17:57.000000000 -04:00
comments:
- author: Dave Silveira
  content: "Hey Dan, \r\n\r\nNice post. Reminds of the system we worked on, and the
    one I am \"blessed with\" now. \r\n\r\nBusiness types want us to build things
    as fast as possible. Well meaning developers who don't know any better build systems
    that eventually become so rigid and fragile they can no longer provide business
    value effectively. Nobody was thinking about the big picture, just getting the
    feature out the door and getting the next client."
  date: '2012-09-12 17:18:06'
  author_email: davesilveira@gmail.com
---

[Zach Dennis](http://www.continuousthinking.com/) gave a very interesting, but not terribly well-received talk at RailsConf 2012, called "Sand Piles and Software." (It's on the [schedule](http://railsconf2012.busyconf.com/schedule/full) on Tuesday in Salon J, if you want to check it out.) Here are the [slides](https://speakerdeck.com/u/zdennis/p/sand-piles-and-software-railsconf-2012) (which are more suggestion than information), and here's the synopsis:

> This talk applies the concepts of chaos theory to software development using the [Bak–Tang–Wiesenfeld sand pile model](http://www.thp.uni-duisburg.de/~sven/_publications/_pub_source/preprint_1997_03.pdf) [PDF link] as the vehicle for exploration. The sand pile model, which is used to show how a complex system is attracted to living on the edge of chaos, will be used as a both a powerful metaphor and analogy for building software. Software, it turns out, has its own natural attraction to living in its own edge of chaos. In this talk, we'll explore what this means and entertain questions for what to do about it.

The TL;DR of the talk was: as you build your software system, as you add features, you add complexity, and when it's _too_ complex, you won't be able to add anything more, until you clean something up. So you clean a bit up, and add more complexity, until it falls over again. Like dropping grains of sand onto a sand pile, each grain is tiny, hardly worth noting, but one of them will cause a slide.

That much rang very true with me.

Zach's advice, then, was to "fall in love with simplicity," and "loathe unnecessary complication," and there are some more slides about practices and values and refactoring, but I can't remember the ideas for them; I'll have to check my notes.

To me, that part sounded virtuous.

This morning, I turned again, for other reasons, to Dick Gabriel's [Mob Software: The Erotic Life of Code](http://www.dreamsongs.com/MobSoftware.html). (I'll say it until I stop meeting programmers who haven't read him: _you are missing out._) I got to the part where he talks about swarms (he's preparing to introduce us to the Mob, the open-source hackers), and complexity emerging from local actors with simple rules, and this part reminded me of Zach Dennis' talk:

> Chaos is unpredictability: Combinations that might have lasting value or interest don't last—the energy for change is too high. Order is total predictability: The only combinations that exist are the ones that always have—the energy for stability is too high.

He goes on to quote Stuart Kauffman from "At Home in the Universe":

> It is a lovely hypothesis, with considerable supporting data, that genomic systems lie in the ordered regime near the phase transition to chaos. Were such systems too deeply into the frozen ordered regime, they would be too rigid to coordinate the complex sequences of genetic activities necessary for development. Were they too far into the gaseous chaotic regime, they would not be orderly enough.
> ...cell networks achieve both stability and flexibility...by achieving a kind of poised state balanced on the edge of chaos.

Is Zach telling us to stay where it's safe and ordered? Are we stuck on this edge between chaos and order, if we want to write interesting software? I'd like my software to be both stable and flexible. If, to achieve this stability and flexibility, its behavior must be emergent, not guided by my brain, is that ok? Or is there a way for me to still specify requirements, and get this stability and flexibility? Is emergent-design only able to produce certain kinds of software?

[<img class="aligncenter size-medium wp-image-620" title="One of Zach's slides: reaching your software's critical point" src="{{ site.baseurl }}/assets/2012/09/zach-slide-critical-point.png" alt="One of Zach's slides: reaching your software's critical point" width="300" height="224" />]({{ site.baseurl }}/assets/2012/09/zach-slide-critical-point.png)

_Thanks to [Ren](http://renprovey.com/) for reviewing this!_
