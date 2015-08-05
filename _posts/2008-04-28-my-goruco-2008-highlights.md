---
layout: post
title: My GoRuCo 2008 highlights
type: post
published: true
status: publish
categories: []
tags:
- goruco2008
- Ruby
author: Dan Bernier
date: 2008-04-28 18:36:27.000000000 -04:00
---

[Aaron](http://rubydoes.net/) and I had a great time at [GoRuCo 2008](http://2008.goruco.com/) last Saturday.  Here are my highlights.

**Bryan Helmkamp, Story-Driven Development**

[Bryan Helmkamp's](http://www.brynary.com/) talk on SDD ([slides](http://www.brynary.com/uploads/Story_Driven_Development.pdf), 1.6 MB PDF) reminded me of what [Scott Hanselman](http://www.hanselman.com) calls "spec documents with teeth."  If I get it right, as you develop user stories, you use a standard format, and code parses your story file, and ties the text directly to functional tests you write.  The stories aren't executable themselves, but it brings them closer together.

Each story has a name, a description, and scenarios; the descriptions follow the format "As a ..., I want to ..., so that ...":
<pre>As a headhunter looking for Rails developers
I want to search for CVs with 8 years experience
So that I can make an exorbitant commission</pre>

The scenarios are different ways that story might play out.  Each scenario has a description, which follows the format "Given ... When ... Then ...":

Scenario: Enough experience.
_Given_ **a CV with 9 years of Rails experience**
_When_ **I search for qualified Rails candidates**
_Then_ **I should find the CV**
_And_ **I should realize the candidate is full of shit**

Then code reads your story files, and uses the text following the keywords to connect to executable functional tests you write:

{% highlight ruby linenos %}
steps_for :cvs do
  Given "a CV with 3 years of Rails experience" do
    @cv = Developer.create!(:first_name => "Joe",
      :last_name => "Developer", :rails_exp => 3,
      :gender => "Male")
  end
end

steps_for :cvs do
  When "I search for qualified Rails candidates" do
    @results = Developer.find_qualified(8)
  end
end
{% endhighlight %}

The code that actually performs the test is just ActiveRecord.  If you want to test the UI, there's a DSL called Webrat that simulates the browser.  It seems to live halfway between Watir and mechanize, and it doesn't do javascript.  It looks like this:

{% highlight ruby linenos %}
steps_for :cvs_with_ui do
  Given "a CV with 3 years of Rails experience" do
    visits new_developer_path
    fills_in "First name", :with => "Joe"
    fills_in "Last name", :with => "Developer"
    selects "4", :from => "Rails Experience"
    chooses "Male"
    clicks_button "Create"
  end
end
{% endhighlight %}

I'm curious about `chooses "Male"` -- I don't see how it connects that text with the drop-down it's supposed to change, unless it looks at values for all drop-downs on the page.  He gave a nice breakdown of the differences between Webrat and Selenium, and how SDD fits into an Agile team.

**Giles Bowkett, Archaeopteryx**

That's ARK-ee-OP-ter-ix, or Arcx for short.  Made by Giles (soft 'g') BOH-ket, or boh-KET, I wasn't exactly sure which.  It is, in [his words](http://gilesbowkett.blogspot.com/2008/02/archaeopteryx-ruby-midi-generator.html), "a Ruby MIDI generator," and "a system for auto-generating, self-modifying music."

Giles had hands-down the most entertaining talk of the day.  Instead of poring through each token of the code, he compared taking VC money (or "weasel-brained muppet fucker" money) to being an artist with a patron -- as the programmer/artist, your job is to make stuff that makes your VC/patron look good.  He showed some of Leonardo da Vinci's [designs](http://www.vebjorn-sand.com/thebridge.htm) that weren't constructed until recently; that it took this long, he said, was a failure of da Vinci's time.  Similarly, staying within a VC's idea of what's possible is a failure of wasted passion and energy. Start-ups are so cheap now, you can ignore VCs -- so follow your passion, create an open-source-enriched ecosystem around it, and make money by servicing the niche market you made.  If your startup is great, you can say "my career is this thing"; if it's mediocre, you can say "my career _includes_ this thing".  Just remember that good artists ship.

Which brings us to Arcx, Giles' idea for a crowd-interfacing, automatic music machine.  Someone asked whether it was wise to name a new project after an extinct species, and Giles got all clever: archaeopteryx was either the last dinosaur or the first bird, and the project could be either the last DJ tool, or the first automatic music machine, played by the crowd.  He played us some samples, and talked through the code just a bit, dropping hits about the [CLOS](http://en.wikipedia.org/wiki/CLOS)-like structure of his code.  As fun as his talk was, I would've liked to hear more music, and more about the lambda-passing and CLOS stuff.

He also pointed out the most interesting ruby book I'd never heard <span class="asinTitle">of, [<span>Practical Ruby Projects: Ideas for the Eclectic Programmer</span>](http://www.amazon.com/Practical-Ruby-Projects-Programmer-Professionals/dp/159059911X/)</span>.

**Chris Wanstrath, ParseTree**

Out of all the talks, Chris' was the one I'll be using first.  Lispers say "code is data," and I can see why that's so powerful -- but I haven't really tried it yet.  ParseTree brings some of that coolness to ruby:

{% highlight ruby linenos %}
require 'ruby2ruby'

def to_ruby(&blk)
   blk.to_ruby
end

puts to_ruby { 1 + 1 }
puts to_ruby { |i| i == 42 }

def to_sexp(&blk)
   blk.to_sexp
end

puts to_sexp { 1 + 1 }
puts to_sexp { |i| i == 42 }
{% endhighlight %}

...which produces:

{% highlight ruby linenos %}
proc {
  (1 + 1)
}
proc { |i|
  (i == 42)
}
[:proc, nil, [:call,
   [:lit, 1], :+, [:array, [:lit, 1]]]]
[:proc, [:dasgn_curr, :i], [:call,
   [:dvar, :i], :==, [:array, [:lit, 42]]]]
{% endhighlight %}

Most of the examples he gave generated query syntax in a ruby-idiomatic way: say you have an ORM, and you want users to search for users like this:

{% highlight ruby linenos %}
old_cat_people = Users.select do |u|
   u.favorite_pet == "cat" && u.age > 100
end
{% endhighlight %}

How could you turn that into SQL?  Call `to_sexp` on the query block (that's "to [S-expression](http://en.wikipedia.org/wiki/S-expression)"), and evaluate the [abstract syntax tree](http://en.wikipedia.org/wiki/Abstract_syntax_tree) it returns. Like this:

{% highlight ruby linenos %}
class Users
   def self.select(&query)
      query = query.to_sexp

      # Now, query looks like this:
      # [:proc,
      #    [:dasgn_curr, :u],
      #       [:and,
      #          [:call,
      #             [:call, [:dvar, :u], :favorite_pet],
      #             :==,
      #             [:array, [:str, "cat"]]],
      #          [:call,
      #             [:call, [:dvar, :u], :age],
      #             :>,
      #             [:array, [:lit, 100]]]]]

      # Time to evaluate the AST.
   end
end
{% endhighlight %}

Admittedly, it's not _that_ trivial, but that's the gist of it -- and I think the gem helps you with this.  (Cue the smug Lispers: this stuff is natural in Lisp, the way passing [<span style="text-decoration:line-through;">anonymous functions</span> blocks](http://eli.thegreenplace.net/2006/04/18/understanding-ruby-blocks-procs-and-methods/) is in ruby.)

But here's the interesting thing: we're on our way to building .Net's LINQ right into ruby.  Remember, it stands for **L**anguage **In**tegrated **Q**uery.  LINQ is a big deal for .Net folks, because it's handy.  Microsoft put a lot of work into it, and it still needs its own new syntax.  I think that's a pretty clear example of the power of being able to see your own AST, and code off it.

**Ryan Davis, Hurting Code for Fun and Profit**

[Ryan](http://blog.zenspider.com/)'s talk was nominally about using tools like [Heckle](http://ruby.sadi.st/Heckle.html) and [Flog](http://ruby.sadi.st/Flog.html) to beat the evil out of code, but my favorite part was his introspection-driven development.  I _know_ I'll want to refer others to his slides and audio throughout my career.

Some of his tips for improving as a programmer:

* Read.  1 technical book a month.  Sites like c2.com -- get close to the experts.
* Focus.  Only a few smart blogs: not zillions, not flame-prone.  (Flame-retardant blogs?)
* Grow.  Learn 1 new language a year.  Learn things outside of programming.
* Learn from the [pottery challenge story](http://c2.com/cgi/wiki?PotteryChallenge) in [Art & Fear](http://c2.com/cgi/wiki?ArtAndFear): practice, a lot.

Ryan is also a fellow Dvorak typist, and pretty emphatic about it.

**Johnson**

[Johnson](http://tenderlovemaking.com/2008/04/23/take-it-to-the-limit-one-more-time/) is a ruby gem that executes JavaScript code.  (It's a successor to [RKelly](http://rubyforge.org/projects/rkelly/), which did the same thing.)  I don't know why I think this is so cool.  Most people agreed the main use case for something like this is testing, but it seems to me there might be neater tricks to play.  We'll see how I feel after playing with it for a while.

**GoRuCo 2009?**

I'm definitely going next year -- see you there.
