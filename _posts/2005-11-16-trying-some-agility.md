---
layout: post
title: Trying some agility
type: post
published: true
status: publish
categories: []
tags:
- Job
author: Dan Bernier
date: 2005-11-16 19:45:00.000000000 -05:00
comments:
- author: Reginald Braithwaite
  content: Good luck, Dan! Let us know how it goes.
  date: '2005-11-21 16:53:00'
  url: http://www.blogger.com/profile/3914785
---

I had an interesting conversation with a co-worker recently. We got to discussing a small project we were on back in January '05, that basically involved creating a small dynamic questioner. You configure the interview by creating questions, and each possible answer to the question leads to either another question, or an outcome. We modelled the interview as a [directed acyclic graph](https://en.wikipedia.org/wiki/Directed_acyclic_graph) (I know, you already knew about DAGs -- the link is for the other readers). We built a test tool that traversed the DAG, and reported all possible paths. We even (this was pretty cool) built an importer that created interviews from [FreeMind](http://freemind.sourceforge.net/wiki/index.php/Main_Page) mind maps...basically made FreeMind our GUI. We did all this in about 3 weeks (Java and XSL, if anyone's wondering). We had fun, and both our management and our customers loved it. It's loads easier to change the questions now than it would've been if the questions were just hard-coded, the way everyone expected it to be done. I think we even beat the estimate for that approach.

Anyway. We realized the other day that our approach for that mini-project could be called agile. On the project, we tackled as much of the problem as we could understand, just trying to make things better. Dozens of special-case rules for which question is asked when? Let's make that generic, and configure the questions. Redundant branches in that hierarchical question tree? Let's optimize it into a DAG. Hard to write all that XML? Let's use FreeMind for its nodes-to-XML interface, and transform it. Hard to test all 30,000-odd paths through this mess? Automatic tester. Build a little, see a little further, build a little more.

Now, I'm on a much larger, higher-profile project: replace our hand-grown portal (pretty cheesy) with a commercial portal product. How we implement the portal product will impact a lot of future development, since a number of other teams will be building for the portal, and learning from or building on our work. [This is what I'm hearing, anyway.] No one on the project has any experience with this portal product (horray!). After spinning my wheels a bit, I realized the only way we could get anything done was to start building, and find our way as we go. We need experience with this tool, we need scabs on our knees from falling down with it. So our approach this time will be more agile -- more intentionally agile.

This makes my project manager a tad nervous, and with good reason, I think -- agile isn't what you'd call popular around the shop. Not that it's been proven as a bad idea, it's just that (I suspect) all these methods that emphasize coding and doing things without lots of up-front planning sound completely irresponsible to upper management. I think if I talked to some IT execs and said I had no concrete plan for implementing this portal product, they'd respond like my mom did when I said I had no concrete plan for getting through college.

But all that aside, we're doing it anyway.  It seems to me like the only real solution.  I was encouraged when my manager (an ex-architect) said he'd be nervous if we weren't doing it this way.  What most surprised me about all this, though, was how easy it was to get everyone to agree.  My PM is new to the company, my manager loves a good skunk-works project, the other developers on the project were interested -- like all the stars aligned, or something.  And to emphasize that effect, right after everyone agreed to it, I saw Raganwald's post [Just do it](http://weblog.raganwald.com/2005/10/just-do-it.html).
