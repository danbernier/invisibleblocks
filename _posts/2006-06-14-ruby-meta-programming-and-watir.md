---
layout: post
title: Ruby, Meta-programming, and Watir
type: post
published: true
status: publish
categories:
- Meta-programming
tags:
- Ruby
author: Dan Bernier
date: 2006-06-14 12:08:00.000000000 -04:00
comments:
- author: Bret Pettichord
  content: |-
    You should take a look at Watir 1.5. It's still in development, but it includes most of the features that you talk about here. And we'd love to have your help with the rest.

    Bret
  date: '2006-06-21 15:17:00'
  url: http://www.pettichord.com
- author: Dan Bernier
  content: Bret, glad to hear these features are getting into Watir 1.5!  I'll check
    it out, and I'd be glad to help out on the project.
  date: '2006-06-22 21:03:00'
  url: http://www.blogger.com/profile/6051054
- author: Emptiness
  content: "Oddly enough, I've been working in Ruby for almost a year now, using the
    obj.send() you describe for OLE embedding... but I never quite grasped the \"meta\"
    part of the meta-programming that was going on.  This despite the best efforts
    of several local Ruby enthusiasts.  (OK, I'm QA, not Dev...)\r\n\r\nFor whatever
    reason, I've had an ah-ha moment reading your comments on the searchable_tags.\r\n\r\nNow
    I'll have to gem install watir just to read the source.  Thanks much for whatever
    combination of words made it happen!"
  date: '2006-08-04 20:25:51'
  url: http://emptiness.mtness.com/
  author_email: ryan.maki@gmail.com
- author: Dan Bernier
  content: "Emptiness, glad I could help.  I had the same kind of thing with OO JavaScript
    -- I was using basic JavaScript, kludging together objects only when I really
    had to.  Once I started reading about functions as first-class members of the
    language, it clicked for me.\r\n\r\nThat's great that you're involved with the
    local Ruby scene.  I keep wanting to go visit the one near me...for some reason,
    physically chatting with people makes it so much easier for me to pick things
    up."
  date: '2006-08-08 21:34:58'
  author_email: danbernier@gmail.com
- author: James
  content: So, it would be interesting for you to comment on what it would take for
    folks at your old job to embrace Ruby...
  date: '2006-09-07 07:17:07'
  url: http://duckdown.blogspot.com
  author_email: james@architectbook.com
- author: Dan Bernier
  content: "James, that could be a whole post on its own!  You could be sneaky, or
    up-front about it.\r\n\r\nSome sneaky things that might work:\r\n\r\n1. Use Rails
    for rapid prototyping.  Share the prototype w/ the customers.  Then, once it's
    pretty solid, explain why you have to re-write it in Java.\r\n2. A skunk-works
    Rails project that's important enough to stay around and influence other apps,
    but not important enough to get you fired.\r\n\r\nIf you wanted to be more up-front,
    you could replace those super-complicated build batch scripts with Ruby...it'd
    be MUCH more flexible.  I can expound, if you like...\r\n\r\nWhy, are you trying
    to start a Ruby revolution there?  ;-)"
  date: '2006-09-14 20:09:27'
  author_email: danbernier@gmail.com
- author: Stefan Storakers
  content: "&gt;&gt;I still need to crack the metaclass = (class "
  date: '2006-10-16 11:54:17'
  author_email: storakers@gmail.com
- author: Stefan Storakers
  content: "&gt;&gt;I still need to crack the metaclass = (class  \\"
  date: '2006-10-16 11:56:18'
  author_email: storakers@gmail.com
- author: Stefan Storakers
  content: "A third time then:\r\n\"why..\" has written more about meat programming:\r\nhttp://whytheluckystiff.net/articles/seeingMetaclassesClearly.html"
  date: '2006-10-16 11:58:41'
  author_email: storakers@gmail.com
- author: Dan Bernier
  content: "Stefan,\r\n\r\nThanks for the _why link.  I've read it before, but it
    doesn't have the kind of \"what the hell is going on here?\" answers I'm looking
    for.\r\n\r\nOla Bini has a nice post about the Ruby Singleton class at http://ola-bini.blogspot.com/2006/09/ruby-singleton-class.html
    -- that was much more helpful to me.\r\n\r\nThe thing that initially confused
    me is that the GoF Singleton is (I think) a substantially different concept than
    the Ruby Singleton.  Ola lays it out pretty well, and explains the class &lt;&lt;
    self thing.  I'm still thinking it over, though, and I'm considering doing a write-up
    here, once it clicks for me."
  date: '2006-10-16 13:16:38'
  author_email: danbernier@gmail.com
