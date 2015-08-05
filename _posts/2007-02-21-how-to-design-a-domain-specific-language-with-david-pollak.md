---
layout: post
title: How to Design A Domain Specific Language, with David Pollak
type: post
published: true
status: publish
categories:
- Programming
- Software Thinking
tags: []
author: Dan Bernier
date: 2007-02-21 22:08:31.000000000 -05:00
---

I just finished watching David Pollack's presentation at Google, [How to Design A Domain Specific Language](http://video.google.com/videoplay?docid=-8103284744220333344&q=ruby).  It's only an hour, and it's got some interesting ideas.  A nice jog, good for your mental health.

His main theme is bringing computing closer to the business users.  Computers exist to help us solve problems, but most people can't program, so we need all these programmers to translate for the business people, but the translation is often imperfect, so we go back and forth like couriers between the business and the machine.  Don't we have better things to be doing?  This idea of letting business users program often riles programmers who fear being automated out of a job, but I think there's enough hard stuff out there for anyone who's up for cracking some hard nuts.  I say, let's make the drudge work easier, so we can get on with the real work.

The essence of a DSL is building the semantics of the business into a mini-language, so the business people can read the code.  [Sure, they could probably write it themselves, but most don't want to.]  And if they can read the code, they can _sign off_ on the code.  Why translate specs from business-speak into Java?  Why not make the code so clear, it _is_ the spec?

Pollack points out that if you try this, you have to convince the business that the translation works.  I've seen this before...when your code is readable by the business, they'll forget that it's code.  "How do we know the software does what the requirements say?"  Because the requirements basically _are_ the software.  Once they grok it, though, you can almost remove yourself from the equation.  Pollack says of his DSL SiteMap:
<blockquote>
We were able to go through with...the business users themselves, to figure out [the navigation rules] for each page...We never had a failure where the business user didn't get something they were expecting to get.  We had to demonstrate early...that the implementation of the code matched the semantics of the DSL.  Once we proved that, the code reviews went really really quick.</blockquote>

That's a great place to be.

BTW, thanks to [Peter Cooper](http://www.rubyinside.com/3-ruby-lectures-and-presentations-given-at-google-388.html) for sharing that video.  He also shared [Code Generation With Ruby with Jack Herrington](http://video.google.com/videoplay?docid=1541014406319673545&q=ruby)...Herrington's book [Code Generation in Action](http://www.amazon.com/Code-Generation-Action-Jack-Herrington/dp/1930110979) has been on my wishlist ever since I read the sample chapters Manning let me download, so I'm really looking forward to the video.
