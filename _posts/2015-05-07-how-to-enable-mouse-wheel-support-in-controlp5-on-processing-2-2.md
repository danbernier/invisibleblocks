---
layout: post
title: How to Enable Mouse Wheel Support in controlP5 on Processing 2.2
type: post
published: true
status: publish
categories:
- Open Source
- Processing
tags: []
author: Dan Bernier
date: 2015-05-07 07:23:08.000000000 -04:00
---

I'm finally using [controlP5](http://www.sojamo.de/libraries/controlP5/) in earnest, and I noticed that two-finger trackpad scrolling over a knob didn't dial the knob, like I'd hoped it would. (Thanks to [Ben Oakes](http://www.benjaminoakes.com/), again, for showing me - just yesterday afternoon - that Ubuntu's volume icon supports this. That was the trigger that got me wondering about this.)

It turns out controlP5 _does_ let you turn knobs with the mouse wheel, but, for some reason, it's disabled by default. There's an example sketch, "ControlP5mouseWheel", that shows how to enable it, but it doesn't work for me with Processing 2.2. The problematic part is the `addMouseWheelListener()` callback that mucks with `java.awt.event` stuff.

Here's a Processing 2.2-style mouseWheel callback event that gets us back to turning knobs by scrolling:

{% highlight java linenos %}
// When working in desktop mode, you can add mousewheel
// support for controlP5 by using Processing 2.2's built-in
// support:
void mouseWheel(MouseEvent e) {
  // Processing's `getCount()` returns 1 when the mouseWheel
  // is rotated down, and -1 when the mouseWheel is rotated
  // up. Natural scrolling reverses this, so you need to
  // negate the count value. Try removing the negation, if
  // the scrolling is backwards for you.
  cp5.setMouseWheelRotation(-e.getCount());
}
{% endhighlight %}

While I was at it, I noticed that controlP5 is still hosted on the retired google-code platform, [so I exported it to my github account](https://github.com/danbernier/controlp5/). I expect [Andreas](http://www.sojamo.de/) will export it to his own soon enough, and I can fork his version then, and merge in [my update to the ControlP5mouseWheel example sketch](https://github.com/danbernier/controlp5/commit/46e173c6fa51ba70a1bace80e492f343a6dc9862?w=1).
