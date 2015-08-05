---
layout: post
title: Why We Abstract, and What To Do When We Can't
type: post
published: true
status: publish
categories:
- Learning
- Programming
- Software Thinking
tags:
- abstraction
- dijkstra
- refactoring
- sicp
author: Dan Bernier
date: 2008-04-05 18:34:40.000000000 -04:00
comments:
- author: she
  content: "I dont want to be nitpicking on Hal Fulton but the concept of \"Ontogeny
    recapitulates phylogeny\" is since many years obsolete.\r\n\r\nBesides, Haeckel
    only stated an \"obvious\" fact - he did not offer any explanations.  I am aware
    that biology back then was more description than explanative (as it is these days
    thanks to countless reasons), but what _we_ can do is to look at the _current_
    information, and not think about _past_ information sets. \r\n\r\nIf one wants
    to abstract these days and needs to use biology, I'd rather point out at BioBricks
    and encourage people to build virtual organisms."
  date: '2008-04-06 19:08:27'
  author_email: she@hot.com
- author: Logan
  content: The point isn't what he said, it's that he said it in three words. The
    accuracy of the statement is irrelevant.
  date: '2008-04-06 20:50:25'
  author_email: logancapaldo@gmail.com
- author: Max
  content: "Wow, please get rid of \"Snap Shots.\" \r\nThe annoyance of seeing a screenshot
    of every page I was about to visit made me stop reading what you had to say."
  date: '2008-04-07 00:15:56'
  author_email: ihasmax@gmail.com
- author: Dan Bernier
  content: "@she, I agree with Logan...in fact, while I'd heard Haeckel's phrase before,
    I never could have told you who said it.\r\n\r\n@Max, you really don't like them?
    \ I'm not generally one for flashy UIs, but I like them.  Maybe I keep my mouse
    on the side of the text when I scroll."
  date: '2008-04-07 07:52:52'
  author_email: danbernier@gmail.com
- author: Casper Bang
  content: "\"Any problem in computer science can be solved with another layer of
    indirection. But that usually will create another problem.\" - David Wheeler\r\n\r\nI
    like abstractions in the language (properties, events, closures, enums etc.) but
    I hate to be buried in complex stacks and frameworks of the kind extremely pervasive
    in the Java space. Patterns can be handy as a communication mechanism but really
    they belong to the latter type of indirection. Thank goodness we don't have to
    roll our own OO pattern complete with VTABLE lookups etc."
  date: '2008-04-07 08:21:28'
  url: http://coffeecokeandcode.blogspot.com/
  author_email: casper@jbr.dk
- author: Piers Cawley
  content: "I sometimes think that a program is like some strange sort of waterbed
    with multiple cells. Complexity is the water - when you squeeze the water out
    of one cell it doesn't disappear, it just goes somewhere else. Our job as programmers
    is to choose abstractions (distribute the water) in such a way that we've made
    ourselves a comfortable bed.\r\n\r\nOkay, so, not the best analogy ever, but I
    think there might be something there worth saving."
  date: '2008-04-07 09:02:00'
  url: http://www.bofh.org.uk/
  author_email: pdcawley@bofh.org.uk
- author: Dan Lewis
  content: "There's another Dijkstra quote on these lines.\r\n\r\n\"the main challenge
    of computer science is how not to get lost in complexities of their own making\"\r\n\r\nIt
    says almost the opposite, doesn't it? Adding abstraction ideally moves you farther
    away from the machine and closer to \"reality\", but reality is complicated enough
    in its own right.\r\n\r\nIn the worst case scenario, abstraction moves you away
    from the machine and away from \"reality\" into some new mathematical formalism.
    And there's no guarantee that your formalism is a net win, instead of a bunch
    of overhead. Instead it's the wisdom lost in knowledge lost in information lost
    in data."
  date: '2008-04-07 10:23:24'
  author_email: dan.a.lewis@gmail.com
- author: Dan Bernier
  content: "Now that I think about it, I feel remiss in not mentioning Joel's <a href=\"http://www.joelonsoftware.com/articles/LeakyAbstractions.html\"
    rel=\"nofollow\">leaky abstractions</a>.\r\n\r\n@Dan Lewis, that's a good point,
    you want abstractions that remove UNNEEDED detail, to let you focus on the IMPORTANT
    detail.  Still, while it's a problem if you abstract badly, abstracting has value.
    \ You don't stop driving a car because people sometimes have accidents, you learn
    to drive carefully."
  date: '2008-04-07 10:29:21'
  author_email: danbernier@gmail.com
- author: Paul W. Homer
  content: "I tend to think of abstraction as a 'higher level' of expressing something.
    A while back, I took a shot at trying to be a little more specific about it, which
    might help :-)\r\n\r\nhttp://theprogrammersparadox.blogspot.com/2008/01/abstraction-and-encapsulation.html\r\n\r\n\r\nPaul."
  date: '2008-04-07 15:43:58'
  url: http://theprogrammersparadox.blogspot.com/
  author_email: paul_homer@yahoo.ca
