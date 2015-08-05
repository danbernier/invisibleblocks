---
layout: post
title: Software and Belief
type: post
published: true
status: publish
categories:
- Software Thinking
tags: []
author: Dan Bernier
date: 2006-03-20 15:45:00.000000000 -05:00
comments:
- author: Reed
  content: That was inciteful, I particularly enjoyed the metaphor you used to understand
    science.  If only the universe was written in C++...
  date: '2006-03-22 14:17:00'
- author: Dan Bernier
  content: If the universe was written in C++, 1) it would take God's intellect to
    understand it all, and 2) can you imagine all the bugs?
  date: '2006-03-24 14:49:00'
  url: http://www.blogger.com/profile/6051054
- author: jpmccusker
  content: So... It sounds like it was written in C++, then. Says the ex-C++er.
  date: '2006-07-20 23:33:57'
  url: http://subluminal.wordpress.com/
  author_email: jim@nepaug.com
---

I spent some good time last week chasing down a bug in our J2EE app.  It turned out that I was using the wrong session attribute name.  Actually, I was using a correct name, because we store the same object in session twice, with different names (let's just not talk about that), and in some situations, the attribute name I used hadn't been populated yet.  When I wrote my code, I thought I knew what the attribute name was (and I was sort of right), but I didn't double-check.

I enjoy finding my mistakes.  I don't mean that as, "better than QA finding them for me," although I guess that's true, too.  I think I like finding them because bugs often stem from incorrect beliefs, and fixing bugs is a chance to revise your beliefs.  Software is a belief-intensive activity:  you believe the web server is configured a certain way, you believe your cookie is being deleted at a certain point in the log-out process.  We believe these things because we don't want to verify them, and as long as things work as we expect them to, we're happy.

The fun starts when our beliefs don't match our experience.  Suddenly you're faced with hard evidence that what you believe is wrong.  You can choose to ignore your experience (foolish and pointless), or take time to investigate, and replace your belief with knowledge.  What's nice about software is that you can usually do this just by looking at source code or configuration files.  Imagine how much easier science would be if we could understand a phenomenon by simply looking at its source code.

Maybe we rely so much on belief in software because it's not our job to understand everything, but to make things work a certain way.  Understanding is great, but working software pays the bills.  Of course we have to understand lots of things to do our job, but since that's not our goal, we abstract away anything we can.  I mean, isn't abstraction one of the core ideas of computing and programming?  Building up layers of abstraction is like asking the programmer to sustain belief in the lower layers.

This shows up in lots of situations:  developers arguing about whose code is causing buggy behavior, developers arguing about exactly what a tool does under the hood, developers arguing about which redundant server they're running on...  You can argue about anything you believe in, but you can't argue for long about facts.  Argument indicates conflicting perspectives or opinions, which mostly boils down to belief.

I guess the lesson here is to remember this, and not to be too certain in your (software) beliefs.  If you find yourself in an argument, try to understand the beliefs on each side, and at least acknowledge that you're stating a belief.  Remember Voltaire: "Doubt is not a pleasant condition, but certainty is absurd."

PS:  Terry Pratchett's The Bromeliad Trilogy ([Truckers](http://www.amazon.com/o/asin/0060094966), [Diggers](http://www.amazon.com/o/asin/006009494X), and [Wings](http://www.amazon.com/o/asin/0060094958)) is a great story about when belief and experience collide.
