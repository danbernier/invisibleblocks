---
layout: post
title: Separation of concerns
type: post
published: true
status: publish
categories:
- Software Thinking
tags: []
author: Dan Bernier
date: 2005-05-20 12:57:00.000000000 -04:00
---

In some fun work-time conversation today, my friend Tom & I discussed [Computerized Numerical Control (CNC)](http://en.wikipedia.org/wiki/Numerical_control) systems, and how they're being used to turn 3D models of an object into physical sculptures. You can 3D-scan an object, tweak the model if you want, ship the digital file to one of these companies, and they ship you back a physical copy of it. There areother companies that similarly create resin sculptures from digital models.

This made me think of [cafepress](http://www.cafepress.com/), where they've separated the business of creating and ordering merchandise like T-shirts, mugs, and clocks, from the business of actually producing, selling, and shipping them.  You find it used by many humor sites to earn some money off short-lived, sudden popularity (I'm thinking [SaveToby.com](http://www.savetoby.com/) and [Lions vs. 40 midgets](http://lionvs40midgets.uk-directory.com/)): make a quick .jpeg with your site's name, ship it to cafepress, click "T-shirt, clock", and link to your new online store right from your website.

This all ties back to (have you guessed yet?) separation of concerns. If you have something that does two things, break it into two things. You find this over and over in software. Components/objects/commands with clean interfaces can be easily re-used by other components/objects/commands, in ways that their creators didn't envision. That's one of the touted benefits of service-oriented architectures, as well. It's what ESR calls Unix's [Rule of Modularity](http://www.faqs.org/docs/artu/ch01s06.html#id2877537).  It's present in many of the building kits you can buy for children (no matter how
hold they are):  [Legos](http://www.lego.com/), [K'nex](http://www.knex.com/), the old [Construx](https://en.wikipedia.org/wiki/Construx)...

CNC scultpors and modular software are just a grown-up's building toys.
