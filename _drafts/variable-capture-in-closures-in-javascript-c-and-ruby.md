---
layout: post
title: Variable capture in closures, in JavaScript, C#, and Ruby
type: post
published: false
status: draft
categories:
- Functional Programming
- Programming
tags:
- ruby c# javascript
author: Dan Bernier
---

see gmail for files for this post...

"I created some functions in a loop, but when I run them, their variable values are all wrong!  What's going on?"

The problem is probably that your functions are closing over a variable that changes as you go through the loop, so when you run the functions, you get the _latest_ value for that variable, rather than the value it had when the function was created, inside the loop.  Let's break that down.

What's a closure?

If you already know about closures, you can skip down to "...".

In many languages with first-class functions (a.k.a. anonymous functions, lambdas, procs, or delegates), the functions can refer to variables that were in scope when the function was created.  In technical terms, they "close over" those variables, which is why they're called _closures_.  For example:

{% highlight js linenos %}
function makeGreeter(greeting) {
    return function(name) {
        return greeting + ', ' + name;
    };
}
{% endhighlight %}

`makeGreeter` takes a reference named `greeting`, and returns a function that greets people by name.  When you call `makeGreeting`, you do not get a greeting, you get a greeter.  Apologies:

{% highlight js linenos %}
var walmartGreeter = makeGreeter('Welcome to Wal-mart');
walmartGreeter('Dan');  // 'Welcome to Wal-mart, Dan';
walmartGreeter('Bub');  // 'Welcome to Wal-mart, Bub';
{% endhighlight %}

It's as if you'd just written this:

{% highlight js linenos %}
function walmartGreeter(name) {
    var greeting = 'Welcome to Wal-mart';
    return greeting + ', ' + name;
}
{% endhighlight %}

But `makeGreeter` can make _other_ greeters, too:

{% highlight js linenos %}
var religious = makeGreeter('Merry Christmas');
var generic = makeGreeter('Happy Holidays');

religious('Dan');  // 'Merry Christmas, Dan'
generic('Bub');  // 'Happy Holidays, Bub'
{% endhighlight %}

JavaScript has a neat feature: you can get the code for any function via `toString()`.  If we take a peek at  `walmartGreeter.toString()`, it looks like this:

{% highlight js linenos %}
function (name) {
    return greeting + ", " + name;
}
{% endhighlight %}

It looks like a normal function -- except `greeting` isn't defined anywhere.  The trick is, `greeting` was in scope when this function was created, inside `makeGreeter`.  The function still holds a reference to greeting, just like an object holds a reference.  And because it's a reference, if the value it points to _changes_, this function will see the changes, too.  Let's try it:

{% highlight js linenos %}
var sillyGreeting = "Hey there";
var greeter = makeGreeter(sillyGreeting);
greeter("Dan") // "Hey there, Dan"
sillyGreeting += ", hi there, ho there"
greeter("Dan") // "Hey there, hi there, ho there, Dan"
{% endhighlight %}

...whoops, that one doesn't work.
