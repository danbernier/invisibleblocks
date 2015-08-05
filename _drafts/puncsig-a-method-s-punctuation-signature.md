---
layout: post
title: 'puncsig: A Method''s Punctuation Signature'
type: post
published: false
status: draft
categories:
- Programming
- puncsig
tags:
- Ruby
author: Dan Bernier
---

A while ago, I hacked together some quick rake tasks to generate punctuation signatures, to help me peer into the SeeClickFix code base. Punctuation Signatures, inspired by Ward Cunningham's [Signature Survey](http://c2.com/doc/SignatureSurvey/), aren't hard science, and they won't magically show you all a code base's weak spots, but they're a fun way to explore.

Basically, puncsig takes a class like this:

{% highlight ruby linenos %}
class Foo
  def wham
    puts "wham!"
  end
  def bar(n)
    n.times { |i| puts "Hello, #{i}!" }
  end
end
{% endhighlight %}

...and produces a report like this: TODO actually generate that report
<pre>
foo.rb:
  bar:  .{||",#{}!"}
  wham: "!"
</pre>

Notice that the wham method's signature is shorter, so it appears last, even though its source is first in the file: this helps you zero in on longer methods.
