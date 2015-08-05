---
layout: post
title: A Faster, Cheaper Fibonacci Definition
type: post
published: true
status: publish
categories:
- Programming
tags:
- fibonacci
- Ruby
author: Dan Bernier
date: 2008-03-22 09:43:47.000000000 -04:00
comments:
- author: AkitaOnRails
  content: 'We had a similar discussion a while back here: http://www.mysoftparade.com/blog/ruby-19-doesnt-smoke-python-away/
    and we came out with a hash based implementation of Fibonacci in Ruby and Java:
    here http://pastie.caboo.se/123814 and here http://pastie.caboo.se/123847'
  date: '2008-03-23 14:30:50'
  url: http://www.akitaonrails.com
  author_email: fabioakita@gmail.com
- author: Dan Bernier
  content: "AkitaOnRails,\r\n\r\nThose hash-based implementations use memoization
    nicely, though from what I saw, they still all use the standard Fibonacci definition.
    \ If you know of anyone who's seen this other version, I'd love to read more about
    it.\r\n\r\nIt's too bad that in the Python-v-Ruby discussion, no one mentioned
    that the Python generator generates the Fibs in -ascending- order (a linear, iterative
    operation), but the others calculate any Fibonacci number (a tree-based recursive
    operation).  It's like comparing a weekly allowance to a yearly salary."
  date: '2008-03-24 11:40:33'
  author_email: danbernier@gmail.com
- author: Dan Bernier
  content: "Update: if you're interested, you might check this out: http://www.mcs.surrey.ac.uk/Personal/R.Knott/Fibonacci/fibmaths.html\r\n\r\nIt
    talks about some similar patterns in the Fibonacci sequence."
  date: '2008-03-30 11:52:59'
  author_email: danbernier@gmail.com
- author: Robert 'Groby' Blum
  content: Or just go to <a href="http://en.wikipedia.org/wiki/Fibonacci_number" rel="nofollow">Wikipedia's
    Fibonacci Entry</a> which covers the <a href="http://en.wikipedia.org/wiki/Fibonacci_number#Identity_for_doubling_n"
    rel="nofollow">identity you found</a> as well as the <a href="http://en.wikipedia.org/wiki/Fibonacci_number#Computation_by_rounding"
    rel="nofollow">closed form</a>. (If you really *need* fast fib computation, that
    would be the choice)
  date: '2008-04-04 14:39:10'
  url: http://www.robertblum.com
  author_email: r.blum@gmx.net
- author: Sammy Larbi
  content: I think that's known as the matrix method of computing Fibonacci.  You
    could avoid most of the computation altogether with fib(n) = (n+1)*n/2 ... if
    I remember correctly, anyway.
  date: '2008-04-04 15:27:37'
  url: http://www.codeodor.com
  author_email: sam@codeodor.com
- author: Sammy Larbi
  content: Excellent that you derived it, by the way!
  date: '2008-04-04 15:29:03'
  url: http://www.codeodor.com
  author_email: sam@codeodor.com
- author: Dan Bernier
  content: "Robert and Sammy, thank you!  I knew this had to be old news.  Maybe I
    should've read the Wikipedia page, instead of goofing with all those substitutions.
    \ :-)\r\n\r\nI love the point made there that performance is more influenced by
    your platform's handling of really long numbers, since the Fibs get so big so
    fast."
  date: '2008-04-04 16:45:11'
  author_email: danbernier@gmail.com
- author: 'Update « lambda.oasis :: cpoucet -> content'
  content: "[...] fact I've been busy explains the silence on my blog. But here, in
    the spirit of A Faster Fibonacci here is a quick Haskell version. I will leave
    the explanation for the other blog post. Basically [...]"
  date: '2009-03-13 17:27:56'
  url: http://cpoucet.wordpress.com/2008/04/07/update/
---

