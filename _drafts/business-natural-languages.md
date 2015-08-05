---
layout: post
title: Business Natural Languages
type: post
published: false
status: draft
categories:
- Meta-programming
- Software Thinking
tags:
- Ruby
author: Dan Bernier
---

Jay Fields[link] talked[link] about Business Natural Languages (BNLs) at GoRuCo 2007[link].  He showed how his ruby code turned English-y business rules into more ruby code, and ran it.  From `compensate $3000 for each deal closed in the past 30 days` into real running ruby, by way of regular expressions and swapping text.  The prize is, a business person can "code" these rules on his own, so maintenance costs drop, and new rules are in place quicker.

People doubted his approach, saying that business people will mess up, type in the wrong text, think they can say anything to the computer.  He said we should build for them a language workbench (with syntax checks), make a test environment, and set up workflows and processes to be safe.  People still doubted, and said "show us this language workbench," but it was time for the next talk.

Jay's talk hit snags, and we could talk about them, but I think there's a bigger idea here: let the user control the parts he cares about.

## What do we care about?


We all "know" how some programs work.  To bold my text, I click the "B";  that's a rule we can imagine, code lurking behind the button, waiting to run.  It's one part of the word processor that we care about, along with "Save", and such.  We care about it, because bold text and saved files are things we care about.  We _don't_ care about buffers, window layouts, file locking, or events handling.  Well-done software moves the user close to the parts he cares about, so he can control them, and keeps the other parts off.  [This is why well-done software seems like it should be easy to write...we imagine the parts we want, don't think of the rest, and then ask the poor coders why it takes so long.]

"Things", or nouns -- files, people, text, numbers -- are easy to show on a computer, and much software lets us control them.  Verbs and rules mean there are nouns, changing around, in time.  Verbs and rules are hard to show, so fewer programs let us control them.  We can CRUD[link] our nouns, but rarely our actions.  Macros and scripts are about as close as we get, and those belong to "computer guys".

Jay showed us one way to move rules close to the user, but there are other ways, too.

## Give us our verbs!


Examples:
FIT - Framework for Integrated Test.  Let users specify tests, as HTML.
Excel - mathematical formulas, operating on cells.
HIG's interviewer -- rules between objects expressed as mind-map.

## Into tinkerable software


 [link]

We coders may tend to lump software into two kinds -- the stuff we write, and the stuff we use -- and I think we view them very differently.  Software we use is atomic,

Jay [says](http://bnl.jayfields.com/04_damp.html), "If _software can be understood and altered by subject matter experts_ the business can be more responsive to change."  [Emphasis added.]

http://bnl.jayfields.com/04_damp.html
http://www.brynary.com/2007/4/21/goruco-talk-business-natural-language
http://goruco.com/speakers/
