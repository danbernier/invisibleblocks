---
layout: post
title: Help, I've been outsourced, and The Vendor's code is a mess!
type: post
published: true
status: publish
categories:
- Outsourcing
tags: []
author: Dan Bernier
date: 2005-09-13 20:44:00.000000000 -04:00
---

I've been working as tech. lead, going full-speed on a project since February. Last May, we learned it would be outsourced to The Vendor in India. Since my team has never outsourced anything before, we suddenly had to figure out how the whole thing would work (of course, there's no extra time). We already did a decent amount of design work...would The Vendor repeat that work? Or would they work from what we provided them? How would they tie in to our build process? How about our internal services that use our own SOA framework? [We use proprietary, built-in-house frameworks for anything. We're just now (yes, now) moving off our proprietary MVC framework to the latest, greatest, cutting-edge Struts 1.1 MVC framework. w00t!]

Anyway, it was a hard summer, trying to figure all this new stuff out, finish the design, and not get all gloomy over my career going to India (hence the relative quiet here for the past months). I have some more posts coming about the whole experience, but for now, I wanted to say something about the quality of the code we're starting to see from The Vendor.

It sucks. The code absolutely sucks. I've occasionally seen code this bad from very junior programmers with not much talent. People keep saying "but surely they just haven't polished it up yet!" To them I say, the mess it's in makes it, oh, three times harder to understand then if they'd just keep it somewhat clean to begin with. It's not that I'm expecting a 5-lane highway and getting a dirt road, it's that I'm expecting a dirt road and getting the thickest, nastiest, buggiest (har har) jungle undergrowth that almost totally prohibits movement. We're not supposed to code at all on this project, or fix any bugs (the contract says The Vendor will do that), but I've had to whip out my trusty refactoring machete and cut some trails through the thicket just to understand the mess. Even the liason seems embarrassed.

Now I admit I like clean code, but I am not being a code priss here. I like to see evidence of thought. I like to see (say) naming conventions. Consistent capitalization would at least be nice. I like to see computer resources being used intelligently. I see none of that here. I'm not pouting that my job is being outsourced, and taking it out on the poor guys in India. This code is far below anything I'd tolerate from my team members -- even a junior programmer I'm mentoring.

I don't want to believe the programmers in India are brain-dead. I imagine, since this was a fixed-bid project that they underestimated, and since it's their first contract with my employer, that they were eager to impress, and now find themselves trying to do something impossible. [We all know how sales over-promises, and engineering suffers.] I know for a fact that they're working around 70 hour weeks, and I feel for them. Maybe there are a bunch of coders there running amok, just trying to get the thing thrown together and shipped. But then I think about some of the specific examples I've seen, and it almost defies belief. One good example will give a picture. The paraphrased code:

{% highlight java linenos %}
List counties = LoadList("countries");
session.save ("states", counties);
{% endhighlight %}

Yes, you read that right. Load a list of countries, store it in a variable called "counties", and store it in session as "states". Is it a list of counties? countries? states? Who knows? [I know, I know -- maybe "counties" is just a typo of "countries", but we do deal with counties. If this was the only problem, I'd give them the benefit of the doubt.]

What I really think is going on here (now that I finally get to it) is that the coders in India have a wide talent margin. I think there are coders there who've been coding for (maybe) three months longer than they've been employed. It's been said elsewhere, and this isn't a new thought, but coders in India are in huge demand, and the barrier to entry is very low. So many of them need to make a living, and with demand so high, software is easy money. It's like the dot-com bubble here, when people who had no business coding were able to make scads of money. My advice for anyone working on a project that's been off-shored is beware of the newbie programmers -- and you'll probably have some on your project. The Vendor will have some slick, talented people on their team who know what they're doing, but for every great programmer there's at least one dud.
