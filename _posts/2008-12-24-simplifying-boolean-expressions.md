---
layout: post
title: Simplifying Boolean Expressions
type: post
published: true
status: publish
categories:
- Programming
tags: []
author: Dan Bernier
date: 2008-12-24 12:43:25.000000000 -05:00
comments:
- author: Paco
  content: Don't forget that the |= &amp;= and ^= operators can be useful too.
  date: '2008-12-24 13:32:26'
  author_email: pacospam@gmail.com
excerpt: Many programmers can't simplify boolean expressions...or at least code like
  they can't.  Here are some basic rules for simplifying boolean expressions, and
  an example, with some pointers to more material on boolean algebra.
---

(Apologies if this material seems elementary, but I've found enough code to make me think it should be talked about.)

I found some C# today that looked kind of like this.

{% highlight csharp linenos %}
if (someCondition) {
    return true;
}
return false;
{% endhighlight %}

This code says the author missed some key points about booleans.  You can find it in almost any language.

Any code that fits into an _if_ or _while_ eventually becomes a boolean.  Using an _if_ to "return true, else false" is redundant -- just return the condition.  That code can be simplified down to this one-liner:

{% highlight csharp linenos %}
return someCondition;
{% endhighlight %}

The same goes for assigning a variable.  This:

{% highlight csharp linenos %}
bool result = false;
if (someCondition) {
    result = true;
}
{% endhighlight %}

...is the same as this:

{% highlight csharp linenos %}
bool result = someCondition;
{% endhighlight %}

(If you feel the longer version is clearer, as [some do](http://c2.com/cgi/wiki?ReturnBooleanEvaluations), I respectfully disagree with you, but that's a different point, and I'm not interested in debating preferences.  You can probably stop reading here, but thanks for stopping by.)

What if your boolean values are swapped?  You can invert your condition:

{% highlight csharp linenos %}
if (someCondition) {
    return false;
}
return true;

// is the same as:
return !someCondition;
{% endhighlight %}

As the nesting gets deeper, it gets hairier, but it can still be tamed:

{% highlight csharp linenos %}
if (condition1) {
    if (condition2) {
        return true;
    }
    return false;
}
return false;

// is basically:
return condition1 && condition2;
{% endhighlight %}

And...

{% highlight csharp linenos %}
if (condition1) {
    return true;
}
else if (condition2) {
   return true;
}
else {
   return false;
}

// is just:
return condition1 || condition2;
{% endhighlight %}

There are [many other ways to tame a wild boolean](http://cs.wellesley.edu/~cs111/spring00/lectures/boolean-simplification.html) -- follow that link, and check the first table.  It's like simplifying an algebraic equation: _x_+0 is always _x_, and _y_ && true is always _y_.

### An Example


Let's work through a contrived, yet nasty, example, to see how some of this works.

{% highlight js linenos %}
function contrivedYetNasty(hasYirmish, isNingle, amount) {
    var tooMuch = false;
    if (amount > 100) {
        tooMuch = true;
    }

    var foo = false;
    if (hasYirmish == false) {
        if (!!tooMuch) {
          foo = true;
        }
        else {
          foo = false;
        }
    }
    else {
        foo = true;
    }

    if (isNingle == true) {
        if (foo == false) {
            return false;
        }
        else {
            return true;
        }
    }
    else {
        return false;
    }
}
{% endhighlight %}

I have no idea what this does, but it's nasty (which is often the situation with legacy code).  These handy unit tests tell us how it behaves:

{% highlight js linenos %}
assert(false, contrivedYetNasty(false, false, 0))
assert(true,  contrivedYetNasty(false, true, 110))
assert(false, contrivedYetNasty(true, false, 0))
assert(true,  contrivedYetNasty(true, true, 110))  

assert(false, contrivedYetNasty(false, false, 0))
assert(true,  contrivedYetNasty(false, true, 110))
assert(false, contrivedYetNasty(true, false, 0))
assert(true,  contrivedYetNasty(true, true, 110))
{% endhighlight %}

First, let's tackle `tooMuch`.  It's false, but if `amount` is over 100, then it's true.  If it always has the same truthiness as `amount > 100`, then it's _equivalent_ to `amount > 100`.  Let's write it that way.

{% highlight js linenos %}
var tooMuch = amount > 100;
{% endhighlight %}

The tests pass.

Next, let's look inside the `if (hasYirmish == false)` block, lines 9 - 14 in the original.  First, `!!tooMuch` is a double-negative: the first `!` cancels out the second.  We can just say `if (tooMuch)`.  "If `tooMuch` is true, `foo` is true; else (if `tooMuch` is false), `foo` is false."  So `foo` is the same as `tooMuch`, and we can rewrite the block like this:

{% highlight js linenos %}
if (hasYirmish == false) {
    foo = tooMuch;
}
else {
    foo = true;
}
{% endhighlight %}

Tests pass.

"If `hasYirmish` is false, `foo` is `tooMuch`; else, `foo` is true."  This is just like a boolean _OR_ expression.  When `a || b` is evaluated, if `a` is true, the expression evaluates to true, without even checking `b`; but if `a` is false, then the expression evaluates to the value of `b`.  And that's exactly what we want here.  That block just becomes:

{% highlight js linenos %}
var foo = hasYirmish || tooMuch;
{% endhighlight %}

The tests still pass.  So far, we're down to this:

{% highlight js linenos %}
function contrivedYetNasty(hasYirmish, isNingle, amount) {
    var tooMuch = amount > 100;
    var foo = hasYirmish || tooMuch;

    if (isNingle == true) {
        if (foo == false) {
            return false;
        }
        else {
            return true;
        }
    }
    else {
        return false;
    }
}
{% endhighlight %}

Not bad!

Inside the `isNingle == false` block, on lines 6 - 11 above, we have: "if `foo` is false, return false; else (if it's true), return true."  Again, we just want to return the value of `foo`.  Let's re-write it that way, test it (they pass), and take a look at the `isNingle == true` block.

{% highlight js linenos %}
if (isNingle == true) {
    return foo;
}
else {
    return false;
}
{% endhighlight %}

Now, we have a similar situation to when we introduced the _OR_ expression, but it's slightly different.  If `isNingle` is false, the whole thing is false; if it's true, then it's the value of `foo`.  Sounds like an _AND_ expression.  Let's try it.

{% highlight js linenos %}
return isNingle && foo;
{% endhighlight %}

The tests still pass.  Let's step back and look at our progress:

{% highlight js linenos %}
function contrivedYetNasty(hasYirmish, isNingle, amount) {
    var tooMuch = amount > 100;
    var foo = hasYirmish || tooMuch;
    return isNingle && foo;
}
{% endhighlight %}

From 31 lines down to five, and it's actually readable.  We can in-line those variables, and it gets even clearer:

{% highlight js linenos %}
function contrivedYetNasty(hasYirmish, isNingle, amount) {
    return isNingle && (hasYirmish || amount > 100);
}
{% endhighlight %}

It returns true "if isNingle, and either it hasYirmish, or amount is over 100."  Much better.

### Beyond the Basics


Once you're comfortable with simplifying boolean expressions, there's a number of rules you can employ to refactor nastier boolean expressions.  Most of them are easy to remember, and can be easily illustrated in real-life terms.  Meet [DeMorgan](http://en.wikipedia.org/wiki/De_Morgan%27s_laws):

* `!(a || b) == !a && !b`.  "It's not red or green" is the same as "It's not red, and it's not green."
* `!(a && b) == !a || !b`.  "I'm not rich and handsome" is true if I'm not rich, OR if I'm not handsome.  (Or if I'm neither.)

These rules are part of a larger topic called [Boolean algebra](http://en.wikipedia.org/wiki/Boolean_algebra_(introduction)), which is useful for [simplifying circuits](http://www.allaboutcircuits.com/vol_4/chpt_7/5.html), and (of course) programming.  At my university, Boolean algebra was taught in Discrete Math, which was required for CS majors.  Maybe programmers without a CS degree have a harder time with booleans because they missed this class, but the good news is, it's easy enough to [pick up](http://en.wikipedia.org/wiki/Boolean_algebra_(introduction)).
