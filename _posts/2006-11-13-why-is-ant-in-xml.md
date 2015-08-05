---
layout: post
title: Why is Ant in XML?
type: post
published: true
status: publish
categories:
- Programming
tags: []
author: Dan Bernier
date: 2006-11-13 18:02:44.000000000 -05:00
comments:
- author: Dan
  content: Interesting points.  Not all application builders are programmers,though.  Let
    alone OO programmers.  Implementing a build in an imperative OO language would
    make it more difficult to use for many.  I think one of the reason Ant is so popular
    is its ease of use across skill sets...one doesn't have to know Java to build
    a J2EE application. This is directly attributable to the ubiquitousness of xml.  As
    always, there are trade-offs to consider.
  date: '2006-11-27 14:24:40'
  author_email: dpmtime@gmail.com
- author: Dan Bernier
  content: "Dan, I think that's analogous to HTML and the web.  HTML is declarative
    and simple, and while that helped it spread <i>everywhere</i>, it makes it a poor
    fit for specifying behavior, which is what apps are about.  Same goes for XML.\r\n\r\nTaking
    either example (HTML for web apps or XML for builds), if we started over and did
    it imperatively, there'd be a higher barrier to entry (much higher, if we use
    OO), but we'd have much more power once we were there.  There's a classic trade-off
    for you: let a few people do a lot, or lot of people do a little."
  date: '2006-11-27 20:15:37'
  author_email: danbernier@gmail.com
---

## Before we start...


"I'm about ready to get a new post up".  Heh.  That'll teach me to go on the record with my predictions.  That post about arguing is still in with the drafts, but it's stalled somehow.  In the meantime, here's something else, something exciting, something dramatic, something...nevermind, I can hear my wife snickering at me now.

## The Nature of Ant and Builds


I bring this up now because I'm wading back into Ant territory, setting up a nightly build with NAnt.  I'll refer to Ant, because all of what I'm saying applies to both Ant and NAnt, and NAnt really falls under the Ant umbrella anyway.  I can't say I ever liked Ant -- it's better than nothing, but I never worked on a build script and said "whoa, that was cool!"

Why is Ant based on <span class="caps">XML</span>?  It's not a neat-o library that lets you whip together some honkin' <span class="caps">XML</span> file to _describe_ a build process.  It's an interpreter for a domain-specific language for builds.  The Ant implementors just took the lazy way around writing an interpreter.

Let's step back a sec.  What's a build process look like?  Get the source files.  Compile them into binaries.  Run some unit tests on those binaries.  Package them.  Deploy them somewhere.  Move around some config files, maybe some page templates.  Restore, and maybe update, the database.  Run some regression tests.  Run some source code profilers.  Gather up the results.  Tell everyone what happened.

## Imperative, or Declarative?


Each of those sentences is a command, an order.  Wikipedia tells us it's called the [imperative mood](http://en.wikipedia.org/wiki/Imperative_mood#Imperative_mood), which "expresses commands, direct requests, and prohibitions.";  We're telling the build engine, the builder, what to do.  Let's personify the builder, and call him Bob (Bob the Builder, HAHAHA!)&#8212;we're ordering Bob around, like a mouthy foreman.  We are _not_ describing to Bob what should happen.  You could look at it that way, of course, but that's not really how we think about it.  "Bob, the source files live on this server.  The <span class="caps">CVS</span> login id and password are &#8216;build' and &#8216;aloha'.  There's a nifty directory called &#8216;src' on this build machine over here&#8230;";  Is that what runs through your head as you put together an Ant file?  I didn't think so.  "Bob!  Login to <span class="caps">CVS</span>!  Copy the files from /src, down to /build/src!  Compile into /bin!  Zip /bin!";  That's more like it.

So a build process is mostly imperative, not declarative.  Then, shouldn't we program a build process [imperatively](http://en.wikipedia.org/wiki/Imperative_programming), not [declaratively](http://en.wikipedia.org/wiki/Declarative_programming)?  Go ahead an scan the first bits of those wikipedia articles, they're easy reading.  Back?  Ok.  Now, I'm not saying do builds with shell scripts:  I've spent enough time dealing with Windows batch scripts, I'll take declarative <span class="caps">XML</span> over that any day.  Why?  Because Ant makes it easy to _modularize_ your code!  Sure, shell scripts can do that, sort of, but it's a messy pain.  There are hard problems, and there are problems that just _seem_ hard&#8230;using the wrong tool for the job is category two.  Ant makes it easy to wrap up a sequence of steps, and name it something meaningful, and that's great!  Holy cow, Ant has subroutines!  Yeah, C has them, too, and while C has a lot of merits, I don't think ease of maintenance is one of them.  Why not use Java, or C#, or Ruby, or Python, or _any_ OO language out there, as your build language?

Imagine this (I'm making this all up on the fly): you include the ant.jar.  Make a subclass of `ant.AntBuild`.  That `ant` package has classes that let you do build-y things, like get source from source control (different subpackages for <span class="caps">CVS</span>, Subversion, <span class="caps">VSS</span>, PVCS, whatever), get all the files in a directory, call out to the compiler, move files around, <span class="caps">FTP</span>, run unit tests, send email, and whatever else you think would be useful.  You can recreate your whole build process right in Java!

## The Money Shot


And here's why we really _should_ do it this way.  Here's the _raison d'être_ for this post, the main idea:  your local builds just compile, and run unit tests; your QA builds need to do that, plus deploy to QA servers and run regression tests and code profilers; your Production builds need to do all that, minus the profilers, but with different servers...and you don't run that <span class="caps">HTTP</span> Proxy in QA.  That build.xml just became insufficient.  _Use basic OO ideas to customize your builds by environment._  It's trivial, we do this sort of thing all the time.  Just not for builds.

Now, the funny part is that Ant is, I believe, already kind of structured this way.  You can extend it with your own tasks, Java classes that subclass some `Task` class in Ant.  Why not just expose the engine itself?  I'm sure the classes should be reorganized, since they weren't designed with this kind of use in mind.  But all those Tasks are already built, just sitting there, waiting for us to use them.  There's at least one precedent, too: Ruby has [Rake](http://rake.rubyforge.org/), which I realized is exactly what I'm talking about.  In fact, when I googled Rake for a good link, I came across this [Martin Fowler article](http://www.martinfowler.com/articles/rake.html) that I'd like to quote from:
<blockquote>

	All the build languages I've used (make, ant (Nant), and rake) use a dependency based style of computation rather than the usual imperative style. That leads us to think differently about how to program them.
</blockquote>

Martin Fowler treats these ideas much better than I did here, and goes way beyond me, into some interesting territory.

A few other thoughts that come out of this:

* **Extensions become trivial.**  Add your own Task subclass.  There's not even a separate "recognize my extension"; mechanism:  you just include your class.
* **Documentation is easy.**  What tasks are available?  How do I use them?  JavaDoc.  This also gives us pop-up help, or Intellisense in .Net.
* **Design** of your build is simplified.  How do I organize all these tasks, get those dependencies right, and all that?  We're used to thinking in imperative OO.  Let's bring that to bear on this problem.

## In Closing


A build process is like a lot of other imperative programming we do, so we might as well use an imperative language for it.  While we're at it, let's pick a language we're used to using and thinking in, and one that has some decent abstractions built-in.  Bringing all that to bear on builds should make automating them a snap.