- author: iccar
  content: "my \"assert\" can not work,  when i run it, it return \"nil is not true\".
    \r\n\r\nit does not either due to the expression error, or declare error"
  date: '2006-12-26 03:43:53'
  author_email: zhkjsjchrl@126.com
- author: Dan Bernier
  content: "iccar,\r\n\r\nI'm assuming you mean assert from Ruby's <code>Test::Unit::TestCase</code>.
    \ From what little you said, it sounds like you're calling <code>assert(true,
    someObj)</code>, and <code>someObj</code> is nil.\r\n\r\nAlso, for future reference,
    you might want to read <a href=\"http://catb.org/~esr/faqs/smart-questions.html\"
    rel=\"nofollow\">How To Ask Questions The Smart Way</a>.  It'll help you get more
    useful answers to your questions."
  date: '2006-12-26 08:41:43'
  author_email: danbernier@gmail.com
- author: Murugesan
  content: Hi I need some help in programing watir for accessing the headers in internet
    explorer, something like to play with the tools bar in the hedaer. Can any one
    help me on that.
  date: '2008-08-20 10:23:57'
  author_email: murugesan67@yahoo.com
- author: Val
  content: Actually came here to learn about *args, &amp;proc and got a good explanation
    about other things as well. Thanks.
  date: '2009-02-20 16:07:36'
  url: http://www.talentjr.com
  author_email: val.hoffman@gmail.com
---

### WATIR – Web App Testing In Ruby


I've been playing with [Watir](http://wtr.rubyforge.org) recently (thanks for the tip, Ken!), since the folks at my new job have (ahem) no real QA team or process.  Watir lets you create and drive an Internet Explorer browser with Ruby (via the Win32 API library), so you       can script (and save, and frequently run) a whole suite of regression tests.  It's a great library—it's easy, clean, immediately rewarding, lots of fun, and implemented fairly simply.  Let's   use it to search Google for 'Watir':
{% highlight ruby linenos %}
require 'watir'
ie = Watir::IE.new  # launch a new IE browser
ie.goto("http://www.google.com")   # send it to Google

# Get the query input (the text field named "q"),
# and set it to "Watir"
ie.text_field(:name, "q").set("Watir")

# Get the search button (whose value, or text, matches the
# Regexp /search/), and click it
ie.button(:value, /search/i).click

# Find the link that includes "web application testing",
# and click it
ie.link(:text, /web application testing/i).click{% endhighlight %}
I did that all from memory, and made only two mistakes (I forgot the Regexps should be case-insensitive, and I looked for the "Search" button by :label instead of :value).  Go ahead—install ruby, run `gem install watir` (what's [gem](http://www.rubygems.org/read/chapter/1)?), and try it out.

Watir makes it easy to find any HTML element on the page, if it has a name, id, title, or value...but it _doesn't_ let you search by CSS class, which I consider a significant omission (plenty of generated HTML has consistent style names, but generated IDs).  Looking at the source, I think the authors assumed you would be only looking for one element (`ie.text_field(:name, "q")`), or all of a given kind of element (`ie.divs`).

Also, suppose you grabbed that paragraph about avocados, and now want the second link _inside_ that paragraph—`ie.p(:name, 'avocados').links(:index, 2)` _doesn't work_.  If the HTML elements you want have no id or name, the ability to traverse the DOM hierarchy is pretty important.  This also is a problem for me.

So I set about trying to improve Watir, to see if I could add this functionality.  Along the way, I decided to write my own wrapper around IE's DOM interface (exposed through Ruby's WIN32OLE object), and I'll try to re-write the DOM parts of Watir using it.  If it goes well, I'll submit it to the Watir team, but even if it doesn't, I'm learning a _lot_ about Ruby, and really starting to like it.  Call me a fanboy.

