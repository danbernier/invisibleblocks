---
layout: post
title: 'Ruby Scrubbing JavaScript: Raise Those Curly Braces'
type: post
published: true
status: publish
categories:
- Productivity
- Programming
tags: []
author: Dan Bernier
date: 2013-06-06 09:54:32.000000000 -04:00
---

Of the Programmer Holy Wars, "curly braces on the same line, or the next line?" is not as vitriolic as emacs/vim or tabs/spaces, but it's up there.

(Personally, I don't care. I've done years with each style. You get used to it.)

In JavaScript, it's less of an issue, because, when you put curly braces on the next line, JavaScript will (sometimes) automatically insert semicolons into your code. It's well-documented and discussed, and understandable; here's [a question about it on stackoverflow](http://stackoverflow.com/questions/3641519/why-results-varies-upon-placement-of-curly-braces-in-javascript-code).

Yesterday I reviewed some old JavaScript (circa 2007) that [our web designer Daniel](http://www.lyften.com/) rehabilitated, and this concern came up. Rather than hunt around manually for dangling curly braces, I wrote some ruby to find and fix them.

{% highlight ruby linenos %}
# fix-js-curies.rb
ARGV.each do |filename|
  src = File.read(filename)

  # This multi-line regex looks for any { that
  # comes after a \n, and any tabs or spaces,
  # and replaces it with a space and a {.
  new_src = src.gsub(/\n[ \t]*\{/m, ' {')

  if src == new_src
    puts filename
  else
    puts "#{filename} fixed!"
    File.open(filename, 'w') do |f|
      f.puts new_src
    end
  end
end
{% endhighlight %}

You can pass it any .js files as command-line arguments:

{% highlight bash linenos %}
$ ruby fix-js-curlies.rb app/assets/*.js
{% endhighlight %}

Props to Daniel: when I ran my script, it didn't actually find any, because he got them all ahead of me.
