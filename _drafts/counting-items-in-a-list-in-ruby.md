---
layout: post
title: Counting Items in a List in Ruby
type: post
published: false
status: draft
categories: []
tags: []
author: Dan Bernier
---

Suppose you have a list of colors. You want to know how often each color appears in the list.

{% highlight ruby linenos %}
["grey", "grey", "tortie", "red", "grey", "black", "red", "black", ...]
{% endhighlight %}

How common is a black cat? How rare is a tortie?

If the data came from a table in a database, you could use `select color, count(id) from cats;` or, in Rails, `Cat.count(group: :color)`.

But in this case, you already have the data in memory. Maybe it came in from a CSV.

{% highlight ruby linenos %}
> colors = rows.map { |row| row['color'] }
=> ["grey", "grey", "tortie", "red", "grey", "black", "red", "black", ...]
> colors.size
=> 2645
> colors.uniq
=> ["grey", "tortie", "red", "black", "white"]
{% endhighlight %}

How do you count them up?

`Enumerable#group_by` gives us a Hash where the keys are the distinct colors, and the values are arrays of the colors: `{ "grey" => ["grey", "grey", "grey", "grey"...] ... }`. We can use `map` and `size` to finish the job:

{% highlight ruby linenos %}
> Hash[
    colors.group_by { |c| c }.map { |color, occurrances|
      [color, occurrances.size]
    }
  ]
=> { "grey" => 92,
     "tortie" => 752,
     "red" => 543,
     "white" => 329,
     "black" => 929 }
{% endhighlight %}

It'd be nice if this were part of the Enumerable module.

{% highlight ruby linenos %}
module Enumerable
  def count_by(&criteria)
    grouped = group_by(&criteria)
    counts = grouped.map { |item, items|
      [item, items.size]
    }
    Hash[counts]
  end
end

rows.count_by { |row| row['color'] }
{% endhighlight %}

And, as long as we're not running this as a one-off in a REPL, we could be more efficient, and actually accumulate a hash of counts.

At work, we've monkey-patched it in for now to try it out. We'll see how it goes.
