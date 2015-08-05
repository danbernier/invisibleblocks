---
layout: post
title: Symmetrical Portraits, Undone
type: post
published: true
status: publish
categories:
- Processing
tags:
- perception
- symmetry
author: Dan Bernier
date: 2012-10-01 22:03:55.000000000 -04:00
---

Julian Wolkenstein's [Symmetrical Portraits](http://www.julianwolkenstein.com/index.php/project/symmetrical-portraits/) project just made the rounds. I could've sworn I saw it on [Brain Pickings](http://www.brainpickings.org/), but I can't find it now. Whatever, no matter.

It's a weird-looking project: take a bunch of head-shots, cut them down the middle, and mirror each half, so one asymmetrical face becomes two symmetrical faces. It's startling how much some of the pairs differ from each other. There's a hypothesis that symmetry makes the people more attractive, but some of them are pretty [uncanny](http://en.wikipedia.org/wiki/Uncanny_valley):

[<img class="size-full wp-image-642" title="symmetrical-faces" src="{{ site.baseurl }}/assets/2012/10/symmetrical-faces.png" alt="" width="413" height="368" />](http://www.julianwolkenstein.com/index.php/project/symmetrical-portraits/)

So what's a Processing goof-off going to do? Tear them apart, and put them back together. I don't know whether the asymmetrical version is right, or whether it's backwards, but I don't think it really matters, unless you know the person in the photo. Click 'em for big versions.

[<img class="alignnone size-thumbnail wp-image-645" title="fixed_01_v2" src="{{ site.baseurl }}/assets/2012/10/fixed_01_v2.jpg" alt="" width="300" height="154" />]({{ site.baseurl }}/assets/2012/10/fixed_01_v2.jpg)
[<img class="alignnone size-thumbnail wp-image-645" title="fixed_02" src="{{ site.baseurl }}/assets/2012/10/fixed_02.jpg" alt="" width="300" height="154" />]({{ site.baseurl }}/assets/2012/10/fixed_02.jpg)
[<img class="alignnone size-thumbnail wp-image-645" title="fixed_03" src="{{ site.baseurl }}/assets/2012/10/fixed_03.jpg" alt="" width="300" height="154" />]({{ site.baseurl }}/assets/2012/10/fixed_03.jpg)
[<img class="alignnone size-thumbnail wp-image-645" title="fixed_04" src="{{ site.baseurl }}/assets/2012/10/fixed_04.jpg" alt="" width="300" height="154" />]({{ site.baseurl }}/assets/2012/10/fixed_04.jpg)
[<img class="alignnone size-thumbnail wp-image-645" title="fixed_05" src="{{ site.baseurl }}/assets/2012/10/fixed_05.jpg" alt="" width="300" height="154" />]({{ site.baseurl }}/assets/2012/10/fixed_05.jpg)
[<img class="alignnone size-thumbnail wp-image-645" title="fixed_06" src="{{ site.baseurl }}/assets/2012/10/fixed_06.jpg" alt="" width="300" height="154" />]({{ site.baseurl }}/assets/2012/10/fixed_06.jpg)
[<img class="alignnone size-thumbnail wp-image-645" title="fixed_07" src="{{ site.baseurl }}/assets/2012/10/fixed_07.jpg" alt="" width="300" height="154" />]({{ site.baseurl }}/assets/2012/10/fixed_07.jpg)
[<img class="alignnone size-thumbnail wp-image-645" title="fixed_08" src="{{ site.baseurl }}/assets/2012/10/fixed_08.jpg" alt="" width="300" height="154" />]({{ site.baseurl }}/assets/2012/10/fixed_08.jpg)
[<img class="alignnone size-thumbnail wp-image-645" title="fixed_09" src="{{ site.baseurl }}/assets/2012/10/fixed_09.jpg" alt="" width="300" height="154" />]({{ site.baseurl }}/assets/2012/10/fixed_09.jpg)
[<img class="alignnone size-thumbnail wp-image-645" title="fixed_10" src="{{ site.baseurl }}/assets/2012/10/fixed_10.jpg" alt="" width="300" height="154" />]({{ site.baseurl }}/assets/2012/10/fixed_10.jpg)
[<img class="alignnone size-thumbnail wp-image-645" title="fixed_11" src="{{ site.baseurl }}/assets/2012/10/fixed_11.jpg" alt="" width="300" height="154" />]({{ site.baseurl }}/assets/2012/10/fixed_11.jpg)
[<img class="alignnone size-thumbnail wp-image-645" title="fixed_12" src="{{ site.baseurl }}/assets/2012/10/fixed_12.jpg" alt="" width="300" height="154" />]({{ site.baseurl }}/assets/2012/10/fixed_12.jpg)

Here's the code I used to de-symmetry them. Note the mouse controls: I had to tweak some of them, especially that second one of the blond short-haired guy.

{% highlight java linenos %}
// 36_Wolkenstein_12.jpg
String[] files = new String[] {
  "01_v2", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"
};
PImage[] origImgs;

int imgIndex = 0;

void setup() {
  PImage img = load(files[0]);
  size(ceil(img.width * 1.5), img.height);

  origImgs = new PImage[files.length];

  for (int i = 0; i < files.length; i++) {
    origImgs[i] = load(files[i]);
  }
}

void draw() {
  PImage orig = origImgs[imgIndex];
  image(orig, 0, 0);

  int placeLine = round(orig.width * 1.25);
  int cropLine = round(orig.width * 0.75);

  int placeOffset = round(map(mouseX, 0, width, -20, 20));
  int cropOffset = round(map(mouseY, 0, height, -20, 20));

  image(
    orig.get(0, 0, round(orig.width * 0.5), orig.height),
    orig.width, 0);

  image(
    orig.get(
      cropLine + cropOffset,
      0, round(orig.width * 0.25), orig.height
    ),
    placeLine + placeOffset, 0);
}

void keyPressed() {
  if (key == ENTER) {
    save("fixed_" + files[imgIndex] + ".jpg");
  }
  imgIndex = (imgIndex + 1) % files.length;
}

PImage load(String chunk) {
  return loadImage("36_Wolkenstein_" + chunk + ".jpg");
}
{% endhighlight %}
