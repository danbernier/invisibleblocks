---
layout: post
title: Constructor Inheritance in C# and Ruby
type: post
published: true
status: publish
categories:
- Programming
tags:
- c#
- inheritance
- Ruby
author: Dan Bernier
date: 2008-06-30 17:01:15.000000000 -04:00
comments:
- author: Ben
  content: Ah, you finally updated it!  Way to go, Dan.
  date: '2008-07-14 08:35:04'
  author_email: bdowden@gmail.com
- author: shahbaz
  content: "It Will Print in C ,in B , in A\r\nBecause constructors are call in the
    reverse order \r\nad destructors are called in step by step"
  date: '2008-11-03 16:08:00'
  author_email: shahbazali_001@yahoo.com
- author: Dan Bernier
  content: '@shahbaz, since you mention destructors, I take it you mean the C# code
    at the top.  Unfortunately, though, you''re wrong -- the code prints "In A, In
    B, In C."  I''m also not sure what you mean by "reverse order".  I guess whether
    it''s reverse depends on how you think about it.  In any case, superclass constructors
    fire before subclass constructors.'
  date: '2008-11-03 17:00:21'
  author_email: danbernier@gmail.com
- author: demikaze
  content: "...\r\nclass B < A\r\n    def initialize\r\n        super\r\n        puts
    \"in B\"\r\n        super\r\n\r\n    end\r\nend\r\n...\r\n\r\nThis (super...super)
    works! :)"
  date: '2009-12-01 16:46:14'
  author_email: demikaze@gmail.com
- author: someone
  content: Not exactly a Ruby nut here, but OF COURSE what Ruby is doing is better
    than the C# way.  Automatically calling superclass methods is horrible, because
    the programmer has to remember an arbitrary rule, and because the subclass doesn't
    have control over when the superclass does its stuff.  Sometimes to want to pre-process
    the arguments before calling the superclass' constructor, and sometimes you want
    to diddle with the construction before returning.  If you have an automatic call,
    then your language is only going to let you do one of those things (which one,
    depends on the rule).  Too many real-life cases where that results in a pain in
    the ass.  Explicit superclass calls are the Right Thing.
  date: '2010-06-23 11:54:18'
  author_email: postmaster@invisibleblocks.wordpress.com
---

This morning: "Surprise!  Want to conduct a job interview?"  I've been here a little over 3 months, but um, sure!  "Great.  He's in the conference room right now."  Wow, we move quick.

So, without much time to gather my thoughts for good tech-y interview questions, I printed out the resume, and I winged it.  In the middle of the interview, I flipped over his resume, and scribbled out short-hand C# like this:

{% highlight csharp linenos %}
class A {
   public A() {
      Console.WriteLine("in A");
   }
}
class B : A {
   public B() {
      Console.WriteLine("in B");
   }
}
class C : B {
   public C() {
      Console.WriteLine("in C");
   }
}
new C();
{% endhighlight %}

I asked, "What does this print out?"  You know, see if he knows which order constructor inheritance goes in.  I wanted to hear, "in A, in B, in C", but not "in C, in B, in A".

I forget exactly what the candidate's answer was, but it stirred up a bit of discussion, because the three of us interviewing him disagreed on the answer:  one of us said it would only print "in C," because you need to stick `: base()` on the B and C constructors for the inheritance to work;  I agreed with the third interviewer, who said it would print "in A, in B, in C", because constructor inheritance is automatic (with no-arg constructors).  We fudged around it, laughed a bit, and the interview moved on.  (Update: [here's the answer](#update).)

Back at my desk, I had to try it out.  I didn't want to bother with a whole Visual Studio .sln and all that nonsense, so I tried it in Ruby:

{% highlight ruby linenos %}
class A
    def initialize
        puts "in A"
    end
end
class B < A
    def initialize
        puts "in B"
    end
end
class C < B
    def initialize
        puts "in C"
    end
end

C.new
{% endhighlight %}

And the output is..."in C"!  Huh?  That can't be right...I was _sure_ constructors were inherited automatically!  Then I realized, of course!  I'm working in Ruby, and you have to explicitly call superclass methods, constructors included:

{% highlight ruby linenos %}
class A
    def initialize
        super # <- call the superclass' constructor
        puts "in A"
    end
end
class B < A
    def initialize
        super # <- call the superclass' constructor
        puts "in B"
    end
end
class C < B
    def initialize
        super # <- call the superclass' constructor
        puts "in C"
    end
end

C.new
{% endhighlight %}

Stupid Ruby!  Did I find a case where C# actually works nicer than Ruby?  But then I realized, this also means Ruby lets you change the order of the constructor inheritance: you can go bottom-up, if you want, or even stranger:

{% highlight ruby linenos %}
class A
    def initialize
        super
        puts "in A"
    end
end
class B < A
    def initialize
        super
        puts "in B"
    end
end
class C < B
    def initialize
        puts "in C"
        super # <- call up the chain AFTER we're done
    end
end

C.new
{% endhighlight %}

That one prints out "in C, in A, in B".  The nice thing?  No rule to memorize, and more control.  The down-side?  More to type.  But given how compact Ruby already is, I think the added control is worth it here.  What do you think?

<a name="update" href=""></a>
(**Update:** I eventually _did_ fire up Visual Studio, and the code above printed "in A, in B, in C", without me typing out `: base()`.  C# inherits constructors automatically, and the superclass constructors run before subclass constructors.)