- author: stefanorodighiero.net » Blog Archive » links for 2008-04-08
  content: '[...] Why We Abstract, and What To Do When We Can''t « Invisible Blocks
    "Sometimes, the language is not the problem. Sometimes you just can''t find your
    way through. This is why you read Refactoring, and Design Patterns, but really,
    this is why you learn other programming languages. Think about the right way to
    factor the pr (tags: learning programming refactoring theory) [...]'
  date: '2008-04-08 06:34:40'
  url: http://www.stefanorodighiero.net/?p=20
- author: Real State Agent
  content: "Abstraction is simply leaving irrelevant things behind.\r\n\r\nWe all
    know no thing is irrelevant, if they fail. The only problem with programming nowdays
    is that we went back to programming in assembly code, but instead of sending codes
    (control characters) to the printers and to the screens, we are doing the same
    but to the databases and the web browsers.\r\n\r\nSome frameworks (ie: abstractions)
    have been created, but they are based too heavily on the past. Look for example
    at Hibernate, it tries to do away with SQL, but you end up writing a lot more
    code and the SQL generated is terrible. One query may end up doing 16,000 SQL
    queries. Then you wonder why the system is so slow...\r\n\r\nThe same occurs with
    HTML. Most programmers think that they need to know HTML, that's like learning
    the opcodes of the LaserJet and sending the individual characters to the printer
    (why use drivers? real men know the machine details...).\r\n\r\nObviously this
    nonsense will end with new frameworks. I'm building mine. You never see SQL nor
    HTML. ANd it is far more efficient than carefully handwritten code."
  date: '2008-04-08 17:09:36'
  author_email: rs@agent.com
- author: Dan Bernier
  content: "@Real State Agent, post a link to your framework!"
  date: '2008-04-08 21:44:41'
  author_email: danbernier@gmail.com
---

> "Whenever you see yourself writing the same thing down more than once, there's something wrong and you shouldn't be doing it, and the reason is not because it's a waste of time to write something down more than once.  It's **because there's some idea here**, a very simple idea, which has to do with the Sigma notation...not depending upon what it is I'm adding up.  And I would like to be able to always...**divide the things up** into as many pieces as I can, **each of which I understand separately**.  I would like to understand the way of adding things up, independently of what it is I'm adding up."
>- Gerald Sussman, [SICP Lecture](http://swiss.csail.mit.edu/classes/6.001/abelson-sussman-lectures/) 2a, "Higher-order Procedures" (emphasis added)

> The purpose of abstracting is not to be vague, but to create a new semantic level in which one can be absolutely precise.
> _- Edsger W. Dijkstra, [The Humble Programmer](http://www.cs.utexas.edu/~EWD/transcriptions/EWD03xx/EWD340.html)_

> What Larry Wall said about Perl holds true: "When you say something in a small language, it comes out big.  When you say something in a big language, it comes out small." The same is true for English.  The reason that biologist Ernst Haeckel could say "Ontogeny recapitulates phylogeny" in only three words was that he had these powerful words with highly specific meanings at his disposal.  We allow inner complexity of the language because it enables us to **shift the complexity away** from the individual utterance.
> _- Hal Fulton, [The Ruby Way](http://www.amazon.com/Ruby-Way-Second-Addison-Wesley-Professional/dp/0672328844), Introduction (emphasis added)_

Programming is our thoughts, and with better ways to express them, we can spend more time _thinking_ them, and less time expressing them.

3 + 3 + 3 + 3 + 3 + 3 is hard...hard to read (how many threes?), hard to get right (I lost count!), hard to reason about (piles of operations!).  3 x 6 is easy, once you learn multiplication.  This is a good trade-off.  We should look for ways to add abstractions, _new semantic levels_, to our programs.

**If you're doing the same thing twice, stop, and look for the common idea.** Peel the idea away from the context, from the details.  Grasp the idea, and then use it over and over.  As a bonus, you'll type less, re-use code, and debug less.

"But I can't find ways to do that!"

When you look at similar bits of code, and can't find a good way to remove the duplication, you're hitting the limits of either your language, or your knowledge.

Programming languages put up very real walls, they force you down their paths, often by leaving out features.  A language without recursion puts up a wall in front of recursive solutions;  a language without first-class functions makes it tough to write higher-order functions.  Language limitations are the cause of [Greenspun's Tenth Rule](http://en.wikipedia.org/wiki/Greenspun's_Tenth_Rule).

Sometimes, the language is not the problem.  Sometimes you just can't find your way through.  This is why you read [Refactoring](http://www.amazon.com/Refactoring-Improving-Design-Existing-Code/dp/0201485672), and [Design Patterns](http://www.amazon.com/Design-Patterns-Object-Oriented-Addison-Wesley-Professional/dp/0201633612), but really, this is why you [learn other programming languages](http://steve.yegge.googlepages.com/choosing-languages).  Think about the [right way to factor the problem](http://weblog.raganwald.com/2007/03/why-why-functional-programming-matters.html).

**If you can't remove the duplication, you need to work around your language, or learn some new tricks.**
