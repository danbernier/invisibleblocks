---
layout: post
title: Cantor's Snowflake
type: post
published: true
status: publish
categories:
- Processing
- Programming
tags:
- fractal
- Nature of Code
author: Dan Bernier
date: 2012-12-26 00:00:45.000000000 -05:00
---

[The Koch snowflake](http://en.wikipedia.org/wiki/Koch_snowflake) is a famous fractal.

<img class="alignnone" alt="The Koch Snowflake fractal" src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Koch_Snowflake_5th_iteration.svg/512px-Koch_Snowflake_5th_iteration.svg.png" width="307" height="307" />

So is [the Cantor set](http://en.wikipedia.org/wiki/Cantor_set).

<img class="alignnone" alt="The Cantor set" src="http://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Cantor_set_in_seven_iterations.svg/500px-Cantor_set_in_seven_iterations.svg.png" width="500" height="81" />

Less famous, maybe, is [Cantor dust](http://mathworld.wolfram.com/CantorDust.html), a version of the Cantor set made with squares instead of lines, which apparently earned it a much cooler name.

<img alt="" src="http://mathworld.wolfram.com/images/eps-gif/CantorDustFractal_700.gif" width="407" height="74" />

But as far as I know, we have no Cantor snowflake.

Since it's Christmas, and since, in the odd quiet moments between holiday noise, Daniel Shiffman's [Nature of Code](http://natureofcode.com/) has been keeping me company, I wondered if we could make a Cantor snowflake.

Here's what I came up with.

<img class="alignnone size-full wp-image-666" alt="cantor-snowflake" src="{{ site.baseurl }}/assets/2012/12/cantor-snowflake.png" width="500" height="140" />

As a bonus, it contains the Koch snowflake inside of it! I didn't expect that.

I also rendered a [Cantor snowflake PDF]({{ site.baseurl }}/assets/2012/12/cantor-snowflake.pdf), which has a couple extra generations. It could make a nice bookmark.

Here's the sourcecode, which is also running on [openprocessing](http://www.openprocessing.org/sketch/84185):

{% highlight java linenos %}
void setup() {
  size(1450, 300);

  background(255);
  noStroke();
  fill(0);

  cantorSnowflake(0, height/2, 140, 280);
}

void cantorSnowflake(float x, float y, float length, float sideStep) {
  if (length < 0.1) return;

  pushMatrix();

  hexagon(x, y, length);

  translate(sideStep, 0);

  for (int i = 0; i < 6; i++) {
    PVector point = vector(i * THIRD_PI, length * 2 / 3);
    cantorSnowflake(point.x, point.y, length / 3, sideStep);
  }

  popMatrix();
}

void hexagon(float centerX, float centerY, float length) {
  translate(centerX, centerY);

  beginShape();
  for (int i = 0; i < 6; i++) {
    hexPoint(vector(i * THIRD_PI, length));
  }
  endShape(CLOSE);
}

void hexPoint(PVector v) {
  vertex(v.x, v.y);
}

PVector vector(float rads, float length) {
  return new PVector(cos(rads) * length, sin(rads) * length);
}
{% endhighlight %}

Happy Christmas!
