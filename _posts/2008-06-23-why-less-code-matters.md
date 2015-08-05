---
layout: post
title: Why "Less Code" Matters
type: post
published: true
status: publish
categories:
- Programming
- Software Thinking
tags:
- abstraction
- refactoring
- semantic compression
author: Dan Bernier
date: 2008-06-23 22:22:33.000000000 -04:00
comments:
- author: lispy
  content: "Hey Daniel,\r\n\r\nI think Perl exemplifies what you're talking about
    here.  As a substitute for, say VB6 text manipulation on one hand... and grep/sed/awk/shell
    on the other, it really cuts out gobs of accidental complexity.\r\n\r\nYour OOP-only
    languages (Java/C#) certainly bring their own accidental complexity to the table
    whatever you're doing with them.  Their attempts to implement perlishness just
    seems clunky to me-- Perl's regex's are seamlessly integrated everywhere and you
    just say what you mean without having to fire up yet another object....\r\n\r\n(Also,
    where did Ralph Johnson say that?  Your link just goes to an Amazon page with
    no Raplh Johnson stuff on it....)"
  date: '2008-06-24 10:32:29'
  author_email: otherjeff@netzero.com
- author: Dan Bernier
  content: "Hey lispy,\r\n\r\nI've only done a touch of Perl (I'm more of a Ruby guy),
    but from what I've seen, you're right.  Like you said, having regexps, arrays,
    and hashes built-in is big.  And having non-clunky function literals is a big
    help, too.\r\n\r\nI originally found that Ralph Johnson quote in Martin Fowler's
    Refactoring, on page 56...it's the very last sentence on the page.  Here's the
    full paragraph:\r\n\r\n<blockquote>Early on I do refactoring like this on little
    details. As the code gets clearer, I find I can see things about the design that
    I could not see before. Had I not changed the code, I probably never would have
    seen these things, because I'm just not clever enough to visualize all this in
    my head. Ralph Johnson describes these early refactorings as wiping the dirt off
    a window so you can see beyond. When I'm studying code I find refactoring leads
    me to higher levels of understanding that otherwise I would miss.</blockquote>"
  date: '2008-06-24 13:54:40'
  author_email: danbernier@gmail.com
- author: Dan Bernier
  content: Here's the <a href="http://books.google.com/books?id=1MsETFPD3I0C&amp;pg=PA56&amp;lpg=PA56&amp;dq=%22Ralph+Johnson+describes+these+early+refactorings+as+wiping+the+dirt+off+a+window%22&amp;ots=pKM2n0PDeb&amp;sig=PTibYIScP-9BoqB0UaU2pJLaF5E&amp;hl=en&amp;sa=X&amp;oi=book_result&amp;resnum=2&amp;ct=result#PPA56,M1"
    rel="nofollow">Ralph Johnson quote on Google Books</a>.
  date: '2008-06-24 13:59:21'
  author_email: danbernier@gmail.com
---

> ...being able to do task X with 50 lines of code is preferable to needing 500 lines of code to do task X. Less code takes longer to write, but the real benefits are around maintenance: less code means less of a chance of bugs, less to keep in your head, less for someone else (or yourself 6 months later) to read through and learn, less to test, and less to modify when you change the rest of the system.
> - Alan Keefer, [Syntax Matters](http://guidewiredevelopment.wordpress.com/2008/04/29/syntax-matters/)

I'd like to expand on that.  I don't think it's clear how important "less code" is, or how harmful _more_ code is.  So let's take an example written in a [Blub-y](http://www.paulgraham.com/avg.html) language, and see how well we can refactor it.

(I know this post is kind of long, but it's mostly Blub code, and it should scan quickly.)

Let's make a sandwich.
<pre>routine makeSandwich
    look for the peanut butter in the cabinet
    if it's not there, look for it in the other cabinet
    put the peanut butter on the counter

    look for the jelly in the fridge
    if it's not there, look for it in the cabinet
    if it's not there, look for it in the other cabinet
    put the jelly on the counter

    find a napkin
    put the napkin on the counter

    find the bread in the bread drawer
    untie the bread bag
    take two pieces of bread from the bag
    close the bread bag
    put the bread back in the bread drawer
    put the two pieces of bread on the napkin

    find a butter knife
    put the butter knife on the napkin

    open the peanut butter jar
    stick the butter knife into the peanut butter jar
    with the butter knife, scoop out some peanut butter
    spread the peanut butter on one piece of bread
    close the peanut butter jar
    put the peanut butter back in the cabinet

    wipe the butter knife on the other piece of bread

    open the jelly jar
    stick the butter knife into the jelly jar
    with the butter knife, scoop out some jelly
    spread the jelly on one the other piece of bread
    close the jelly jar
    put the jelly back in the fridge

    put the knife in the sink</pre>

So much work!  No wonder I seldom cook.  Can we improve that at all?  Well, the "looking for in 2 cabinets" seems to be a pattern, so let's Extract Method:
<pre>routine lookForInTwoCabinets (lookFor)
    look for the lookFor in the cabinet
    if it's not there, look in the other cabinet
    return it

routine makeSandwich
    lookForInTwoCabinets (peanut butter)
    put the peanut butter on the counter

    look for the jelly in the fridge
    if it's not there, lookForInTwoCabinets(jelly)
    put the jelly on the counter
    ...</pre>

Can we move the "put it on the counter" inside `lookForInTwoCabinets`?  I don't know...it would work for the peanut butter, but what if we find the jelly in the fridge?  In that case, we wouldn't call `lookForInTwoCabinets(jelly)`, so we might never put the jelly on the counter.   Besides, the name doesn't really imply anything about what we do after we find the thing.  We should probably leave it outside.  Yeah, it's not so DRY, but let's move on.

That big block where we look for bread, we can't really compress it at all...but we _can_ extract it, just to wrap the whole sequence of steps up with a name.
<pre>...
routine getBread
    find the bread in the bread drawer
    untie the bread bag
    take two pieces of bread from the bag
    close the bread bag
    put the bread back in the bread drawer
    put the two pieces of bread on the napkin

routine makeSandwich
    ...
    find a napkin
    put the napkin on the counter

    getBread

    find a butter knife
    put the butter knife on the napkin
    ...</pre>

Ok, we're making progress.  What about spreading the peanut butter & jelly on the bread?  Can we extract another method?
<pre>routine spread (topping, breadSlice)
    open the topping jar
    stick the butter knife into the topping jar
    with the butter knife, scoop out some topping
    spread the topping on breadSlice
    close the topping jar
    put the topping back in the cabinet

routine makeSandwich
    ...
    find a butter knife
    put the butter knife on the napkin

    spread (peanut butter, one piece of bread)

    wipe the butter knife on the other piece of bread

    spread (jelly, the other piece of bread)

    put the knife in the sink</pre>

Great!  Except we just introduced a bug: after closing the topping jar,  `spread` always puts the topping back in the cabinet, and the jelly goes in the fridge (moldy jelly is a Bad Thing).  Introduce Parameter:
<pre>routine spread (topping, breadSlice, returnToppingTo)
    open the topping jar
    stick the butter knife into the topping jar
    with the butter knife, scoop out some topping
    spread the topping on breadSlice
    close the topping jar
    put the topping back in returnToppingTo

routine makeSandwich
    ...
    find a butter knife
    put the butter knife on the napkin

    spread (peanut butter, one piece of bread, the cabinet)

    wipe the butter knife on the other piece of bread

    spread (jelly, the other piece of bread, the fridge)

    put the knife in the sink</pre>

Ok, I think we're done.   (Does it make sense to send a "return topping to" parameter to a method that's just spreading?  Not now, we're almost ready to commit...)  Let's step back and admire our craft:
<pre>routine lookForInTwoCabinets (lookFor)
    look for the lookFor in the cabinet
    if it's not there, look in the other cabinet
    return it

routine getBread
    find the bread in the bread drawer
    untie the bread bag
    take two pieces of bread from the bag
    close the bread bag
    put the bread back in the bread drawer
    put the two pieces of bread on the napkin

routine spread (topping, breadSlice, returnToppingTo)
    open the topping jar
    stick the butter knife into the topping jar
    with the butter knife, scoop out some topping
    spread the topping on breadSlice
    close the topping jar
    put the topping back in returnToppingTo

routine makeSandwich
    lookForInTwoCabinets (peanut butter)
    put the peanut butter on the counter

    look for the jelly in the fridge
    if it's not there, lookForInTwoCabinets(jelly)
    put the jelly on the counter

    find a napkin
    put the napkin on the counter

    getBread

    find a butter knife
    put the butter knife on the napkin

    spread (peanut butter, one piece of bread, the cabinet)

    wipe the butter knife on the other piece of bread

    spread (jelly, the other piece of bread, the fridge)

    put the knife in the sink</pre>

31 lines down to...32 lines.  Ok, well, even if it's longer, is it _better? _ `makeSandwich` is shorter, that's good.  But it doesn't feel like we've really made the job any easier -- we moved stuff around, but it's still all there.  There's no [semantic compression](http://people.csail.mit.edu/gregs/ll1-discuss-archive-html/msg01552.html).  It's still [3 + 3 + 3 + 3 + 3 + 3, instead of 3 * 6](http://invisibleblocks.wordpress.com/2008/04/05/why-we-abstract-and-what-to-do-when-we-cant/).

What did we think about?   We had to ask ourselves whether to move "put it on the counter" into `lookForInTwoCabinets`.   The value of `getBread` is questionable.   We had the bug with `spread` putting the jelly in the cabinet, and we had to wonder about its "return topping to" parameter.  Every time we consider refactoring, we risk introducing a crappy abstraction that confuses, when it should clarify.   Every decision point, we have to think about it, and we might get it wrong.   But that's why they pay us the big bucks, right?   Software development is hard, after all!

No.   We're looking at [accidental complexity, not essential complexity](http://en.wikipedia.org/wiki/No_Silver_Bullet).  Here's the same code, in a higher-level language, that removes some of the accidental complexity:
<pre>put peanut butter on a piece of bread
put jelly on another piece of bread
stick the peanut butter to the jelly</pre>

Essential complexity is when you start thinking, why jelly?  Why not cinnamon and raisins with the peanut butter?  Or currants?  What _kind_ of bread?  Let's use multigrain.  Would peanut butter with jelly _and_ banana be overkill?  What to drink?  Essential complexity looks at the problem, not the solution.  Accidental complexity is when you say "I really want to do THIS but dammit, my language just won't let me."  Or, "Gosh, we have _so much code_ to move around, I can barely see what it does."  Or when you just can't figure out where to put that parameter, or method, or class.

**So what does this have to do with "less code"?**

This is why we say [YAGNI](http://c2.com/xp/YouArentGonnaNeedIt.html).  If you add that method on a hunch that it'll be helpful, you have more stuff to move around, more accidental complexity, more decisions to make about your housekeeping, all for a _speculative_ benefit.  It's like playing lotto - you pay up front, and if you're really lucky, you'll win.  But if you lose, you've wasted resources, and now you have something you need to throw away.

Each of the possible ways to code and refactor that sandwich code is pretty valid...any of them could be in our source control repository.  A new hire is going to have to read through whichever one we coded, and try to mentally get from there, to the 3-liner at the end, before he can really be effective.  Why don't we just _start_ him there?

Let's take that 3 + 3 + 3 + 3 + 3 + 3 example again.  What if we don't use multiplication?  We could still refactor it.  The first two threes are kind of together, let's group them:  6 + 3 + 3 + 3 + 3.  And the last one looks kind of bulky, so let's decompose it:  6 + 3 + 3 + 3 + 1 + 1 + 1.  Could we move some of the numericality from the middle 3 to an earlier one?  6 + 3 + 4 + 2 + 1 + 1 + 1.  Oh, and let's sort, so it's easier to find the numbers you want:  1 + 1 + 1 + 2 + 3 + 4 + 6.  There!  Is it immediately obvious to you that this is the same as 3 * 6?  Of course not.  Ralph Johnson calls refactoring "[wiping dirt off a window](http://www.amazon.com/Refactoring-Improving-Existing-Addison-Wesley-Technology/dp/0201485672)," and you just put more dirt on.
