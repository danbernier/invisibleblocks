---
layout: post
title: Calling Methods On the Function Class
type: post
published: false
status: draft
categories:
- Functional Programming
- Programming
tags: []
author: Dan Bernier
---

Blog post idea, about functional programming and ruby and JavaScript.
Functions are objects, if you call messages on them, which lets you
define functions on function literal. You can do this and functional
programming languages. But it's different, because you pass a function
literal to function. What patterns does this allow?

Blog post idea, talking about functional programming and Ruby and
JavaScript. Functions are objects which means that you can define
methods on the function class or on the Proc class. And then you can
call those methods on function literals. You can do stuff like this in
functional programming languages, but instead of calling the method on
the function literal, you're passing the function literal to some
other function.

Some examples. Java script cycle. No that's wrong, RubyRobot, the RAM
module, the acting thing that you did. Also JavaScript, report
previews - delay - at software impression.

Credit to Oliver Steele
link to Dave Thomas' thing on Fibers?

--------------------------------------------------------------

In Ruby and JavaScript, functions are objects.  In Ruby, they're instances of the Proc class; in JavaScript, their prototype is Function.  Like any other object, they can have methods.

It can be weird, at first, writing methods for functions.  (Like, aren't they the same thing, kinda?)  But once you have the idea, you can do some pretty neat things with it.

To get started, consider a greeting function.

{% highlight ruby linenos %}
# ruby
greeting = lambda { puts "Hola, capitan!" }
greeting.call()   #-> prints the greeting
{% endhighlight %}
{% highlight js linenos %}
// javascript
var greeting = function() { print("Hola, capitan!") }
greeting()
{% endhighlight %}

Now what if el capitan has a rough night, and only every other crew member is brave enough to greet him?  We want greeting to do its thing only half the time.  Simple enough:

{% highlight ruby linenos %}
# ruby
i = 0
greeting = lambda do
   puts "Hola, capitan!" if i % 2 == 0
   i += 1
end
4.times { greeting.call }  #-> only greets him twice
{% endhighlight %}
{% highlight js linenos %}
// javascript
i = 0
var greeting = function() {
   if (i % 2 == 0)
      print("Hola, capitan!")
   i += 1
}
greeting()  //-> greets him
greeting()  //-> stays quiet
{% endhighlight %}

It's not horrible, but the "every other time" is tangled up with the "greet".  Let's make a method that takes our function, and returns _another_ function, one that calls our original function every other time it's called.

{% highlight ruby linenos %}
# ruby
def every_other_time
   i = 0
   lambda do
      yield if i % 2 == 0
      i += 1
   end
end
greeting = every_other_time { puts "Hola, capitan!" }
4.times { greeting.call }  #-> still greets him only twice!
{% endhighlight %}
{% highlight js linenos %}
// javascript
function everyOtherTime(theThingToDo) {
   var i = 0
   return function() {
      if (i % 2 == 0)
         theThingToDo()
      i += 1
   }
}
var greeting = everyOtherTime(function() { print("Hola, capitan!") })
{% endhighlight %}

everyOtherTime is a method that takes a function (theThingToDo), and returns a new function.  This new function will call theThingToDo only half the time.  Lambdas and functions are [closures](http://en.wikipedia.org/wiki/Closure_(computer_science)), so we can pack the counter variable, i, into a method, and each function instance returned by the method will track its own counter.

### Enter the Monkeypatch


Now this isn't too bad.  It's a little weird that everyOtherTime is out there in the middle of nowhere, though.  Let's go one controversial step further, and add it right into the Function prototype/Proc class.  This is [monkey patching](http://en.wikipedia.org/wiki/Monkey_patch), and a bit dangerous, but we're just exploring.

{% highlight ruby linenos %}
# ruby
class Proc
   def every_other_time
      i = 0
      the_thing_to_do = self
      lambda do
         the_thing_to_do.call if i % 2 == 0
         i += 1
      end
   end
end
greeting = lambda { puts "Hola, capitan!" }.every_other_time
{% endhighlight %}
{% highlight js linenos %}
// javascript
Function.prototype.everyOtherTime = function() {
   var i = 0
   var theThingToDo = this
   return function() {
      if (i % 2 == 0)
         theThingToDo()
      i += 1
   }
}
var greeting = function() { print("Hola, capitan!") }.every_other_time()
{% endhighlight %}

The general pattern of this technique is:
<ol>
<li>A method defined on Function or Proc, that
</li>
<li>names a reference to itself (the thing to do), and
</li>
<li>returns a function that closes over the named reference.
</li>
<li>That new function will change the way the thing to do is called, and do some stuff before and/or after it.  It might even _not_ call the thing to do.
</li>
</ol>

#### Aside: JavaScript versus Ruby for passing function parameters


I think monkey patching the Function prototype in JavaScript makes it much nicer, because JavaScript's syntax for function literals is not so hot.  The Ruby version picked up an extra token, because Ruby has the block syntax, which is basically a shortcut for passing a function literal to a method.  On the other hand, JavaScript makes it much nicer to pass around functions as variables:

{% highlight ruby linenos %}
# ruby
greetElCapitan = lambda { puts "Hola, capitan!" }
greeting = everyOtherTime(&greetElCapitan)
{% endhighlight %}
{% highlight js linenos %}
// javascript
var greetElCapitan = function() { print("Hola, capitan!") }
var greeting = everyOtherTime(greetElCapitan)
{% endhighlight %}

Why the ampersand in Ruby?  Ruby follows the design philosophy of making common things easy to do.  Matz felt that passing an anonymous function to a method was so important, he added the block syntax to make it easy to do, and sure enough, this style of programming is classic Ruby.  But a [block isn't quite a Proc](http://eli.thegreenplace.net/2006/04/18/understanding-ruby-blocks-procs-and-methods/):  it's it's own syntactic element, and it gets turned into a Proc, on the way into the method.  To pass a Proc to a method that expects a block, you have to prepend it with the ampersand.  (This is the secret mojo behind the famous Symbol.to_proc trick.)

THOUGHT:  MAYBE, INSTEAD OF BEATING EL CAPITAN TO DEATH, TRY SOME OTHER EXAMPLES?  LIKE, USEFUL ONES.  YOU CAN COMPARE & CONTRAST DIFFERENT STYLES WITH THEM, INSTEAD OF USING THIS SAME ONE OVER & OVER.

A more useful example is "memoization":http://osteele.com/archives/2006/04/javascript-memoization.

--
In general, when you have a function that does something simple that you care about, and you want to change it in some way that makes you think "ah crap, this has NOTHING to do with what the method does, and now all this crap code will be littered all throughout my method," it might be time for this approach.

-------------------------------------------------------

I once worked on some report software that showed a preview of the output you'd get, based on your current options, so you didn't have to run the whole query, just to find you wanted a different format.  It was a lot of crazy JavaScript, generating HTML and CSS and ramming it into a spot on the page, on each change of a form input.  When we laid out the page, we took advantage of the full width of the browser, so if the user resized the browser, we wanted to re-generate the output.  But the whole process took up to three seconds, depending on your options, and since the resize event fires continuously, just setting `window.onresize` to our function would lock up the browser for a while.

We needed the function to run only intermittently -- we needed it to wait some milliseconds, before running, and then keep .  We probably could have added timeout code to the beginning of the function,