Here, I'm writing about the prizes I find along the way—things I'm learning, the neat approaches, or things that confused me at first.  It's aimed at someone who (hey, just like me!) has learned enough Ruby to do the basics, but wants more information on the parts of Ruby that aren't found in C-based, OO languages.  If you stop reading here, you've already picked up a great tip—go download [Watir](http://wtr.rubyforge.org/).  The curious rest of you, let's proceed...

### Delegation Made Trivial


{% highlight ruby linenos %}class Node
    # Auto-wrap the @ole_node
    def method_missing(method_id)
        @ole_node.send(method_id.id2name)
    end
end{% endhighlight %}
Watir hands out the OLE Document object, and the Node class (and its subclasses) wraps it, adding some functionality and OO pleasantness...but there are times we'd like to access the WIN32OLE's methods.  We could expose the OLE through an accessor method, but what we really want is to talk to the Node like it's the OLE.  Here's the part I like: instead of writing a hundred lines of delegator methods, we implement `method_missing`.  If a Node is sent a message it doesn't understand (a call to a method it doesn't implement), it just forwards the message to its WIN32OLE.

To do this, we override Object's method_missing method—it's a hook for just this situation.  We're passed the name of the missing method, and we can use the `object.send("method_name")` syntax for calling methods.  My example is really simple—_every_ method of WIN32OLE is exposed through Node, with the same name.  To restrict it, I'll probably add an Array of methods I want to expose, and only delegate `if wrapped_methods.include? method_name`.  If I want to get fancy, I'll use a Hash to map the method names, so `node.tag` delegates to `@ole_node.tagName`.

