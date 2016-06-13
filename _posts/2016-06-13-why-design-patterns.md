---
layout: post
title: '"How will design patterns make me a better coder?"'
excerpt: A design pattern itself won't make you a better programmer. Knowing lots of them - when to use them, and their strengths and weaknesses - will. Design patterns are experience, coalesced and distilled.
type: post
published: true
status: publish
categories:
- Software Thinking
- Design Patterns
tags: []
author: Dan Bernier
date: 2016-06-13 13:00:00 -05:00
---

_In early 2012, [New Haven Ruby](http://newhavenrb.org/) did a book-club style reading of [Design Patterns in Ruby](https://www.amazon.com/Design-Patterns-Ruby-Russ-Olsen/dp/0321490452/). During discussions, one question kept coming up: "How will design patterns make me a better coder?" I wrote up this answer, but for some reason, never sent it. Having recently discovered it, I thought I'd post it (after a bit of polishing), in the hopes that it's useful._

We've regularly been using this question to frame our patterns discussions. It's a good question, and not just for getting us back on track when we're out in the weeds. But every time it's asked, I feel like we're getting something wrong.

A design pattern itself won't make you a better programmer. Knowing lots of them - when to use them, and their strengths and weaknesses - will. Design patterns are experience, coalesced and distilled.

Say you have an object, and other objects need to know when it changes. If you don't know the Observer pattern, you have to think hard, and several steps ahead. You'll make progress by trial-and-error. You'll find the weaknesses of your design late in the game. If you _do_ know the Observer pattern, you get to pick from a handful of solutions, based on their strengths and weaknesses, and potential pitfalls - _before_ you build it. Knowing which patterns solve your problem is like a hacker-experience power-up.

> The cliche about hardware stores and people over thirty is this: it's a toy store. We go there to buy crap that looks cool, but that we don't really need. Wrong. My Dad was not wandering Orchard Supply looking for crap; my Dad was looking for ideas. That's what a great tool does: it inspires you to build.
- [_Rands in Repose_](http://randsinrepose.com/archives/the-forums/)

Design patterns give you ideas. A pattern teaches you how to deal with one kind of complexity; it should tell you up-front which problem it solves. And since design is about trade-offs, it should tell you what trouble you'll run into if you use it.

It's like having a programming mentor. You explain your problem, and your mentor says, "I've seen that before. If you think about it like this, organize your code like this, that should solve it. If it doesn't, maybe try moving this over to here. Careful, though - if you do this, you'll want to watch out for..." Now imagine your mentor wrote down 30 of those discussions. That's a design patterns book. Learning those patterns makes it like you've solved the problem 30 times before.

Design patterns give you ideas, and I think that's partly why they get over-used. They're inspiring - when you read about a tidy solution to a common problem, and pitfalls to watch out for, you want to try it out! And I think trying it out is how many of us really learn the pattern. But this should be deliberate practice, not code destined for production.

If you read about a pattern, and think "that's great, but I don't have that problem," stop and correct yourself: you don't have that problem _yet_.

> Every reader should ask himself periodically "Toward what end, toward what end?" -- but do not ask it too often lest you pass up the fun of programming for the constipation of bittersweet philosophy.
- [Alan Perlis, Foreward to SICP](http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-5.html#%_chap_Temp_2)
