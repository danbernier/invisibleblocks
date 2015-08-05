---
layout: post
title: 'Ruby Facets: Symbol.to_proc, Class.to_proc'
type: post
published: true
status: publish
categories:
- Functional Programming
- Programming
- Ruby Facets Tour
tags:
- FacetsTour
- Ruby
- RubyFacets
author: Dan Bernier
date: 2008-03-28 12:52:57.000000000 -04:00
comments:
- author: Avdi
  content: "Just to be pedantic, Symbol#to_proc is not part of Ruby 1.8, which is
    still the most commonly used version.  Did you mean \"One pretty well-known idiom
    in *Rails*, and in Facets...\"?\r\n\r\nClass#to_proc does indeed look handy."
  date: '2008-03-29 01:26:44'
  url: http://avdi.org
  author_email: avdi@avdi.org
- author: Dan Bernier
  content: "Avdi, that's a good point, and you're 100% correct...I was being a bit
    loose with my language.  Maybe I should have said \"One pretty well-known idiom
    in Ruby, FROM Rails and Facets...\"\r\n\r\nI guess I think of Symbol.to_proc as
    a Ruby idiom, because:  it's useful in any Ruby code, it's easy to implement yourself
    w/o any libraries, it's built into both Rails and Facets, and it's part of Ruby
    1.9.\r\n\r\nBut for the record, to any others who might be confused: if you want
    to use Symbol.to_proc in Ruby 1.8, you need to require facets, or work in Rails,
    or implement Symbol.to_proc yourself.  Hint:\r\n\r\nclass Symbol\r\n  def to_proc\r\n
    \   Proc.new{|*args| args.shift.__send__(self, *args)}\r\n  end\r\nend\r\n# copied
    from Facets v2.3.0\r\n\r\nAvdi, thanks for keeping me honest."
  date: '2008-03-30 11:42:54'
  author_email: danbernier@gmail.com
- author: Nikos D.
  content: "<strong>Tiny (but maybe important) Rubinius tidbits...</strong>\n\nAs
    you play with a tool you progressively discover various small tidbits about it.
    I have a few in mind and I thought it would helpful to share them in case you
    encounter them and get this weird expression on your face of \"huh?\".\r\n1. The
    multiple ass..."
  date: '2008-04-19 13:11:49'
  url: http://nikos-d.blogspot.com/2008/04/tiny-but-maybe-important-rubinius.html
- author: Eliminating code duplication with metaprogramming « require ‘brain'
  content: "[...] if we (ab)use the Symbol#to_proc idiom (and forsake a little bit
    of readability), we can shorten it further [...]"
  date: '2008-06-05 07:23:55'
  url: http://szeryf.wordpress.com/2008/06/05/eliminating-code-duplication-with-metaprogramming/
---

One pretty well-know idiom in Ruby, and [Facets](http://facets.rubyforge.org/), is `Symbol.to_proc`.  It lets you turn these:

{% highlight ruby linenos %}
[1, 2, 3].map { |num| num.next }  #=> [2, 3, 4]

%w[alpha beta gamma].map { |word| word.upcase }
#=> ["ALPHA", "BETA", "GAMMA"]{% endhighlight %}
...into these:
{% highlight ruby linenos %}
[1, 2, 3].map(&:next)
%w[alpha beta gamma].map(&:upcase){% endhighlight %}
It's a nice little trick, though it's not to everyone's taste.  If you're already comfortable with `Symbol.to_proc`, you can skip down to the `Class.to_proc` section.  But if you're not, it's worth a minute of your attention to learn it.  Read on...

### How it's done


When a method takes a block, you can call yield, to run the block.
{% highlight ruby linenos %}
def with_a_block(a_param)
    yield
end
with_a_block('param') {
    puts 'in the block'
}{% endhighlight %}
Or, you can name the block as the last parameter to the method, and put an ampersand in front of it.  The ampersand makes ruby convert the block to a procedure, by calling `to_proc` on it.  (So any object with a `to_proc` method can work this way, if you want.)  This example works just like the last one:
{% highlight ruby linenos %}
def named_block(a_param, &blk)
    blk.call
end
named_block('my_param') {
    puts 'in the named block'
}{% endhighlight %}
Symbol's `to_proc` method creates a procedure that takes one argument, and sends the symbol to it.  Sending a symbol to an object is the same as calling a method on it:  `object.send(:method)` works the same as `object.method`.  In the earlier `upcase` example, each word is passed to a procedure that calls `upcase` on it, giving us a list of uppercased strings.
{% highlight ruby linenos %}
&:upcase
# becomes...
lambda { |obj|
    obj.send(:upcase)
}
# or...
lambda { |obj|
    obj.upcase
}{% endhighlight %}

### Class.to_proc


So `Symbol.to_proc` creates a function that takes an argument, and calls that method on it.  `Class.to_proc` creates a function that passes its argument to its constructor, yielding an instance of itself.  This is a welcome addition to the `to_proc` family.
{% highlight ruby linenos %}
require 'facets'

class Person
    def initialize(name)
        @name = name
    end
end
names = %w[mickey minney goofy]
characters = names.map(&Person)

puts characters.inspect

&Person
# becomes...
lambda { |obj|
    Person.new(obj)
}{% endhighlight %}

### Why it's nice


* It's fewer characters -- it [semantically compresses](http://people.csail.mit.edu/gregs/ll1-discuss-archive-html/msg01552.html) your code.
* It lets you think, _makes_ you think, on a higher level.  You think about operations on your data, rather than handling one item at a time.  It raises your level of thinking.
* It works with [first-class functions](http://weblog.raganwald.com/2007/01/closures-and-higher-order-functions.html), which are worth understanding.  They give you [new ways to elegantly solve some problems](http://blog.grayproductions.net/categories/higherorder_ruby) (well, new to some audiences).  They're not fringe anymore -- they've been in C# since v2.0.
