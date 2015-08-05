---
layout: post
title: 'Book Review: The Information, by James Gleick'
type: post
published: true
status: publish
categories:
- Book Review
- Recommended Reading
tags:
- Claude Shannon
- complexity
- information theory
author: Dan Bernier
date: 2013-12-31 10:36:53.000000000 -05:00
---

Or: "The Information: A History, a Theory, a Flood. A Review."

[<img class="size-full wp-image-636" title="the-information-cover" src="{{ site.baseurl }}/assets/2012/10/the-information-cover.png" alt="" width="423" height="176" />]({{ site.baseurl }}/assets/2012/10/the-information-cover.png)

Oh, I was nervous about this one.

It looked so good! Such an inviting cover, such a broad and eternally relevant topic. The Information. Rational, dispassionate. Ordered. And, "A Flood:" I half-hoped it might talk about information overload. (It does, a bit.)

But so many pages. Could I justify another pop-sci book on my _To Read_ stack? Could I justify the time? Would it be fluff? or a difficult slog? If I'm reading for fun, I don't want it to be harder work than what I already do for, you know, _work._

Wasted worry.

[_The Information_](http://www.amazon.com/The-Information-History-Theory-Flood/dp/0375423729) is a layman's introduction to Claude Shannon's information theory. It covers a lot of ground, and while it can be a bit slow in parts, it's enjoyable. As a programmer, I was aware of information theory, a little, but not very clear what it was all about, or for. I was pretty sure it was lurking around behind compression, and probably positional numbering systems, especially the way they can look like dimensionality if you squint the right way, like with chmod permission bits. _The Information_ filled in a lot of gaps for me, and showed me bridges into other fields I hadn't expected.

Some teasers:

Gleick describes African talking drums as a way to illustrate information redundancy: two drums, high- and low-toned, mimic the [tonal spoken language](http://en.wikipedia.org/wiki/Tone_(linguistics)#Tonal_languages); drummers use long, flowery phrases to clarify ambiguity. He talks about how written language abstracts thought, and the invention of the dictionary.

He explains how information is like uncertainty or surprise. In a string of symbols (letters, music notes, numbers, bits), given a string of them, how easily can you guess the next one? If a torn piece of paper says "Kermit the Fr," you can infer what was torn off. If I say "I got a BigMac and fries," you can guess where I went for lunch; my adding "...at McDonald's" doesn't help you much - it doesn't add much new information. (To explore this point, Claude Shannon had his wife repeatedly guess the next word in sentences from a detective novel.)

Gleick talks about information theory's relationship to entropy. A closed system has fixed energy, but the energy dissipates: it spreads evenly throughout the system, and we can't use it to do work. If we could re-order the energy, collect it, _sort it_, we could reverse entropy. Information is _work_.

Information is also related to computability. Sometimes, the best way to store a message is to store an algorithm for computing it.

This, in particular, is something I'd noticed. Which of these is a better way to send a smiley face? This one?

<a href="{{ site.baseurl }}/assets/2012/09/smiley.png"><img class="size-full wp-image-625" title="smiley" src="{{ site.baseurl }}/assets/2012/09/smiley.png" alt="" width="250" height="250" />
</a>

Or this one?
<pre>size(250, 250);
background(255);
noFill();
smooth();
stroke(0);
strokeWeight(5);
ellipseMode(CENTER);
ellipse(125, 125, 200, 200);
ellipse(100, 90, 10, 10);
ellipse(165, 90, 10, 10);
arc(125, 125, 100, 120, 0.2, PI - 0.2);</pre>

The first is 2D grid of pixels. The second is [the code to render it](http://www.openprocessing.org/sketch/72070): an explanation of the steps to reproduce the image.

Which is better? Which is better for making an _exact _copy of that image? A checkerboard, 250 squares on a side, 250<sup>2</sup> = 62500 squares in total, and a listing of which ones should be white (about 93% of them), which should be black? Or 11 lines of text - just 222 characters? Say you had to write the message down on paper and mail it: would you rather write a list of 62500 numbers, or 11 lines of code? What would the message's recipient have to know to reproduce the image, exactly? Pixel-for-pixel?

_The Information_ also eventually gets into DNA, genetics, and memetics. (I never knew Richard Dawkins coined the word _meme_!)

[<img class="alignnone size-medium wp-image-631" title="Hey Dawkins! Thanks for all the memes!" src="{{ site.baseurl }}/assets/2012/09/dawkins.jpeg" alt="" width="300" height="300" />]({{ site.baseurl }}/assets/2012/09/dawkins.jpeg)

So. Despite being slow in parts, the book is much better, much more enjoyable, than this review. It'll be an enjoyable bunch of hours, and give you new ways to think about things.

(Postscript: I read this book in mid-2012, and wrote this review in October 2012, but somehow forgot to publish it. Maybe it was information overload?)
