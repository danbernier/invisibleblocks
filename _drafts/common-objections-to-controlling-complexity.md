---
layout: post
title: Common Objections to Controlling Complexity
type: post
published: false
status: draft
categories:
- Programming
- Software Thinking
tags:
- complexity
- information hiding
- separation of concerns
- seven plus or minus two
author: Dan Bernier
---

Alternate title: When Dealing with Philistines...

The master said to the student, "Control complexity through separation of concerns,"  The student heard

"how can I make programming easier?"

Separation of Concerns is a basic idea.  Keep separate things separate, to manage complexity.

Law of Demeter, code complexity charts and tools.

When software advice is given, usually part of the story is why you should take it.  What's the benefit?  I think most of the time, the benefit is "controlling complexity", but when faced with such an abstract benefit, we focus on more tangible, but less fundamental, things:  code re-use, minimizing changes, less typing, fewer bugs.

These more tangible, less fundamental benefits are not as long-lasting as "control complexity."  They're more situation-dependant, more tool-dependant.  "Control complexity" is timeless, "code shorter modules" isn't ("modules?  He means COBOL?").  Putting "control complexity" into a setting makes it more accessible, but this same setting strips it of some of its timelessness...by connecting it to specific languages, you make it mortal.  By casting it with something concrete, you encourage people to mistake the concrete benefit for the real thing.

It's like you can't explain it to people in one blow, because the words don't stick, they don't see the value of it.  So you tell them a story, you give them examples, you draw them pictures, and each time, the punch-line is the same, and you keep hoping that one day, they'll notice that.  They'll look at your stories and examples, and see the same idea shining through all of them, and go, "whoa, I get it."

You run 3 risks:
- the setting doesn't match the reader, so he dismisses the technique
- the setting eventually becomes obsolete, it expires
- the reader thinks there are no _other_ benefits.
- "Separate content from presentation" because: you can change look-n-feel, but also, you can parse with Lucene!  Build an admin GUI!  More easily scan your content visually!

#### Separation of Concerns


"Separate your content from your presentation.  Then, you can change the look-and-feel of your whole site from just one place."
_When marketing tells us to change the look-and-feel, it'll be a huge months-long project anyway.  It's easier to just format this with tables._

"Encapsulate your class variables behind a layer of public methods.  Later, if you want to track that state differently, you only have to change the methods."
_I have grep to help me make the changes, and the compiler will tell me for sure if I've missed any references to the variables.  What's the big deal?_

"Modularize functionality into classes, components, or subroutines.  Then you can re-use your code, and share it with other developers, decreasing the amount of code you have to write."
_This class is so specific to my project; no one else would ever reuse it.  And who's gonna keep track of all these classes, anyway?_

"Keep your logic out of your JSP scriptlets; use custom tags instead.  Then your designer can use Dreamweaver to build web apps, using only your custom tags."
_Our designers don't understand custom tags.  Anyway, they don't work on production code -- we have to turn their HTML mock-ups into real JSPs anyway._

"Use information hiding, and treat component interfaces like contracts.  Then, if a routine you're using needs to change, you don't care."
_My subroutines need parameters passed to them!  This data is needed at all levels of the system!_

"Don't embed SQL in your JSP/ASP pages.  When you need to change the SQL, you'll be running all over the place looking for it."
_So, should I build up some huge middle layer?  It's just this page, and a few others, and I need to be moving on.  I can do without it._

#### Controlling Complexity


"Prefer immutable objects, because they're thread-safe."
_But I don't really do multi-threaded programming, I just do web apps;  all my threading needs are handled by the container.  Besides, object instantiation and garbage collection are supposed to be slow, right?  And how am I supposed to do anything, if I can't change my variables?_

"When you can, use map, fold, and filter instead of custom for loops.  Managing all those loop counters can be buggy, and it makes complex operations unmanageable."
_But I'm comfortable with the for loop, even the occasional nested for.  Map, fold, and filter are strange, and no one on my team uses them.  Besides, why iterate over the collections multiple times?  Won't that be slow?_

