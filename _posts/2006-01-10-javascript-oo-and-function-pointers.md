---
layout: post
title: JavaScript OO and Function Pointers
type: post
published: true
status: publish
categories:
- Programming
tags:
- JavaScript
author: Dan Bernier
date: 2006-01-10 22:03:00.000000000 -05:00
comments:
- author: Michelle
  content: "couldn't we do\r\n\r\nfunction BadPublicSpeaker() {  \r\n     this.inheritFrom
    = PublicSpeaker();  \r\n}  \r\n\r\n?"
  date: '2009-09-16 14:00:24'
  author_email: michmy@gmail.com
- author: Dan Bernier
  content: "Hey Michelle,\r\n\r\nYou know, you probably could.  I'd test it out and
    see -- \"a test is worth a thousand expert opinions,\" and I'm not even an expert.
    \ I'd test it out myself now, but I'm on my wife's netbook in an airport, and
    I don't want to bother with notepad.  Call me lazy. :) \r\n\r\nIt's been a *long*
    time since I wrote this post, and my JavaScript style has changed substantially.
    \ I think I'd do things very differently now, like perhaps avoiding class-style
    OO in JavaScript.  Check out Douglas Crockford's \"JavaScript: The Good Parts,\"
    it's a good read, and very short.  http://www.amazon.com/JavaScript-Good-Parts-Douglas-Crockford/dp/0596517742"
  date: '2009-09-24 23:14:43'
  author_email: danbernier@gmail.com
- author: Jayapal Chandran
  content: "i want to do like this but it dosent work in IE6.\r\n\r\nfunction request(param,path,obj)\r\n{\r\n\tvar
    jax = createAjax();\r\n\tjax.open(\"POST\",path,true)\r\n\tjax.setRequestHeader('Content-Type','application/x-www-form-urlencoded')\r\n\tjax.onreadystatechange
    = obj\r\n\tjax.send(param)\r\n\r\n}\r\n\r\n\tvar param = makeParam(\"command,addvideo,url,url\");\r\n\trequest(param,jaxpath,
    function () { if(this.readyState==4) {\r\n\t\talert(this.responseText)\r\n\t}})\r\n\r\nbecause
    in ie6 this refers to window object and not like the c++ object rules."
  date: '2010-05-26 04:28:48'
  url: http://vikku.info
  author_email: jayapalchandran@gmail.com
---

A few things converged nicely for me this week:  function pointers in JavaScript, and hacking the browser's DOM.  I think I'll talk about function pointers and JavaScript's OO, and leave browser DOM hacking for the next post.

I picked up function pointers from Ruby.  They're there in lots of languages, but Ruby's where I discovered them.  Even though I've been using JavaScript for years, I never saw them staring me in the face.  Now that I get them, I finally get JavaScript's OO paradigm.  When you say:
{% highlight js linenos %}function PublicSpeaker() {
    this.greet = _greet;
}
function _greet() {
    alert("Hello, everyone.");
}
new PublicSpeaker().greet();{% endhighlight %}
...the deal is that `this.greet` is an instance variable of PublicSpeaker whose value is a function pointer, and JavaScript interprets `new PublicSpeaker().greet()` as "since `greet` is a function pointer, call the function it points to" (naturally).  And when you say:
{% highlight js linenos %}function BadPublicSpeaker() {
    this.inheritFrom = PublicSpeaker;
    this.inheritFrom();
}{% endhighlight %}
...you're setting the object's instance variable `inheritFrom` to the
PublicSpeaker function (bummer that you have to explicitly call the super constructer, though).

[I know I can use the `prototype` method of establishing inheritance, but I'm not entirely comfortable with it yet...I don't grok it, and I do grok this.  And just in case, here's [what grok means](http://www.ibiblio.org/lou/old/ball/chronicle/jargon.grok.html).]

It seems most of JavaScript's object-orientedness is based on function pointers.  This probably explains why I hated JavaScript's OO:  I didn't grok function pointers, so I was missing most of the picture.  I could never remember that wacky syntax.  I used to call it "object-scented" (oh, the hilarity).

All this improved understanding of JavaScript makes it much easier to start hacking the browser's DOM (among other things), which I'll get to later.  In the meantime, you can dig on [Object-Oriented Programming with JavaScript](http://www.webreference.com/js/column79/).
