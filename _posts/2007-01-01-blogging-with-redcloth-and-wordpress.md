---
layout: post
title: Blogging with RedCloth and WordPress
type: post
published: true
status: publish
categories: []
tags:
- Ruby
author: Dan Bernier
date: 2007-01-01 12:28:12.000000000 -05:00
---

I don't particularly like WordPress' built-in editor.  I don't like typing <span class="caps">HTML</span> by hand, especially since I've found Textism.  I tried using Ruby's RedCloth gem to convert my blog drafts from [Writeboards](http://www.writeboard.com/) into <span class="caps">HTML</span> that I can stuff into WordPress, but it replaces each double-newline with `</p><p>`, which makes it hard as hell to read.

So I threw together this ever-so-tiny ruby script that first splits the text on double-newlines, and then pumps each paragraph to RedCloth.  It's nothing special, but after two non-techie posts, I thought I'd balance it out with at least _something_.  The Dvorak post, and this one, were written with this script.

{% highlight ruby linenos %}require 'redcloth'

post = %{
your post text goes here
}

puts post.split("\\n\\n").map { |p|
    RedCloth.new(p).to_html + "\\n\\n"
}
{% endhighlight %}