~~~~
There are plenty of places this comes up:  Don't embed SQL in your JSP/ASP pages.

~~~~
A common pattern seems to be, "if you do it the wrong way, you'll have to change more code."  I remember my response when I first heard something like that:  "ok, that would suck, but...it wouldn't be the end of the world, would it?"  I don't think I'd have been more impressed with "separate concerns", but eventually, I came to see that _that's_ the real point;  unneccesary code changes are a symptom, not the disease.

It's like having two kitchens in your house.

~~~~

In each case, you see some common reasons for using these techniques: code re-use, less typing, separating roles, less code to change.  In each case, you see common objections:  it'll take too long, I don't need it, it'll perform poorly, it's too complicated.

In each case, there's an underlying, more basic reason for using the technique:  "[controlling complexity](http://www.google.com/search?q=quote+Controlling+complexity+essence+computer+programming+Kernigan)", "[separating concerns](http://en.wikipedia.org/wiki/Separation_of_concerns)";  or, in simpler terms, "keep it simple and clear," "minimize what you have to worry about."  Our brains can handle only so many pieces at a time ([7 +/- 2](http://en.wikipedia.org/wiki/The_Magical_Number_Seven,_Plus_or_Minus_Two), in fact); after that, we start dropping pieces.  If you're designing a large bit of code, you owe it to yourself to keep it mentally manageable, small enough to [hold it in your head](http://www.paulgraham.com/head.html).  Good design is all about the psychology and physiology of your users...even when that user is you.

**PostScript**

I couldn't find a good way to fit these in, but they kept coming to mind as I was writing:

Michael Feathers talks about viewing code as a [huge sheet of text](http://www.informit.com/articles/article.aspx?p=359417&rl=1), and learning to see its seams:  "A seam is a place where you can alter behavior in your program without editing in that place."  The way he explains and illustrates software seams can help you start sensing the shape of a piece of software, seeing beyond the huge sheet of text.

Roy Osherove has a nice [summary and review](http://weblogs.asp.net/rosherove/archive/2004/01/21/61164.aspx) of Dijkstra's [The Humble Programmer](http://www.cs.utexas.edu/~EWD/transcriptions/EWD03xx/EWD340.html).  From the closing:  "...We shall do a much better programming job, ...provided that we **respect the intrinsic limitations of the human mind** and approach the task as Very Humble Programmers."  (Emphasis mine)

The [Preface to the First Edition](http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-7.html#%_chap_Temp_4) of [SICP](http://mitpress.mit.edu/sicp/full-text/book/book.html) has a few things to say about managing complexity:
<blockquote>
...programs must be written for people to read, and only incidentally for machines to execute. Second, we believe that the essential material to be addressed by a subject at this level is ... the techniques used to control the intellectual complexity of large software systems.

Our goal is that students who complete this subject should ... have command of the major techniques for controlling complexity in a large system. ...They should know what not to read, and what they need not understand at any moment.</blockquote>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It seems that this sussing out the underlying pattern, the essence of the solution, is the first step of writing solid and extendable software.  If there's part of the pattern you don't understand, that is where you should defer decisions, code for flexibility, hide behind an interface; not because it's good design to hide those details, but because lets you make up your mind only when you know enough to do it properly.

Deciding too early, assuming you'll get it close enough, creates a pile of rubble that you have to walk around, until you clean it up.  Cleaning it up is harder than it sounds, though;  each piece is assumed to have merit, a purpose for being there, and it takes research, some convincing, and courage to delete a large section of ghost code.

Of course, you still have to see the underlying pattern, the big picture, that all the details hang from.  I can only assume that this takes experience, supplemented by a breadth of reading;  the more designs you take into your mind, the more tricks you'll have up your sleeve.
