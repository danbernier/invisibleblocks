---
layout: post
title: Randomness in Unit Tests
type: post
published: false
status: draft
categories:
- Programming
- Software Thinking
tags: []
author: Dan Bernier
---

I think I'll leave this here as a reminder to myself of the thought process I went through.

Suppose you want to unit this method:

{% highlight ruby linenos %}
class Door
  def status
    return :open if open?
    if locked? :locked : :unlocked
  end
end
{% endhighlight %}

Just modeling a door: it can be open or closed, and locked or unlocked, but if it's open, it can't be locked.  (Assume `open?` is defined, etc.)  So, if the door is open, it'll return `:open` regardless of whether it's locked.  We could unit test it like this:

{% highlight ruby linenos %}
def test_status
  assert_equal(:open, Door.new(:open, :unlocked))
end
{% endhighlight %}

Or, if we're more ambitious:

{% highlight ruby linenos %}
def test_status
  assert_equal(:open, Door.new(:open, :unlocked))
  assert_equal(:open, Door.new(:open, :locked))
end
{% endhighlight %}

It's nice to test with both `:unlocked` and `:locked`, because the tests indicate what we said before:  if it's open, it'll return `:open` regardless of whether it's locked.

It'd be nice if we could make that indifference part of the unit tests, without having to manually write each test.

Aside: if :locked or :unlocked is really irrelevant to Door's constructor, then it shouldn't BE on the constructor like that.  It should only be passable if the 1st param is :open.  If you find yourself facing these kinds of questions, maybe it's a design smell.

Bottom line: if you're gonna do the randomness thing, you'll have to list out all the values, so it knows what to pick from.  Instead of saying "pick ONE of these," just say "for EACH of these."  If you can't put them in an array, that's a different problem.
