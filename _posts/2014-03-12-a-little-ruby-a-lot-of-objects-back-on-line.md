---
layout: post
title: '"A Little Ruby, a Lot of Objects," back on line'
type: post
published: true
status: publish
categories:
- Book Review
- Programming
- Recommended Reading
tags:
- Ruby
author: Dan Bernier
date: 2014-03-12 09:56:07.000000000 -04:00
---

When I was first learning Ruby, one of the resources that helped me most was [Brian Marick's](http://www.exampler.com) "A Little Ruby, a Lot of Objects." It's modeled after [The Little Schemer](http://mitpress.mit.edu/books/little-schemer) (or, if you're older, [The Little LISPer](http://books.google.com/books/about/The_little_LISPer.html?id=vbFQAAAAMAAJ)), but it uses Ruby, and teaches the core ideas of object-oriented programming in a way that helped me, even after I'd been doing OOP for 6 years. (I'm not surprised that his newer book, [Functional Programming for the Object-Oriented Programmer](https://leanpub.com/fp-oo), is just as illuminating.) The only thing I didn't like was that it stopped after only 55 pages.

My team is about to welcome a new junior intern, and when [Ben](http://www.benjaminoakes.com) asked me for any learning resources I thought we should send, I suggested "A Little Ruby." I have the original PDFs, but we were planning to send an email with URLs, and that's when I realized that the book's site, visibleworkings.com/little-ruby, was down.

I asked Brian whether I could host the files, and [he agreed](https://twitter.com/marick/status/443705433388118017) (thanks again!), so here they are:

**A Little Ruby, A Lot of Objects**

[Front Matter]({{site.baseurl}}/assets/2014/03/FrontMatter.pdf)

"My goal is to teach you a way to think about computation, to show you how far you can take a simple idea: that all computation consists of sending messages to objects."

"The real reason for reading this book is that the ideas in it are _neat_."

[Chapter 1: We've Got Class...]({{site.baseurl}}/assets/2014/03/Chapter1.pdf)

The First Message: _Computation is sending messages to objects._

The Second Message: _Message names describe the desired result, independently of the object that provides it._

The Third Message: _Classes provide interface and hide representation._

[Chapter 2: ...We Get It From Others]({{site.baseurl}}/assets/2014/03/Chapter2.pdf)

The Fourth Message: _Protocols group messages into coherent sets. If two different classes implement the same protocol, programs that depend only on that protocol can use them interchangeably._

The Fifth Message: _Classes define protocols for their subclasses._

The Sixth Message: _If a class and its superclass have methods with the same name, the class's methods take precedence._

The Seventh Message: _Instance variables are always found in_ self.

[Chapter 3: Turtles All The Way Down]({{site.baseurl}}/assets/2014/03/Chapter3.pdf)

The Eighth Message: _Classes are objects with a protocol to create other objects_

The Ninth Message: _Methods are found by searching through lists of objects._

The Tenth Message: _In computation, simple rules combine to allow complex possibilities_

The Eleventh Message: _Everything inherits from `Object`._
