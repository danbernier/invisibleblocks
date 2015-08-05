---
layout: post
title: Hartford Ruby Brigade starts with a tour of Ruby Facets
type: post
published: true
status: publish
categories:
- Programming
- Ruby Facets Tour
tags:
- FacetsTour
- Hartford.rb
- Ruby
- RubyFacets
author: Dan Bernier
date: 2008-03-17 22:36:24.000000000 -04:00
---

As [Rob Bazinet has said](http://rbazinet.wordpress.com/2008/03/15/first-meeting-of-the-hartford-ruby-brigade/), the [Hartford Ruby Brigade](http://groups.google.com/group/hartford-ruby-brigade) is having its first meeting on March 24.  You can get all the details from his post.  Come join us!  There's even a book raffle.

I'll be giving the first presentation, a tour of [Ruby Facets](http://facets.rubyforge.org/).  Facets is a pretty huge library (even after they moved some really neat parts into [their](http://blow.rubyforge.org/) [own](http://stick.rubyforge.org/) [projects](http://english.rubyforge.org/)), and it's crazy to think we could cover it all in one night.  I'll quickly touch on the simple features, just to let you know they're there, and I'll spend more time with some of the interesting parts.  If you're stuck, it's a good chance Facets has what you need; the trick is knowing it's there, and where to look -- I want to point out enough of Facets to help you with that.

I'll also start a [Tour of Facets](http://invisibleblocks.wordpress.com/tag/FacetsTour) series here, starting with this post.  I'm aiming for two to four posts a month, and will cover everything in the presentation, and then some.  So, on with the tour...

**_compare_on_ and _equate_on_**

Remember the first time you saw `attr_reader` and `attr_writer`?  These tiny helpers got me excited about ruby, not just because they meant less typing and DRY-er code, but because they meant _I_ could make helpers to generate methods, too, if only I could think of a reason to do it.

Facets has a great example of why you'd want to do that: `compare_on` and `equate_on`.

Most ruby programmers know you can make your objects sortable by defining `<=>`, the spaceship method, on them.  Typically, you wind up delegating to some attribute:

{% highlight ruby linenos %}
class Person
   attr_reader :fname, :lname
   def initialize(fname, lname)
      @fname, @lname = fname, lname
   end
   def <=>(person)
      @lname.<=>(person.lname)
   end
end{% endhighlight %}
Facets adds `compare_on`, which generates the spaceship method for you, based on that attribute.  Not only that, but you can `compare_on` multiple fields, and it handles the hairy logic for you automatically:
{% highlight ruby linenos %}
require 'facets/compare_on'

class Person
   attr_reader :fname, :lname
   def initialize(fname, lname)
      @fname, @lname = fname, lname
   end
   compare_on :lname, :fname
end

people = []
people.push Person.new('Adam', 'Smith')
people.push Person.new('John', 'Adams')

people.sort #=> John Adams, Adam Smith{% endhighlight %}
Correctly implementing the spaceship operator isn't too hard, but object equality gets tricky in any language.  Facets helps you here by implementing ruby's main three equality methods for you: `==`, `eql?`, and `hash`.
{% highlight ruby linenos %}
require 'facets/compare_on'

class Person
   attr_reader :fname, :lname
   def initialize(fname, lname)
      @fname, @lname = fname, lname
   end
   equate_on :lname, :fname
end

a_pres = Person.new('John', 'Adams')
another_pres = Person.new('John', 'Adams')
[a_pres].include?(another_pres) #=> true{% endhighlight %}
Again, you can equate on multiple attributes (`fname` and `lname`), and it handles all the details for you. Hope to see you at the Hartford Ruby Brigade!
