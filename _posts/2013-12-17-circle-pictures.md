---
layout: post
title: Circle Pictures
type: post
published: true
status: publish
categories:
- Processing
tags:
- generative art
- image processing
- processing
author: Dan Bernier
date: 2013-12-17 14:50:38.000000000 -05:00
---

<img class="size-full" alt="Circle Pictures" src="{{ site.baseurl }}/assets/2013/12/4-dark.png" />

Take an image.

Pick a random pixel. Over a plain background of the same size as the image, draw a circle over that spot: bigger if it's lighter, smaller if it's darker. (Or reverse it: big for dark, small for light.) Repeat, but don't overlap the circles. After a while, you'll run out of empty places for new circles, so stop.

<div class='gallery'>
  <img src="{{ site.baseurl }}/assets/2013/12/1-dark.png" />
  <img src="{{ site.baseurl }}/assets/2013/12/1-light.png" />
  <img src="{{ site.baseurl }}/assets/2013/12/2-dark.png" />
  <img src="{{ site.baseurl }}/assets/2013/12/2-light.png" />
  <img src="{{ site.baseurl }}/assets/2013/12/3-dark.png" />
  <img src="{{ site.baseurl }}/assets/2013/12/3-light.png" />
  <img src="{{ site.baseurl }}/assets/2013/12/4-dark.png" />
  <img src="{{ site.baseurl }}/assets/2013/12/4-light.png" />
</div>

I screwed up the math for checking circle overlaps. At first, I was thinking: pack the circles as tight as you can, so only call it an overlap when the distance between the circle centers is less than the sum of their radii.

[<img class="size-full wp-image-788 alignright" alt="overlapping circles" src="{{ site.baseurl }}/assets/2013/12/overlap.png" width="330" height="260" />]({{ site.baseurl }}/assets/2013/12/overlap.png)

But then, from another part of my brain, I drew the circles at half-size, forgetting that Processing's `ellipse` method takes width and height parameters, not a radius. So the circles were packed less densely, and I wasn't clever enough to see why. I hacked it, and decided to count it as an overlap when the distance is bigger than the radius of the bigger circle. (Shrug. Hack.) It worked. And it looked cool.

Eventually I figured out my bug, and fixed it, but then the circles were too dense, so I went back to the happy accident.

I also tried color images. I think there's potential here, but I like these less.

<div class='gallery'>
  <img src="{{ site.baseurl }}/assets/2013/12/5-dark.png" />
  <img src="{{ site.baseurl }}/assets/2013/12/5-light.png" />
  <img src="{{ site.baseurl }}/assets/2013/12/6-dark.png" />
  <img src="{{ site.baseurl }}/assets/2013/12/6-light.png" />
  <img src="{{ site.baseurl }}/assets/2013/12/7-dark.png" />
  <img src="{{ site.baseurl }}/assets/2013/12/7-light.png" />
</div>

The source images are images of Paul Erdős, Jorge Luis Borges (twice), Henri de Toulouse-Lautrec, two sunflowers, and a cow.

<div class='gallery'>
  <img src="{{ site.baseurl }}/assets/2013/12/erdos.jpg" />
  <img src="{{ site.baseurl }}/assets/2013/12/borges1.jpg" />
  <img src="{{ site.baseurl }}/assets/2013/12/borges2.jpg" />
  <img src="{{ site.baseurl }}/assets/2013/12/lautrec.jpg" />
  <img src="{{ site.baseurl }}/assets/2013/12/sunflower.jpg" />
  <img src="{{ site.baseurl }}/assets/2013/12/sunflower2.jpg" />
  <img src="{{ site.baseurl }}/assets/2013/12/cow.png" />
</div>

Here's the source. (I tried putting it on openprocessing.org, which I normally really like, but I had troubles with the images in JavaScript mode, and they no longer support Java mode.)

{% highlight java linenos %}
PImage image;
boolean dark = true;

ArrayList circles;

// Trailing average. When the average number of tries
// to place a circle is too high,
// stop trying.
Averager averager;

String paul = "erdos.jpg";
String jorge1 = "borges1.jpg";
String jorge2 = "borges2.jpg";
String henri = "lautrec.jpg";
String sunflower = "sunflower.jpg";
String sunflower2 = "sunflower2.jpg";
String cow = "cow.png";

void setup() {
  image = loadImage(paul);
  image.resize(600, 0);
  size(image.width, image.height);

  ellipseMode(CENTER);
  noStroke();
  smooth();

  reset();
}

void reset() {
  circles = new ArrayList();
  averager = new Averager(20);
  background(dark ? 0 : 255);
}

void draw() {
  for (int i = 0; i < 10; i++) {
    drawRandomCircle();
    if (averager.average() > 100) {
      //save("7.dark.png");
      reset();
      break;
    }
  }
}

void drawRandomCircle() {
  //println(averager.average());
  Circle circ;
  int tries = 0;
  do {
    int x = floor(random(width));
    int y = floor(random(height));

    color c = image.get(x, y);
    float val = brightness(c);

    tries++;
    float circleSize = dark ?
         map(val, 255, 0, 1, 60) :
         map(val, 0, 255, 1, 60);
    circ = new Circle(x, y, c, circleSize);
  }
  while (overlaps (circ));

  averager.record(tries);

  circles.add(circ);
  circ.draw();
}

boolean overlaps(Circle c) {
  for (Circle other : circles) {
    if (c.overlaps(other)) {
      return true;
    }
  }
  return false;
}

class Circle {
  int x;
  int y;
  color c;
  float diameter;

  Circle(int x, int y, color c, float diameter) {
    this.x = x;
    this.y = y;
    this.c = c;
    this.diameter = diameter;
  }

  boolean overlaps(Circle other) {
    return dist(x, y, other.x, other.y) < max(diameter, other.diameter);
  }

  void draw() {
    fill(c);
    ellipse(x, y, diameter, diameter);
  }
}

class Averager {
  float[] values;
  int index = 0;
  Averager(int length) {
    values = new float[length];
  }

  void record(float value) {
    values[index] = value;
    index = (index + 1) % values.length;
  }

  float average() {
    float sum = 0;
    for (float val : values) {
      sum += val;
    }
    return sum / values.length;
  }
}
{% endhighlight %}
