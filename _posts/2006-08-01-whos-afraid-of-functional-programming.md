---
layout: post
title: Who's Afraid of Functional Programming?
type: post
published: true
status: publish
categories:
- Functional Programming
- Learning
- Programming
- Software Thinking
tags: []
author: Dan Bernier
date: 2006-08-01 21:06:51.000000000 -04:00
comments:
- author: Jeff Houser
  content: "I thought we went to the same school?  Did you end up at CCSU, or finish
    up elsewhere? \r\n\r\n When I was there it was not a Java school.  They were just
    replacing Pascal in the CS intro classes with Java when I graduated.\r\n\r\n I
    took a course in LISP.  I can't envision a use for it in the 'real world' though.
    \ Apparently it gets a lot of use in Artificial Intelligence.\r\n\r\n There are
    four ways to approach programming, and languages are bult to reflect one of the
    approaches.\r\n\r\n You can approach it from the perspective of the computer,
    and this is procedural programming.\r\n\r\n Functional languages try to approach
    the problem from the perspective  of the process.\r\n\r\n Logic oriented languages
    are built to attack the problem from the programmer's perspective.  SQL is the
    only logical-oriented language I know.  \r\n\r\n The Object Oriented approach
    is based on the perspective of the problem.\r\n\r\n Many languages, today, claim
    to be object oriented but actually have features of the other approaches to software
    development.  This is called \"Distributed Parallel\", which  just combines different
    aspects of multiple approaches in an effort to create something better.\r\n\r\n
    I once had a teacher say that most people who use C++ aren't using Object Oriented
    Development (Despite what they may claim).  I've heard the same thing said about
    Java programmers."
  date: '2006-08-03 11:56:13'
  url: http://www.jeffryhouser.com
  author_email: invisibleBlocks@farcryfly.com
- author: Dan Bernier
  content: "I finished at CCSU -- all courses used Java.  The point in calling it
    a Java School is to say that nothing looked beyond imperative procedural programming.
    \ In the AI course I took, LISP was introduced only briefly, because \"most students
    pick it up naturally.\"  Maybe enough for AI study, but there's apparently some
    very compelling reasons to use LISP for real-world work, like its expressiveness
    -- none of this was mentioned in any classes I took.  In fact, there was little-to-no
    talk comparing languages on any terms, outside of the one \"Programming Languages\"
    course (which I regret not taking).  Compared to Yale, Berkely, or MIT, where
    the first CS course uses SICP as the text, this seems pretty poor to me.\r\n\r\nIt
    seems specious to say there are only four approaches to programming.  Your descriptions
    of OO and functional programming don't really match my understanding, but you're
    a little vague, so it's hard to be certain.  For instance, what do you mean by
    \"approach the problem from the perspective of the process\"?  If logic-oriented
    languages attack the problem from the programmer's perspective, does that imply
    that programmers are always logical?  I'm not sure I agree with that -- programmers
    are people, after all.  ;-)\r\n\r\nI don't know whether you could say -most- C++/Java
    programmers aren't doing OO.  I've seen -many- programmers use Java procedurally,
    but -most- sounds to me like \"almost all of them\".  And now we reach the point
    of niggling over semantics.  =)"
  date: '2006-08-03 12:43:44'
  author_email: danbernier@gmail.com
- author: Jeff Houser
  content: "The \"four\" approaches to programming comes from one of my schooling,
    and I grabbed it out of one of the textbooks [at one point].  I'm willing to accept
    that my ramblings were vague.  To quote (well, me):\r\n\r\n[ start quote ] \r\n\r\n
    A programming language exist to tell a computer how to solve a problem...a programming
    language is designed for communication between a computer and a person.\r\n\r\n
    The four aspects of a programming language are the programmer, who tells the computer
    what to do, the computer, which solves the problem, the process that the program
    performs, and the problem that needs to be solved.  Programming languages can
    be classified into the following five different types, the first four of which
    are based on the perspective of one of these aspects, and the fifth of which comnbines
    all aspects...\r\n\r\n[ end quote ] \r\n\r\nAnd the four types are:\r\nImperative,
    based on the perspective of the computer\r\nfunctional, based on the perspective
    of the process\r\nlogic-oriented, based on the perspective of the programmer\r\nobject-oriented,
    based on the perspective of the problem\r\n\r\n( and distributed parallel, which
    combines the other four types in some manner )\r\n\r\n\r\n (BTW: let me know of
    your new e-mail address)"
  date: '2006-08-03 22:21:01'
  url: http://www.jeffryhouser.com
  author_email: invisibleBlocks@farcryfly.com
- author: Dan Bernier
  content: "\"Functional, based on the perspective of the process.\"\r\n\r\nI'm chewing
    on that.  Note that this is the thinking of someone who gets, not groks, functional
    programming.  I can see that it's based on the perspective of the process, since
    all the state management happens on the stack, instead of explicitly.  But couldn't
    you say -lots- of things focus on the perspective of the process?  Couldn't assembly
    code fit that, too?  \"Process\" sounds almost more algorithmic to me.  Help me
    out on this one.\r\n\r\nAlso, what exactly is the \"programmer's perspective\"?
    \ I would think the programmer's perspective would include the other approaches,
    instead of having its own.  I see it as the programmer explaining to the computer
    what it's supposed to do."
  date: '2006-08-09 07:17:52'
  author_email: danbernier@gmail.com
