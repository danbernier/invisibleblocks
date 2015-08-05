---
layout: post
title: Why Functional JavaScript?
type: post
published: true
status: publish
categories:
- Functional Programming
- Learning
tags:
- JavaScript
- Ruby
- scheme
author: Dan Bernier
date: 2008-01-04 18:43:15.000000000 -05:00
comments:
- author: Reg Braithwaite
  content: "Have you seen:\r\n\r\nhttp://osteele.com/sources/javascript/functional/\r\n\r\nMany
    of the delightful goodies of langauges like Haskell (partial application, currying,
    composition, point-free programming, and so forth) in a compact Javascript library.
    It now plays nicely with Rhino."
  date: '2008-01-05 02:33:40'
  url: http://weblog.raganwald.com/
  author_email: raganwald+miro@gmail.com
- author: Dan Bernier
  content: I've seen it, but haven't had the chance to dive in yet.  Just from the
    front page, it looks like it could serve as a syllabus for further exploration
    into functional programming...thanks for passing it on!
  date: '2008-01-05 14:05:15'
  author_email: danbernier@gmail.com
- author: goodmike
  content: "Daniel, great post. I have gone from loathing Javascript to really enjoying
    using it, in large part because I have discovered its functional programming potential.
    Getting to know the proptotype.js code helped me explore that. Doing a lot of
    Ajax and event handling coding made me familiar with first-class procedures. \r\n\r\nI
    too am working through SICP, through the MIT OpenCourseWare course of the same
    name, with a few other brave souls. I read the Little Schemer last year, and it
    really helped prepare me for a lot of the concepts in SICP.\r\n\r\nGood luck with
    functional Javascript. I'll keep an eye on your feed, and I look forward to reading
    more about your explorations."
  date: '2008-01-06 11:40:41'
  url: http://www.michaelharrison.ws
  author_email: mh@michaelharrison.ws
- author: Discuss | Lazycoder
  content: "[...] Why Functional Javascript?   Comments closed &mdash; Trackbacks
    closed RSS 2.0 feed for these comments This entry (permalink) [...]"
  date: '2008-01-06 12:52:41'
  url: http://www.lazycoder.com/weblog/index.php/archives/2008/01/06/discuss/
- author: Ralph
  content: If you are going to do any of the examples in SICP book, I would be curious
    how you will do a metacircular evaluator (chapter 4, I believe).  I guess that
    will not be necessary if you are strictly doing functional programming in Javascript,
    but I would be interested in seeing what you come up with. :-)
  date: '2008-01-07 00:07:32'
  url: http://coderz4life.wordpress.com
  author_email: ralph.rice@gmail.com
- author: Mark A Hershberger
  content: How about MozRepl?
  date: '2008-01-07 02:49:29'
  url: http://hexmode.com/
  author_email: mah@everybody.org
- author: Dan Bernier
  content: "@goodmike, I've been using the SICP 1981 lectures, but I might check out
    the MIT stuff...that's a great idea, I can't believe it didn't occur to me.\r\n\r\n@Ralph,
    when I get that far, I'll certainly do the metacircular evaluator in Scheme.  Maybe
    I'll give it a go in JavaScript too, though, and see how far I get.  My point
    in this post was really to say \"when I _blog_ about FP, the examples are in JavaScript,
    because...\"  I've come to enjoy Scheme, and I'll keep my eye open for ways to
    use it on-the-job, but JavaScript is generally an easier sell.\r\n\r\n@Mark, I've
    never heard of MozRepl, I'll check it out.  There's probably an emacs hacker inside
    me, waiting to come out; MozRepl is one more reason for me to seriously sit down
    with it.  I expect it'll pay off, but it's always a question of how to use my
    scarce time: FP?  blogging?  linux?  emacs?  The autodidact's curse is that you
    never really graduate."
  date: '2008-01-07 13:46:16'
  author_email: danbernier@gmail.com
---

I'm teaching myself functional programming (FP).  I first noticed it in Ruby, even though it's been in JavaScript all along.  I'm working my way through [Structure and Interpretation of Computer Programs](http://mitpress.mit.edu/sicp/full-text/book/book.html) (SICP), and [The Little Schemer](http://www.ccs.neu.edu/home/matthias/BTLS/) books, so I'm learning Scheme and Lisp too.

When studying FP, I generally use JavaScript and Scheme.  My FP examples here are usually in JavaScript:

* It's available everywhere, and most programmers are comfortable reading it.
* It's closer to Scheme than Ruby is, so the examples translate better.  In fact, Douglas Crockford [notes](http://javascript.crockford.com/little.html):  "JavaScript has much in common with Scheme. It is a dynamic language. It has a flexible datatype (arrays) that can easily simulate s-expressions. And most importantly, functions are lambdas.  Because of this deep similarity, all of the functions in The Little Schemer can be written in JavaScript."

I include Ruby or Scheme, though, if it seems appropriate.

I often use the [JavaScript Shell](http://www.squarefree.com/shell/shell.html), or its big brother, the [JavaScript Development environment](http://www.squarefree.com/jsenv/), because I haven't found or built a JavaScript REPL as nice as [Dr. Scheme](http://www.plt-scheme.org/software/drscheme/).

### Performance


Most current JavaScript implementations are slow with [recursion](http://www.kirit.com/Recursive%20rights%20and%20wrongs) and [closures](http://blogs.msdn.com/ie/archive/2007/01/04/ie-jscript-performance-recommendations-part-3-javascript-code-inefficiencies.aspx)...two cornerstones of functional programming.

I don't worry about this, because my examples are not meant to be dropped into production systems without thought and testing.  I write production-ready code at work; here, I play and explore.  We do use some functional JavaScript where I work, but it's where the performance is acceptable, and the imperative alternative would be too unwieldly.

History seems to show that performance is a short-term concern, and better programming techniques are a long-term concern.  It also seems that there are no inherent reasons JavaScript is slow; more performant implementations may be in our future.

### Why not Haskell or Erlang?


...or OCaml, Scala, F#, Clojure?  I'm getting there.  SICP and The Little Schemer books are more than enough for me right now.
