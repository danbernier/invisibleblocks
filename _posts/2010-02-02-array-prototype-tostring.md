---
layout: post
title: Array.prototype.toString
type: post
published: true
status: publish
categories:
- Programming
tags:
- JavaScript
author: Dan Bernier
date: 2010-02-02 14:27:30.000000000 -05:00
comments:
- author: Shaurya Anand
  content: "Overriding is my favorite in any language, but you should consider a better
    example to show it for toString() in JS?\r\n\r\n['1', '2', '[3, 4]', '5'].toString()
    does the job effortlessly."
  date: '2010-02-23 13:10:06'
  url: http://geekswithblogs.net/shauryaanand
  author_email: shauryaanand@gmail.com
- author: Dan Bernier
  content: "Shaurya, your example only works because you manually .toString()'d the
    [3,4], putting <code>'[3, 4]'</code> (a string) into the root array.  If I'd changed
    Array.toString() to use a lispy style, like this:\r\n\r\n[sourcecode language=\"jscript\"]\r\nArray.prototype.toString
    = function() {\r\n    return '(' + this.join(' ') + ')';\r\n};\r\n[/sourcecode]\r\n\r\n...then
    your example would return <code>'(1 2 [3, 4] 5)'</code>, which isn't what's intended.
    \ \r\n\r\nThe thing that makes this trick work is that it's recursive, so it'll
    correctly show an array that's nested at any level.  For example, the default:\r\n<code>[[[[[[[[[1]]]]]]]]].toString();
    //-&gt; '1'</code>\r\n...with the above addition:\r\n<code>[[[[[[[[[1]]]]]]]]].toString();
    //-&gt; '[[[[[[[[[1]]]]]]]]]'</code>"
  date: '2010-02-23 13:58:09'
  author_email: danbernier@gmail.com
- author: Benjamin Oakes
  content: That's useful -- thanks for sharing.
  date: '2010-06-04 00:20:04'
  url: http://www.benjaminoakes.com/
  author_email: ben@benjaminoakes.com
---

This is one of my favorite javascript tricks, because of its effort-to-payoff ratio.

Problem: the default Array.prototype.toString hides any nested structure.

{% highlight js linenos %}
[1, 2, 3, 4, 5].toString(); //-> "1, 2, 3, 4, 5"
[1, 2, [3, 4], 5].toString(); //-> "1, 2, 3, 4, 5"
{% endhighlight %}

Solution: override Array.prototype.toString.

{% highlight js linenos %}
Array.prototype.toString = function() {
    return '[' + this.join(', ') + ']';
};

[1, 2, 3, 4, 5].toString(); //-> "[1, 2, 3, 4, 5]"
[1, 2, [3, 4], 5].toString(); //-> "[1, 2, [3, 4], 5]"
{% endhighlight %}
