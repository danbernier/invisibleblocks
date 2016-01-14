---
layout: post
title: Sensitivity Curves
type: post
published: true
status: publish
excerpt: Math helps.
categories:
- Generative Art
- Interaction
- Math
tags: []
author: Dan Bernier
date: 2016-01-13 19:10:22 -05:00
---

<script id='handy-utils'>
function plot(p, color, f) {
  p.push();
  p.noStroke();
  p.fill(color);
  for (var x = 0; x < p.width; x++) {
    var y = f(x);
    p.ellipse(x, y, 1, 1);
  }
  p.pop();
}

function drawSquareAt(p, x, y, angle) {
  p.push();
  p.translate(x, y);
  p.rotate(angle);

  p.rect(0, 0, 100, 100);
  p.pop();
}
</script>

Here's a spinning square. Move your mouse left and right, and it'll spin to the left or right. Try getting to be still:

<p id='linear' class='box-shadow'></p>
<script id='sketchSource'>
// I got the trick for running multiple sketches on one page from https://github.com/processing/p5.js/wiki/Instantiation-Cases
new p5(function(p) {
  var angle = 0;

  p.setup = function setup() {
    p.createCanvas(300, 300);
    $('#linear').append($('#defaultCanvas0'));
    p.rectMode(p.CENTER);

    p.stroke(0);
    p.strokeWeight(10);
    p.noFill();
  };

  p.draw = function draw() {
    p.background(255);

    var spinSpeed = p.map(p.mouseX, 0, p.width, -1, 1);
    angle += spinSpeed;

    drawSquareAt(p, p.width/2, p.height/2, angle);
  };
});
</script>

It's hard, isn't it? Maybe you can make it still - I can't seem to - but it's hard to find the right spot.

That's a [p5.js](http://p5js.org) sketch. Here's its `draw` function (simplified):

{% highlight javascript linenos %}
function draw() {
  background(255);

  var spinSpeed = map(mouseX, 0, width, -1, 1);
  angle += spinSpeed;

  push();
  translate(width/2, height/2);
  rotate(angle);

  rect(0, 0, 100, 100);
  pop();
};
{% endhighlight %}

