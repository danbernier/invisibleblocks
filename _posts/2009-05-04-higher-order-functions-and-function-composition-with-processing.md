---
layout: post
title: Higher-Order Functions and Function Composition, with Processing
type: post
published: true
status: publish
categories:
- Functional Programming
- Programming
tags: []
author: Dan Bernier
date: 2009-05-04 13:41:53.000000000 -04:00
comments:
- author: Dan
  content: "I think:\r\n\r\nfloat bright = brightness(c);\r\n\r\nin the first code
    block should be:\r\n\r\nfloat bright = brightness(i); //(s/c/i/)\r\n\r\nand:\r\n\r\nColorTrans
    grayscale = new ColorTrans() {  \r\n    float bright = brightness(c);  \r\n    return
    color(bright, bright, bright);  \r\n};\r\n\r\nshould be:\r\n\r\nColorTrans grayscale
    = new ColorTrans() {\r\n    color transform(color c) {\r\n        float bright
    = brightness(c);  \r\n        return color(bright, bright, bright);\r\n    }\r\n};"
  date: '2009-05-05 13:31:04'
  author_email: ano@nym.ous
- author: Dan Bernier
  content: "Dan,\r\n\r\nThanks, my bad.  You almost had it...for the first block,
    I forgot to make a reference to the pixel:\r\n\r\ncolor c = pixels[i];\r\n\r\n//
    get its brightness\r\nfloat bright = brightness(c);\r\n\r\nFor the second, I forgot
    to put the anonymous class' method in there (oops):\r\n\r\nColorTrans grayscale
    = new ColorTrans() {\r\n    color transform(color c) {\r\n        float bright
    = brightness(c);\r\n        return color(bright, bright, bright);\r\n    }\r\n};\r\n\r\nThe
    hazards of restructuring pasted-in code, and not re-testing it..."
  date: '2009-05-05 15:42:15'
  author_email: danbernier@gmail.com
---

