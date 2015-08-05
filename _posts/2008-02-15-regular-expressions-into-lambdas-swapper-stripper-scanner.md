---
layout: post
title: 'Regular Expressions into lambdas: swapper, stripper, scanner'
type: post
published: true
status: publish
categories:
- Programming
tags:
- JavaScript
- regular expressions
- Ruby
author: Dan Bernier
date: 2008-02-15 20:59:28.000000000 -05:00
comments:
- author: Dan Bernier
  content: "Here's another obvious use...a matcher:\r\n\r\n```ruby\nclass Regexp\r\n
    \ def matcher\r\n    lambda { |s| s =~ (self) }\r\n  end\r\nend\r\n```"
  date: '2008-04-11 09:43:44'
  author_email: danbernier@gmail.com
---

Here's some light Friday fun...  When working in ruby with regular expressions on Arrays of Strings, I get so tired of doing this:

{% highlight ruby linenos %}
my_array.map! { |item|
    item.gsub(/delete this/, '')
}
{% endhighlight %}

Can't we just give the regex to the array, and let it figure it out?  How about this:

{% highlight ruby linenos %}
class Regexp
   def stripper
      lambda { |s| s.gsub(self, '') }
   end
end

my_array.map!(&/delete this/.stripper)
{% endhighlight %}

We can generalize it to use _any_ string as the replacement:

{% highlight ruby linenos %}
class Regexp
   def swapper(new_s)
      lambda { |s| s.gsub(self, new_s) }
   end

   def stripper
      swapper ''
   end
end

my_array.map!(&/delete this/.stripper)
my_array.map!(&/replace this/.swapper('with this'))
{% endhighlight %}

Which gets me thinking...what if we want to extract text by a regexp?

{% highlight ruby linenos %}
class Regexp
   def scanner
      lambda { |s| s.scan(self) }
   end
end

my_array.map(&/[find pattern]/.scanner)
{% endhighlight %}

What else can we do with regular expressions?

As a bonus, this translates nicely into JavaScript, too:

{% highlight js linenos %}
RegExp.prototype.swapper = function(new_s) {
   re = this
   return function(s) {
      return s.replace(re, new_s)
   }
}

RegExp.prototype.stripper = function() {
   return this.swapper('')
}

// Don't forget those closing parens...
my_array.map(/delete this/.stripper())
my_array.map(/replace this/.swapper('with this'))
{% endhighlight %}