This trick, I think, is possible because Ruby is [dynamically typed](http://en.wikipedia.org/wiki/Dynamic_typing).  Ruby's willingness to send any message to any object is what makes this work.

### Meta-programming, and Then Some


{% highlight ruby linenos %}searchable_tags = %w[a p div span input table]

searchable_tags.each { |tag|
    code = <<METHOD_TEMPLATE
        def #{tag}s (*args, &proc)
            proc ||= make_filter(args)
            self.find_all { |n|
                n.tagName.upcase == "#{tag.upcase}" and proc.call(n)
            }
        end
METHOD_TEMPLATE
    module_eval(code)
}{% endhighlight %}
This is maybe a bit a dense...I'll explain first.

### Let's Just Find the Divs


I like Watir's style of searching for elements: `ie.div(:name, "header")` returns the div named 'header', and `ie.divs` returns all divs.  I decided to copy this, but make it a bit more general:  both versions (div and divs) should accept multiple filter parameters, so you can search by zero, one, or more attributes.  The singular version (div) should return the first match, the plural (divs) should return all matches.  For example:
{% highlight ruby linenos %}doc.div  # the first div
doc.div(:class, "blue_text") # the first div whose class is "blue_text"
doc.divs  # all divs
doc.divs(:class, "blue_text") # all divs whose class is "blue_text"

# all divs whose class is "blue_text", and whose title contains 'porpoise'
doc.divs(:class, "blue_text", :title, /porpoise/){% endhighlight %}
And just for [fun](http://invisibleblocks.wordpress.com/2006/01/18/hacking-the-browsers-dom-for-fun/), let's let people pass in their own filter blocks:
{% highlight ruby linenos %}doc.divs { |div|
    div.hasChildNodes
}{% endhighlight %}
The code for the divs method will look like this:
{% highlight ruby linenos %}def divs (*args, &proc)
    proc ||= make_filter(args)

    # Find all sub-nodes for which this block evaluates to 'true'
    self.find_all { |n|
        n.tagName.upcase == "div".upcase and proc.call(n)
    }
end{% endhighlight %}

For those new to Ruby, `*args` wraps all the method's parameters (arguments) in an array, so you can accept variable lists of them...it's how the method supports calls like `doc.divs(:class, "blue_text", :title, /porpoise/)`.  Also, if the method was called with a block, instead of calling it via `yield`, we can treat it as a variable by putting `&proc` in the method definition, and run it later via `proc.call`.

Speaking of that proc...if a block was passed, we'll use that, but if we got a list of filter parameters, we want to make a filter proc out of them (via `make_filter(args)`).  Enter Ruby's `||=` shortcut: `x ||= y` is the same as `x = x || y`.  If x is non-null, then y doesn't have to be checked, so `x || y` evaluates to the value of x.  If x is null, then `x || y` evaluates to the value of y.  It's a nice idiom for setting optional parameters to default values:  "if a value was passed, use it, but otherwise, use this default."  Here, `proc ||= make_filter(args)` sets proc either to the block that was passed, or to the proc that `make_filter(args)` returns.  From there, it's simple: find all elements where the tag is "DIV", and the filter procedure returns true.

### Generating Other Finder Methods


Now that's fine for divs, but we want to search for _lots_ of elements this way!  I don't want copy-paste versions of that method for span, a, p, img, table, and the rest of them...what a mess.  Instead, I'll write Ruby code to generate them for me, from a template.  Let's work from the inside out.

`module_eval(code)` takes a string of Ruby code, and evaluates it in the context of the current module.  In other words, if you pass in code that defines a method, you can then execute that method for the module.  Here, we'll use it to add methods to the Element class.

But who wants to cram a bunch of code onto one line, in a string variable?  Let's use Ruby's multi-line string:
{% highlight ruby linenos %}code = <<METHOD_TEMPLATE
    def #{tag}s (*args, &proc)
        proc ||= make_filter(args)
        self.find_all { |n|
            n.tagName.upcase == "#{tag.upcase}" and proc.call(n)
        }
    end
METHOD_TEMPLATE{% endhighlight %}
Everything between `<<METHOD_TEMPLATE` and `METHOD_TEMPLATE` is interpreted as a string, and stored in the code variable (the names "code" and "METHOD_TEMPLATE" can be whatever you want—they're not specific to generating methods).Sharp readers will notice that that string won't evaluate without a variable named 'tag' in scope, so let's add that:
{% highlight ruby linenos %}searchable_tags = %w[a p div span input table]

searchable_tags.each { |tag|
    code = <<METHOD_TEMPLATE
        def #{tag}s (*args, &proc)
            proc ||= make_filter(args)
            self.find_all { |n|
                n.tagName.upcase == "#{tag.upcase}" and proc.call(n)
            }
        end
METHOD_TEMPLATE
    module_eval(code)
}{% endhighlight %}
This shows off Ruby's nice `%w[ ... ]` short-cut for declaring an array of strings.
{% highlight ruby linenos %}
# Normal syntax
searchable_tags = ["a", "p", "div", "span", "input", "table"]

# %w cleans things up!
searchable_tags = %w[a p div span input table]{% endhighlight %}
Once you're used to it, the code is much clearer.  Thanks to Greg Brown and his [Nuby Gems column](http://www.oreillynet.com/ruby/blog/2006/06/nubygems_simple_array_definiti_1.html) for shedding the light.

### Meta-programming Wrap Up


Specifically from this example, I've learned:

* Meta-programming is like a mini [run-time code generator](http://en.wikipedia.org/wiki/Code_generator) built right into Ruby, and it'll save you lots of typing—it's great for keeping your code light.  Remember: module_eval affects classes, instance_eval affects objects.
* For meta-programming, those multi-line strings make a nice template mechanism.  Just remember:  the end label _must_ come right after a newline—no leading whitespace for indenting.  That stumped me for a bit.
* Ruby's ||= is handy—just remember that `a ||= b` means `a = a || b`.  If a is null, then a evaluates to false, so a is assigned the value of b.

If you want to read more about meta-programming, I'd suggest [A Little Ruby, a Lot of Objects](http://www.visibleworkings.com/little-ruby/), even though it's only partly about meta-programming.  [Dwemthy's Array](http://poignantguide.net/dwemthy/) is fun (and deranged), but I found it hard to see the meta-programming through the other stuff.  I'm currently chewing on [these](http://www.whytheluckystiff.net/articles/seeingMetaclassesClearly.html) [bits](http://www.32768.com/bill/weblog/2005/08/15/selectively_marshal-a-little-ruby-metaprogramming/).  I still need to crack the `metaclass = (class < self; self; end)` nut that I keep reading about...any advice?

### One Last Thing—On-line Documentation


As much as I'm coming to really like the [pickaxe](http://www.amazon.com/o/asin/0974514055), these [Ruby API docs](http://ruby.outertrack.com/), made with [RAnnotate](http://rannotate.rubyforge.org/), are really handy.  As we start to really invest in Watir, I'll probably set this up for us locally.