I was looking for a good way to illustrate functional composition and higher order functions, and thought that something could be done with [Processing](http://processing.org), a java-based graphics tool. Among other things, Processing exposes raw pixel data for the images it renders, and you can update the pixels programatically, providing a simple kind of image filtering.

For example, here's some code that converts a color image to grayscale. Just like with HTML, colors are represented<sup><a name="f1" href="#1">1</a></sup> as 3 channels (red, green, blue), and each channel has 255 increments. A gray pixel has equal amounts of red, green, and blue, so if you get the overall brightness of a pixel, and set its color to that much red, green, and blue, it should turn the image gray.

{% highlight java linenos %}
PImage img = loadImage("tattoo.jpg");
size(img.width, img.height);  // set the window size
image(img, 0, 0);  // render the image at x:y = 0:0

loadPixels(); // load the image's pixels into an array
for (int i = 0; i < pixels.length; i++) {
    // get the color for this pixel
    color c = pixels[i];

    // get its brightness
    float bright = brightness(c);

    // Change its color to its grayscale equivalent
    pixels[i] = color(bright, bright, bright);
}
updatePixels();  // render the new pixels to the screen
{% endhighlight %}

Here's the original image:

[<img class="size-medium wp-image-265" src="{{ site.baseurl }}/assets/2009/05/tattoo.jpg" alt="the original image" width="300" height="199" />]({{ site.baseurl }}/assets/2009/05/tattoo.jpg)

...and here's the filtered version:

[<img class="size-medium wp-image-266" src="{{ site.baseurl }}/assets/2009/05/tattoo_grayscale.jpg" alt="the image in grayscale" width="300" height="199" />]({{ site.baseurl }}/assets/2009/05/tattoo_grayscale.jpg)

You can define a bunch of routines like this, each looping through the pixels the same way, but adjusting the colors differently. But if you can separate the pixel-changing part from the pixel-looping part, then you can swap in ANY pixel-changing routine, giving you a flexible image filtering system.

The pixel-changing code is essentially a function that turns one pixel's color into a new color, and the pixel-looping code uses it to replace each pixel's original color.  The pixel-changing function could be described like this:

{% highlight java linenos %}
color transform(color c) {
    ...
}
{% endhighlight %}

Many modern programming languages support first-class functions, which are a natural way to model this. Processing uses a form of Java, which doesn't have first-class functions, but we can wrap the functions in a class, giving us an object called a functor.  I called this one ColorTrans, for "color transformer".

{% highlight java linenos %}
abstract class ColorTrans {
    public abstract color transform(color c);
}
{% endhighlight %}

The ColorTrans class' only method, `transform`, is our pixel-changing function. We can re-write the loop from before to use a ColorTrans filter, and while we're at it, we'll move it into a method that takes the filename as a parameter, too.

{% highlight java linenos %}
void filterImage(String path, ColorTrans filter) {
    PImage img = loadImage(path);
    size(img.width, img.height);
    image(img, 0, 0);

    loadPixels();
    for (int i = 0; i < pixels.length; i++) {
        // use the filter parameter
        pixels[i] = filter.transform(pixels[i]);
    }
    updatePixels();
}
{% endhighlight %}

We can easily recreate the grayscale filter from earlier as a ColorTrans.

{% highlight java linenos %}
ColorTrans grayscale = new ColorTrans() {
    color transform(color c) {
        float bright = brightness(c);
        return color(bright, bright, bright);
    }
};

filterImage("tattoo.jpg", grayscale);
{% endhighlight %}

Another really easy filter to write is an inverter. If a pixel has R:100, G:30, B:255, an inverter will return the color R:(255-100), G:(255-30), B:(255-255), or R:155, G:225, B:0.

{% highlight java linenos %}
ColorTrans invert = new ColorTrans() {
    color transform(color c) {
        return color(255 - red(c),
                     255 - green(c),
                     255 - blue(c));
    }
};

filterImage("tattoo.jpg", invert);
{% endhighlight %}

The image produced by an inverter is like a film negative.

[<img class="size-medium wp-image-268" src="{{ site.baseurl }}/assets/2009/05/tattoo_invert.jpg" alt="inverted, like a negative" width="300" height="199" />]({{ site.baseurl }}/assets/2009/05/tattoo_invert.jpg)

Now we begin to see the benefits of keeping the-parts-that-change separate from the-parts-that-don't: we can easily define and swap in new filters. This is one of the big parts of higher-order programming: writing routines that are configured by passing in functions (or functors, in this case) to do part of the work.

### Manufacturing a ColorTrans


A useful kind of filter is one that increases (or decreases) the color on one channel: add some red, or remove some green. This kind of filter is easy to create:

{% highlight java linenos %}
ColorTrans aFifthMoreRed = new ColorTrans() {
    color transform(color c) {
    	return color(red(c) * 1.2, green(c), blue(c));
    }
};
{% endhighlight %}

This filter will increase the amout of red in the image by 20%. But 20% is a pretty arbitrary number; it'd be better if we could tell the filter how much to increase the red by. Generally, you'd add an "amount" parameter to the transform method, but then filterImage would have to know that this ColorTrans object takes an extra parameter. It's kind of nice having filterImage treat all ColorTrans objects the same, just passing in the color.

Instead, we can make a method that builds ColorTrans objects: we tell it how much to increase the red by, and it builds a ColorTrans that does it for us.

{% highlight java linenos %}
ColorTrans ampRed(final float amount) {
    return new ColorTrans() {
        color transform(color c) {
            color(red(c) * amount, green(c), blue(c));
        }
    };
}

ColorTrans aQuarterMoreRed = ampRed(1.25);
ColorTrans aThirdLessRed = ampRed(2/3);
ColorTrans noRedAtAll = ampRed(0);
{% endhighlight %}

(If you're curious why `amount` is final, the short answer is "because the compiler says so," but there's a better answer<sup><a name="f2" href="#2">2</a></sup>.)

This is pretty nice, because we can use this inside an animation loop, animating the amount of color amplification.

{% highlight java linenos %}
float theta = 0.0;

void setup() {
    filterImage("tattoo.jpg", noChange);
}

void draw() {
    float ampRedAmount = sin(theta) * 1.2;
    filterImage("tattoo.jpg", ampRed(ampRedAmount));
    theta += 0.1;
}
{% endhighlight %}

[Here's where I'd link to the applet, nicely hosted somewhere, if I had a hosting service that allowed applets.  I'll try to find a place to put all the code, so you can try it yourself.]

Processing calls `setup` to initialize the animation, and calls `draw` once per "tick", to advance the animation. Here, in each frame of the animation, a new ColorTrans is constructed by `ampRed`, with the amount tied to the sine wave function, oscillating between 0 and 1.2. When viewed, the amount of red in the image swells and falls, and back again<sup><a name="f3" href="#3">3</a></sup>.

This is another big part of higher-order programming: writing functions that build other functions, based on some arguments. Combined with routines that take functions as arguments, it's a handy way to break down some problems. If done well, the routines that take functions as arguments, and the functions that build those functions, can become a sort of mini-language, a fluent interface, or almost an embedded DSL.

### Plugging filters together - filter composition


This is where it gets fun. Suppose you've created an ampBlue that works just like ampRed, and now you want to filter an image with _both_ of them.  One approach might be something like this:

{% highlight java linenos %}
void draw() {
    filterImage("tattoo.jpg", ampRed(sin(theta) * 1.2));
    filterImage("tattoo.jpg", ampBlue(cos(theta) * 1.2));
}
{% endhighlight %}

Using the sine and cosine functions, the image should pulse nicely through reds and blues. The only problem is that it doesn't really work, because filterImage loads the image fresh from the filesystem each time, so you only get the effect of the ampBlue filter. So how can we apply multiple filters?

We plug them together. We want a filter that does the work of two other filters, and we want it to look like any other filter, so filterImage won't know the difference. To get this, we can add a method to ColorTrans that returns a _new_ ColorTrans, which calls first the one, and then the other.

{% highlight java linenos %}
class ColorTrans {
    ...
    public ColorTrans then(final ColorTrans applySecond) {
        final ColorTrans applyFirst = this;
        return new ColorTrans() {
	    color transform(color c) {
	        return applySecond(applyFirst(c));
	    }
	};
    }
}

filterImage("tattoo.jpg", grayscale.then(invert));
{% endhighlight %}

[<img class="size-medium wp-image-268" src="{{ site.baseurl }}/assets/2009/05/tattoo_grayscale_invert.jpg" alt="first grayscaled, then inverted" width="300" height="199" />]({{ site.baseurl }}/assets/2009/05/tattoo_grayscale_invert.jpg)

Combining filters becomes a matter of chaining them together through `then`. The red-and-blue example becomes:

{% highlight java linenos %}
void draw() {
   filterImage("tattoo.jpg",
        ampRed(sin(theta) * 1.2).then(
            ampBlue(cos(theta) * 1.2)));
}
{% endhighlight %}

### Processing does it kind of this way, too


If you look at the [source for Processing](http://dev.processing.org/source/), in [PImage.java](http://dev.processing.org/source/index.cgi/trunk/processing/core/src/processing/core/PImage.java?view=markup&rev=5417) on line 619, you'll find code that looks kind of like this:

{% highlight java linenos %}
  public void filter(int kind) {
    loadPixels();

    switch (kind) {
      case BLUR: ...
      case GRAY: ...
      case INVERT: ...
      case POSTERIZE: ...
      case RGB: ...
      case THRESHOLD: ...
      case ERODE: ...
      case DILATE: ...
    }
    updatePixels();  // mark as modified
  }
{% endhighlight %}

It basically does just what I've been doing, except the operations are hard-coded into the source, rather than being separated behind a class interface. The filters aren't composable directly, though you can call a number of them in a row:

{% highlight java linenos %}
filter(INVERT);
filter(THRESHOLD);
filter(DILATE);
{% endhighlight %}

One benefit of this approach is that it's easy to see, line-by-line, exactly what's happening.  I'd bet it beats the pants off of the ColorTrans version in benchmarks, too. But filters aren't composeable, and it's certainly not extendable. When you're doing computation-intensive graphics, every bit of speed is important; when you're illustrating a programming idea, it's not.  Decide for yourself which is more important for your needs.

____________________________________

<a name="1"></a>
1. It may seem weird, if you know Java, that the parameter's type is `color` -- it's not a java primitive, but it doesn't follow the normal classname conventions. It's just the way Processing does it. You can read more about the [color constructor in the Processing reference](http://processing.org/reference/color_.html).  [[back]](#f1)

<a name="2"></a>
2. Taken from the [AnonymousInnerClasses](http://c2.com/cgi/wiki?AnonymousInnerClass) page on the Portland Patterns Repository, 2009-04-30:
<blockquote>
AnonymousInnerClasses can also be used to create something like closures in the JavaLanguage. However they do not "close over" the lexical environment so they aren't TrueClosures. (They can capture the value of local variables, but they do not have access to the variable binding so they can't change the original variable. Which Java makes quite clear by only allowing InnerClasses to refer to local variables that have been declared final (so no-one can change them)).</blockquote>

[[back]](#f2)

<a name="3"></a>
3. The `noChange` filter returns the same color it was given -- an identity function.  `filterImage` is called inside `setup` only so the window size is set correctly, since setting the size inside `draw` has no effect. And _theta_ is just a Greek letter often used for angles and trigonometry.[[back]](#f3)