The [Fibonacci sequence](http://en.wikipedia.org/wiki/Fibonacci_number) is one of the best-known number sequences:
<ol>
<li>1</li>
<li>1</li>
<li>2</li>
<li>3</li>
<li>5</li>
<li>8</li>
<li>13</li>
<li>21...</li>
</ol>

Each Fibonacci number above 1 is defined as the sum of the previous two Fibonacci numbers:

F(0) = 0
F(1) = 1
F(n) = F(n-1) + F(n-2)

Just for fun, here's another way to specify the Fibonacci sequence.  It takes fewer calculations, especially for large numbers.  The math is basic algebra substitutions.  This could be old news -- if you've seen this before, I'd love to hear from you.

#### Deriving the new Fibonacci definition


Before we begin, let's notate F(n) as Fn, and F(n-1) as Fn<sub>1</sub> -- it'll make everything tidier.

That Fn<sub>1</sub> + Fn<sub>2</sub> part, to me, always begged for substitution.  Fn<sub>1</sub> should equal Fn<sub>2</sub> + Fn<sub>3</sub>, right?  What if we re-write Fn in terms of Fn<sub>1</sub>'s definition?  What might that lead to?

Fn = Fn<sub>1</sub> + Fn<sub>2</sub>
Fn<sub>1</sub> = Fn<sub>2</sub> + Fn<sub>3</sub>
Fn = Fn<sub>2</sub> + Fn<sub>2</sub> + Fn<sub>3</sub>
Fn = 2Fn<sub>2</sub> + Fn<sub>3</sub>, as long as n > 2.

Pretty basic: substitute the definition for Fn<sub>1</sub> back into the definition for Fn, and simplify.  We can keep going:

Fn<sub>2</sub> = Fn<sub>3</sub> + Fn<sub>4</sub>
Fn = 2Fn<sub>2</sub> + Fn<sub>3</sub>, from above
Fn = (2Fn<sub>3</sub> + 2Fn<sub>4</sub>) + Fn<sub>3</sub>
Fn = 3Fn<sub>3</sub> + 2Fn<sub>4</sub>, for n > 3

...and then:

Fn<sub>3</sub> = Fn<sub>4</sub> + Fn<sub>5</sub>
Fn = (3Fn<sub>4</sub> + 3Fn<sub>5</sub>) + 2Fn<sub>4</sub>
Fn = 5Fn<sub>4</sub> + 3Fn<sub>5</sub>, for n > 4

...and again:

Fn<sub>4</sub> = Fn<sub>5</sub> + Fn<sub>6</sub>
Fn = (5Fn<sub>5</sub> + 5Fn<sub>6</sub>) + 3Fn<sub>5</sub>
Fn = 8Fn<sub>5</sub> + 5Fn<sub>6</sub>, for n > 5

...just one more time:

Fn<sub>5</sub> = Fn<sub>6</sub> + Fn<sub>7</sub>
Fn = 8Fn<sub>6</sub> + 8Fn<sub>7</sub> + 5Fn<sub>6</sub>
Fn = 13Fn<sub>6</sub> + 8Fn<sub>7</sub>, for n > 6

See the pattern?  Look at the coefficients:

Fn =  **2**Fn<sub>2</sub> + **1**Fn<sub>3</sub>, for n > **2**
Fn =  **3**Fn<sub>3</sub> + **2**Fn<sub>4</sub>, for n > **3**
Fn =  **5**Fn<sub>4</sub> + **3**Fn<sub>5</sub>, for n > **4**
Fn =  **8**Fn<sub>5</sub> + **5**Fn<sub>6</sub>, for n > **5**
Fn = **13**Fn<sub>6</sub> + **8**Fn<sub>7</sub>, for n > **6**

They're the Fibonacci sequence starting up.  Do the math, and you'll see that the next few steps follow along.  What if we replace the coefficients with their Fibonacci indexes?  If F(6) = 8 and F(7) = 13, we can rewrite 13Fn<sub>6</sub> + 8Fn<sub>7</sub> as F(7) Fn<sub>6</sub> + F(6) Fn<sub>7</sub>.  Let's carry that out:

Fn = F(3) Fn<sub>2</sub> + F(2) Fn<sub>3</sub>, for n > 2
Fn = F(4) Fn<sub>3</sub> + F(3) Fn<sub>4</sub>, for n > 3
Fn = F(5) Fn<sub>4</sub> + F(4) Fn<sub>5</sub>, for n > 4
Fn = F(6) Fn<sub>5</sub> + F(5) Fn<sub>6</sub>, for n > 5
Fn = F(7) Fn<sub>6</sub> + F(6) Fn<sub>7</sub>, for n > 6

Let's quickly verify this.  We know from the original definition that F(10) = 55, so let's see whether these new versions agree.  (I'll only test the first and last versions, to save space, but you can verify as many as you like.)

F(10) = 55 = F(3) Fn<sub>2</sub> + F(2) Fn<sub>3</sub>
F(10) = 55 = F(3) F(8) + F(2) F(7)
F(10) = 55 = 2 * 21 + 1 * 13

F(10) = 55 = F(7) Fn<sub>6</sub> + F(6) Fn<sub>7</sub>
F(10) = 55 = F(7) F(4) + F(6) F(3)
F(10) = 55 = 13 * 3 + 8 * 2

They both pass.  More generally:

Fn = F(x) Fn<sub>y</sub> + F(y) Fn<sub>x</sub>, for n > x, and y = x - 1

It's not terribly wordier than the original definition, Fn = Fn<sub>1</sub> + Fn<sub>2</sub>, for n > 2.

#### Putting this to use


A nice property of this new version is that it lets us skip some steps.  If we're calculating F(1000) with the traditional definition, we have to calculate each Fibonacci along the way; but now, we can set x = 500, and skip down to the neighborhood of F(500):

F(1000) = F(500) * F(501) + F(499) * F(500)

We can continue to skip down to about n/2, decreasing the amount of calculations we need to do.

Just for fun, I implemented both `fib_orig` and `fib_new` in ruby: [here's the file]({{ site.baseurl }}/assets/2008/03/new_fibonacci_tests.rb).  I [memoized](http://en.wikipedia.org/wiki/Memoization) the methods, for two reasons:
<ol>
<li>It's clearly much faster, and it's simple to do.</li>
<li>It lets us see exactly which Fibonacci numbers were calculated.</li>
</ol>

I put the two methods in a test case, with four test methods.

The first test ensures that the new equation matches the old.  Unfortunately, I could only reach 6000 with the `fib_orig`, before I ran out of stack space.

The second test benchmarks the two versions.  It reports the memo array size (6000 for `fib_orig`, as expected, and 40 for `fib_new` -- 99.3% fewer calculations).

When `fib_orig` ran out of stack space so quickly, I wondered how far I could take the new version (which should recurse many fewer times).  So in the third test, I benchmarked it with progressively bigger numbers.  It starts to slow down around the million<sup>th</sup> Fibonacci number: it completes in about 12 seconds on my machine.  I suspect it's spending the extra time array-seeking at that point, since the array gets pretty sparse -- the last few non-null array indexes are: 125001 249999 250000 250001 499999 500000 500001 1000000.  Maybe I'll try a hash...

The fourth test is a bit of extra-credit, and a sanity check.  Fn / F(n+1) approaches the [golden ratio](http://en.wikipedia.org/wiki/Golden_ratio), 1.61803398874..., as N approaches infinity.  So I calculated F(1401) / F(1400) with `fib_new`, and it's accurate to 15 decimal points, rounding the last one, which seems to be the limit of precision on my WinXP machine.  I tried using higher Fibonacci numbers, but was warned that I was exceeding the range of ruby's floating point numbers.  Here's the output of that test:
<pre> actual golden ratio: 1.6180339887498948482
approx. golden ratio: 1.618033988749895
precision-level test: 0.333333333333333</pre>

So it seems the new approach is correct, faster, uses less space, and is still pretty elegant. Who knows whether this will ever come in handy, but at least it was fun to do.

F(n) = F(x) F(n-y) + F(y) F(n-x), for n > x, and y = x - 1
