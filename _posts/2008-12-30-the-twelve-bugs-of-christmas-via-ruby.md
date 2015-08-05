---
layout: post
title: The Twelve Bugs of Christmas, via Ruby
type: post
published: true
status: publish
categories:
- Programming
tags: []
author: Dan Bernier
date: 2008-12-30 09:46:48.000000000 -05:00
---

Here's a little bit of post-Christmas fun, based on the [Twelve Days of Christmas](http://en.wikipedia.org/wiki/Twelve_Days_of_Christmas#In_song).

{% highlight ruby linenos %}
bugs = %{
     Tell them it's a feature
     Say it's not supported
     Change the documentation
     Blame it on the hardware
     Find a way around it
     Say they need an upgrade
     Reinstall the software
     Ask for a dump
     Run with the debugger
     Try to reproduce it
     Ask them how they did it and
     See if they can do it again.
}.strip.split("\n").map { |bug| bug.strip }.reverse

days = %w[first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth]

0.upto(11) do |day_num|
  puts "For the #{days[day_num]} bug of Christmas, my manager said to me"
  day_num.downto(0) do |bug_num|
    puts bugs[bug_num]
  end
  puts
end
{% endhighlight %}