- author: Dan Bernier
  content: Jeff, if you don't mind me asking, what text/class did you get those from?
  date: '2006-08-11 12:19:06'
  author_email: danbernier@gmail.com
- author: Jeff Houser
  content: "I was actually quoting \"ColdFusion: The Complete Reference\" by me.  The
    info comes filtered through my mind from \"Programming Languages: Structures and
    Models\" by Herbert Dershem and michael Jipping.  \r\n\r\nhttp://www.amazon.com/gp/product/0534947409/sr=8-1/qid=1155564785/ref=sr_1_1/102-4484582-4835337?ie=UTF8\r\n\r\n
    This gets heavy into textbook territory, so I have no idea how to get a copy of
    the book.  I don't remember which class used this book, though.  Possibly a genric
    \"Programming Languages\" class.  \r\n\r\n I've been using languages in practice
    for so long, I can't say that I could properly differentiate between all perspectives
    from a theoretical standpoint.  Everything appears to be a hybrid approach these
    days.\r\n\r\n I think that the 'programmer perspective' is probably misnamed,
    and it should probably be called the \"user perspective\".  \r\n\r\n You seem
    to be thinking of functional programming in terms of its' implementation.  The
    'perspective' should be thought about in terms of application design, independent
    of the implementation.\r\n\r\n On another note; Is there a subscribe function
    to this blog? It'd be great to be e-mailed when comments go out to a post I've
    commented on."
  date: '2006-08-14 10:29:15'
  url: http://www.jeffryhouser.com
  author_email: invisibleBlocks@farcryfly.com
- author: Dan Bernier
  content: "No, no subscribe feature that I know of.  I'm doing free, hosted WordPress,
    so I'm at their mercy as to features. =)  For a part-time blog, the price is right.\r\n\r\nWe'll
    have to talk more about this once I've played more with functional programming..."
  date: '2006-09-06 19:57:13'
  author_email: danbernier@gmail.com
---

Joel Spolsky just published a [great (and very brief) explanation of functional programming](http://www.joelonsoftware.com/items/2006/08/01.html).  There's also a [podcast](http://webcast.berkeley.edu/courses/rss/archive.php?seriesid=1906978270) of Berkeley's CS 61A [SICP](http://mitpress.mit.edu/sicp/) course from Spring '06 that I found -- the first few lectures on functional programming are really worth your time.  And finally, for a rambling, evening-discussion style explanation of functional programming, complete with historical anecdotes, there's [Functional Programming for the Rest of Us](http://www.defmacro.org/ramblings/fp.html).  [You might want to save that one, and come back when you have some time...but do come back to it.]

Joel's article got me thinking.  I'm not really working on applications (at work or for fun) that really need massive concurrency, so that benefit of functional programming never swayed me much.  Most of the uses I see for functional programming are simple things, like the selector filters I wrote about in [Hacking the Browser's DOM for Fun]({% post_url 2006-01-18-hacking-the-browsers-dom-for-fun%})...given an array, use a function to specify which elements you're interested in.  Just like Ruby's `find` and `find_all` methods, and Java's `FileFilter` and `FileNameFilter` classes.  It's like I'm using a Maserati just to commute.  Well, [The Little Schemer](http://www.amazon.com/o/asin/0262560992) _is_ on my wishlist...it'll be fun to try the examples in both Scheme and Ruby.  Maybe even JavaScript.

Now, I went to a [Java School](http://www.joelonsoftware.com/articles/ThePerilsofJavaSchools.html), so I only heard about functional programming, LISP, Scheme, Ruby, and all these strange beasts once I started teaching myself off the internet.  No one at any of my jobs ever mentioned them.    How is it that our field can have such a rich heritage, and almost no one knows about it?  Ask the person in the next cube over whether they've ever heard of functional programming, whether they know what it is, or can explain it to you.  I guess 80% of you get blank looks.  [This offer void at telcos and good universities.]

[Quite](http://paulgraham.com/avg.html) a [ few](http://www.dehora.net/journal/2004/04/better_is_better_improving_productivity_through_programming_languages.html) [people](http://www.cabochon.com/~stevey/blog-rants/bob-paradox.html) call that a competitive advantage.  And they're right -- having scarce information puts you ahead of those without that information.  But it seems short-sighted to me to gloat over that temporary advantage, when you're missing the contributions that the people in the dark could be making.

**UPDATE:**  It occurs to me that this might sound like I think functional programming should be used for everything -- hardly the case, especially given my lack of experience with it, which I readily admit to.  My point is, why don't more of us know about it?  Why isn't it taught in more universities, or talked about at work?
