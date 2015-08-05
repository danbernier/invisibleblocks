---
layout: post
title: Outsourcing as Bargain-Basement Software
type: post
published: true
status: publish
categories:
- Outsourcing
tags: []
author: Dan Bernier
date: 2005-10-14 18:47:00.000000000 -04:00
comments:
- author: The Other Dan
  content: |-
    Good thoughts...
    India has done a much better job of marketing their IT abilities.  The perception is that there are millions of expert programmers ready to churn out code for pennies on the dollar.  The code that I've seen come from outsourced projects is often below average.  Which leads me to believe that many times you have a few talented developers working on a project, of course acting as the face of the outsource company,but the majority of the actual programming is done by junior programmers...could these be the grunts we're trying to avoid?

    Management is drawn by the speed to market and low cost of outsourcing.  Outsourcing companies have more programmers, are better at collaborative development, and they don't have to consider ease of maintenance and other quality aspects to the extent that in-house developers would.

    The business folks don't care about these quality aspects of an application, until they start costing them money.  And where is the majority of money spent (or lost  due to slow change turnaround/missed opp.,  etc.) on an application?  Maintenance

    Obviously, poor code is harder to maintain than quality code.  So, it seems they are willing to trade lower development costs for higher maintenance costs.  This can have the ironic side-effect of lowering management's confidence in the maintenance team, not the outsource company. It also ends up costing the company more over the lifespan of the application.  Buyer Beware!

    PS. Be a man, use an axe!
  date: '2005-10-19 18:34:00'
---

Two trains of thought have been merging lately: the poor quality of the outsourced project I was working on, and "The Source Code is the Design" (see both the [original article at developer.*](http://www.developerdotstar.com/mag/articles/reeves_design.html) and the [XP Wiki page discussing it](http://xp.c2.com/TheSourceCodeIsTheDesign.html)).

The gist of "The Source Code is the Design" is that coding is a design activity, not a construction activity. High-level design (UML, specs, etc) still has to be done, but when you're coding, you're still doing design work, making design decisions that affect the eventual outcome. If business people and software managers want quality software, they should understand this, and avoid hiring code grunts. This makes sense to me.

On the other train of thought, I still see poor quality software being produced by off-shore programmers. I'm speaking entirely from my own experience, and the experience of people I know personally and have worked with. We'd have done a much better job. We regularly had to hobble the initial design because of pushback by The Vendor, and the code they delivered was poor beyond belief. It works, yes, but I hope never to have to plumb its depths. It violates most of our standards, and many basic principles of programming, period. Although it does work now.  After some thumping and kicking.

These two trains of thought come together at (I think) a disappointing conclusion. Track one: management has to wake up about how it thinks about programming, if it wants quality software. Track two: management is paying for cheaper, lower-quality software. Conclusion: great quality isn't what's wanted.

This first made me think of the shift from custom work to manufacturing. But with manufacturing, the final product is generally better than a custom one. Not at first, maybe, but once the production line has had the kinks worked out, the product is consistent, and warranties protect against lemons.

It's closer to buying low-quality products that are just good enough for how you intend to use them. I could buy a Mercedes, but if I drive a Kia, with the left-over cash I can do stuff that's more important to me than the experience of driving a sexy, finely-tuned sports car. Tools are a better analogy, since they're bought primarily for utility. Whether you buy a top-of-the-line model or the cheapest depends on how sensitive you are to its quality, how long you'll use it, and how important it is to do quality work. This is why professionals and hobbyists have nice gear, and amateurs and casual users have cheap stuff: pros have their reputation and customer satisfaction on the line, and hobbyists are spending their free time using it. I like to program, so I have a nice laptop. I rarely need a chainsaw, so I have a cheap, sissy little 14-inch electric one (in fact, I broke it over a month ago, and still haven't fixed it).

So if you're trying to decide which software package to buy, you want to know how much it costs, how good it is, and how good it has to be for you. If you're trying to sell a software package, you need to know how good your product is, how it compares to the competitors (both on quality and cost), and how good your customers need it to be. And then you need to sell yourself. Right now, U.S. IT departments are pricey, and don't advertise themselves very well. Off-shore IT shops are cheaper, and have great PR. Guess who's getting the business? There are other factors that make business people hesitate (just google "outsourcing risks"), but as those problems are solved, U.S. shops will have to get better at selling themselves, showcasing what they can do for the business.

I have some ideas how my IT department could do better: our business customers think we're too slow, and too expensive. I've suggested we try some agile projects, and loosen the stifling framework we work under. IT management sees it the other way: tighten the process so it's easy to integrate with cheap off-shore vendors. I haven't made much headway yet, but I think agile's emphasis on just-good-enough software and tight feedback loops might be the ticket to lowering cost and showing the business just how fast we can be.
