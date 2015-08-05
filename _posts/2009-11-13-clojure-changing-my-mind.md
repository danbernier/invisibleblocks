---
layout: post
title: Clojure Changing My Mind
type: post
published: true
status: publish
categories:
- Functional Programming
- Programming
tags:
- clojure
author: Dan Bernier
date: 2009-11-13 18:15:17.000000000 -05:00
comments:
- author: Alex Osborne
  content: "I kind of like this way:\r\n\r\n<pre>\r\n\r\n(defn saw-step [min max step]\r\n  (cycle
    (concat (range min max step)\r\n                 (range max min (- step)))))\r\n\r\n</pre>"
  date: '2009-11-14 00:40:21'
  author_email: ato@meshy.org
- author: Dan Bernier
  content: Oh, ok -- that's much nicer!  I hadn't tried giving (range) a negative
    step.  I tried (range max min), but got an empty list -- which makes sense, since
    the step defaults to 1.  If you add 1 to max, until it's greater than min, you'll
    get the empty list.  Thanks Alex!
  date: '2009-11-15 20:46:17'
  author_email: danbernier@gmail.com
- author: Dan Bernier
  content: "...and (concat seq1 seq2) is clearer than (into (vec seq1) seq2), also.
    \ Like I said, I'm still in flounder-around mode, I don't even know the seq library
    very well.  I'm going to start reading the source for the clojure core libs.  I've
    heard they're very good, and reading through all the functions, seeing how they
    work, and all their variations, should both teach me what's there, and show me
    some good clojure style."
  date: '2009-11-15 20:49:54'
  author_email: danbernier@gmail.com
- author: Rob Bazinet
  content: Dan, it's pretty cool you are working with Clojure, I am a fan but not
    good at it yet.  Are you using Clojure at work or for personal exploration?
  date: '2009-11-16 11:35:47'
  url: http://accidentaltechnologist.com
  author_email: rbazinet@gmail.com
- author: Dan Bernier
  content: For fun, really, especially with Processing.org.  My co-workers are aware
    of Clojure.net, but no one's looking at it.
  date: '2009-11-16 12:29:41'
  author_email: danbernier@gmail.com
---

As good as [Processing](http://processing.org) is, it's still java.  I've slowly been learning [clojure](http://clojure.org), and trying to use it with Processing, via [clj-processing](http://github.com/rosado/clj-processing). While [the clojure docs](http://clojure.org/Reference) and [the book](http://www.amazon.com/gp/product/1934356336?ie=UTF8&tag=invisblock-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=1934356336) are both good, I'm still in that flounder-around stage, trying out tiny experiments to understand how things work.

I wanted a function to make saw-step sequences: (1 2 3 2 1 2 3 2 ...).  You give it the low bound, the high bound, and the step-size.  For example:

* `(saw-step 1 4 1)` gives `(1 2 3 4 3 2 1 2 3 4 3 ...)`
* `(saw-step 0 15 5)` gives `(0 5 10 15 10 5 0 5 ...)`
* `(saw-step 0 5 2)` gives `(0 2 4 5 3 1 0 2 4 5 ...)`

I've coded this kind of thing up in ruby, javascript, or java a dozen times, though it's usually inside a loop, not returning a list.  Something like this:

{% highlight js linenos %}
var min = 3;
var max = 7;
var step = 2;

var n = min;
while(shouldContinue()) {
    doSomethingWith(n);
    n += step;
    if (n+step > max || n-step < min) {
        step *= -1;  // turn around
    }
}
{% endhighlight %}

My first try in clojure took a similar tack.  I never got it right, but it was something like this:

```clojure
(defn saw-step
  [min max step-size]
    (let [step (ref step-size)]
      (iterate
       (fn [x]
         (if (or ( min (- x @step)))
           (dosync (alter step -)))
         (+ @step x))
         min)))
```

It's a disaster -- the parentheses don't even match -- but you get the gist.  I was trying to cram the same imperative algorithm into clojure: keep some mutable state, add `step` to it, and when you reach the edges, mutate `step` to change direction.  I kept getting bugs where it would go one step beyond the edge, or it would start working its way back from one edge, only to turn around again, and bounce against the edge forever.

I gave up and went to bed, but a few days later, I had better luck.
```clojure
(defn saw-step
  [min max step]
     (cycle
      (into (vec (range min max step)) ; vec, so (into) adds to end
	    (for [x
		  (iterate #(- % step) max)
      :while (> x min)] x))))
```

The first not-entirely-wrong step I made was to try breaking the list of numbers I wanted into two parts: the going-up numbers, and the coming-down numbers.  (0 2 4 5 3 1) is just (0 2 4) + (5 3 1).  The `(range min max step)` part gives you the going-ups, and the `(for [x (iterate ...)` stuff is the going-downs, as a list comprehension.

(One mistake I made was trying `(range max min step)` for the going-downs, which yields an empty list; another was using `(iterate dec max)`, which never ends, because it keeps decrementing into the negatives.  I found my way out with the list comprehension, but I bet there's a better way.)

Once you have those two lists, you can use `into` to add each item from the second list to the first, giving you (0 2 4 5 3 1).  That goes into `cycle` for a lazy, infinite sequence.

The solution's not too bad: a saw-step is a cycle of the going-ups, followed by the going-downs.  The code looks about that way.

(It occurred to me after that I could always use a default step of 1, and pipe the result through a scaling map.  That would give me the bounds I wanted, with the extra benefit of evenly-spaced steps.  Maybe I'll remove `step` later.)

[Alan Perlis](http://www.cs.yale.edu/quotes.html) said, "A language that doesn't affect the way you think about programming, is not worth knowing."  He also said, "The only difference(!) between Shakespeare and you was the size of his idiom list - not the size of his vocabulary."  Clojure's changing my mind, a bit at a time.