Notice line four: it uses the [map](http://p5js.org/reference/#/p5/map) function to linearly map the mouse position to the spin speed.

Every millimeter yor mouse moves changes the spinning speed by the same amount. Every point sets the spin speed, and the "zero-speed" point is really small. If we overlaid a graph of the spin speeds, it might look like this:

<p id='linear-with-graph' class='box-shadow'></p>
<script>
new p5(function(p) {
  var angle = 0;

  p.setup = function setup() {
    p.createCanvas(300, 300);
    $('#linear-with-graph').append($('#defaultCanvas1'));
    p.rectMode(p.CENTER);

    p.stroke(0);
    p.strokeWeight(10);
    p.noFill();
  };

  p.draw = function draw() {
    p.background(255);

    var spinSpeed = p.map(p.mouseX, 0, p.width, -1, 1);
    angle += spinSpeed;

    drawSquareAt(p, p.width/2, p.height/2, angle);

    plot(p, '#000000', function(x) {
      return p.map(x, 0, p.width, p.height, 0);
    });

    p.push();
    p.strokeWeight(1);
    p.line(0, p.height/2, p.width, p.height/2);
    p.pop();
  };
});
</script>

The problem is that middle point is too hard to hit. It's a common problem in UIs, and often, you fix it by making the important region easier to hit.  

In this case, as the mouse moves through the middle, it should change the speed less - the speed should be more sensitive to changes in the middle (or is it "less sensitive"?). We can still cover the same range of speeds, and make up for it by squishing the ends, where tiny changes are less noticeable.[^homunculus]

[^homunculus]: I feel like this is analogous to the [Sensory Homunculus](http://blog.aimsedu.org/2013/12/02/thinking-with-things-evocative-objects/).



<p id='curved-with-graph' class='box-shadow'></p>
<script>
new p5(function(p) {
  var angle = 0;

  p.setup = function setup() {
    p.createCanvas(300, 300);
    $('#curved-with-graph').append($('#defaultCanvas2'));
    p.rectMode(p.CENTER);

    p.stroke(0);
    p.strokeWeight(10);
    p.noFill();
  };

  p.draw = function draw() {
    p.background(255);

    var spinSpeed = p.map(p.mouseX, 0, p.width, -1, 1);
    spinSpeed *= p.abs(spinSpeed);
    angle += spinSpeed;

    drawSquareAt(p, p.width/2, p.height/2, angle);

    plot(p, '#000000', function(x) {
      var sp = p.map(x, 0, p.width, -1, 1);
      sp *= p.abs(sp);
      return p.map(sp, -1, 1, p.height, 0);
    });

    p.push();
    p.strokeWeight(1);
    p.line(0, p.height/2, p.width, p.height/2);
    p.pop();
  };
});
</script>

The math for this is actually pretty simple. It uses two useful tricks.

**First trick:** _The set of real numbers between 0 and 1 are closed under multiplication._ If you multiply any number between 0 and 1 with another number between 0 and 1, you'll always get another number between 0 and 1. 1 &#215; 0.5 = 0.5.[^percent]

[^percent]: If you do the same equation with percentages, it works out wrong: 100% &#215; 50% should equal 50%, but 100 &#215; 50 = 5000. Remember, percentages are really ratios waiting to get down to 0..1: fifty _per-cent_ is fifty per hundred, or 50/100

And you can think of 1 as "whole:" multiply any number by 1, and you'll get all of it back. Any other number between 0 and 1 will give you back _less_ of something. If your spin speed is a number between 0 and 1, and you multiply it by 1, you'll stay at the same speed; multiply it by 0.9, you'll slow down a little; multiply it by 0.1, you'll slow down a lot.

If your spin speed is < 1, and you _multiply it by itself_, it'll slow down. The closer it is to zero, the less it'll slow down.

Here's the code again:

{% highlight javascript linenos %}
var spinSpeed = map(mouseX, 0, width, -1, 1);
angle += spinSpeed;
{% endhighlight %}

But our `spinSpeed` ranges from _negative one_ to one, and multiplying negative numbers makes them positive. That would mean the square would always spin in the same direction!

**Second trick:** _To square a number in the range -1..1, and preserve its sign, multiply it by its absolute value._ Obvious? Sure. But this is so useful, I think it's worth spelling out.

To multiply two numbers, and get a negative number, the numbers must have different signs.

To immitate squaring a number, but preserving its sign, 

If the value is negative, then one side must 

Sure, you could say:

```
var signedSquare = number < 0 ? number * -number : number * number;
```

Or even:

```
var signedSquare = number * (number < 0 ? -number : number);
```

But isn't this tidier? ...once you understand the trick.

```
var signedSquare = number * abs(number);
```


Here's a version where you can compare them, side-by-side:

<p id='compare' class='box-shadow'></p>
<script>
new p5(function(p) {
  var angleHard = 0;
  var angleEasy = 0;

  p.setup = function setup() {
    p.createCanvas(300, 300);
    $('#compare').append($('#defaultCanvas3'));
    p.rectMode(p.CENTER);

    p.strokeWeight(10);
    p.noFill();
  };

  p.draw = function draw() {
    p.background(255);

    var spinSpeedHard = p.map(p.mouseX, 0, p.width, -1, 1);
    var spinSpeedEasy = p.map(p.mouseX, 0, p.width, -1, 1);
    spinSpeedEasy *= p.abs(spinSpeedEasy);

    angleHard += spinSpeedHard;
    angleEasy += spinSpeedEasy;

    p.stroke(255, 0, 0);
    drawSquareAt(p, p.width/2, p.height/3, angleHard);
    p.stroke(0, 200, 0);
    drawSquareAt(p, p.width/2, p.height*2/3, angleEasy);

    plot(p, '#ff0000', function(x) {
      return p.map(x, 0, p.width, p.height, 0);
    });

    plot(p, '#00bb00', function(x) {
      var speed = p.map(x, 0, p.width, -1, 1);
      speed *= p.abs(speed);
      return p.map(speed, -1, 1, p.height, 0);
    });

    p.push();
    p.stroke(0, 50);
    p.strokeWeight(1);
    p.line(p.mouseX, 0, p.mouseX, p.height);
    p.pop();
  };
});
</script>

