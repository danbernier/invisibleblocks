---
layout: post
title: 'Where the Abstraction Leaks: JavaScript''s Fake Arrays'
type: post
published: true
status: publish
categories: []
tags:
- JavaScript
author: Dan Bernier
date: 2010-06-15 12:01:08.000000000 -04:00
---

Ruby arrays have a nice feature: you can construct a new array with an integer N, and a block, which will be called N times, to fill up the array:

{% highlight ruby linenos %}
Array.new(5) { 'yo' }
# gives:
["yo", "yo", "yo", "yo", "yo"]

# Closures, too!
i = 0
Array.new(4) { i = i + 1 }
# gives:
[1, 2, 3, 4]
{% endhighlight %}

I tried to recreate this in JavaScript:

{% highlight js linenos %}
new Array(5, function() { return "drip"; });
// gives:
[5, function() {
    return "drip";
}]
{% endhighlight %}

Oops!  I guess the Array constructor works differently in JavaScript.  No worries, we can just call map on the new array.

{% highlight js linenos %}
new Array(5).map(function() { return "drip"; });
// gives:
[, , , , ]
{% endhighlight %}

...um, what?  Shouldn't that be `["drip", "drip", "drip", "drip", "drip"]`?  If I call `new Array(3)`, I should get a brand new array, with 3 slots, all set to `undefined`; and I should be able to map over it, and fill up the array.

Let's see what its elements are:
{% highlight js linenos %}
var array = new Array(5);
array[0]; // undefined, as expected
array[1]; // also undefined
{% endhighlight %}

So far, so good.  What arguments are passed to the function?
{% highlight js linenos %}
function printAndDrip(arg) {
    print(arg);
    return "drip";
}
array.map(printAndDrip); // prints nothing, and returns [, , , , ]
{% endhighlight %}

It looks like the `printAndDrip` function is never being called, almost like the array has no contents.

Let's try setting a value manually, _then_ mapping:

{% highlight js linenos %}
array[2] = "hey there"; // [, , "hey there", , ], as expected
array.map(printAndDrip);
// prints "hey there", and returns [, , "drip", , ]
{% endhighlight %}

So, it only calls the function for values we've manually put there.  Maybe map doesn't call the function if the value of a slot is undefined?  I know, I'm reaching here...

{% highlight js linenos %}
array = [1, undefined, 2];
array.map(printAndDrip);

/* prints:
1
undefined
2
then outputs:
["drip", "drip", "drip"]
*/
{% endhighlight %}

So it _does_ call the function for undefined values!  Then why didn't it in our newly-created array?

This is when it hit me, and it's a funny JavaScript fact that I always forget: JavaScript has fake arrays.

They're actually closer to hash tables, whose keys are numbers.  `["zero", "one"]` is just syntax sugar: it creates an object with two properties, named 0 and 1; 0 points to "zero", and 1 points to "one".  

{% highlight js linenos %}
// pretty much the same:
var arrayLiteral = ["zero", "one"];
var objectLiteral = { 0: "zero", 1: "one" };
{% endhighlight %}

Apparently, if you use the `new Array(10)` constructor, it creates an array with length 10, but with no named properties.

We can see the properties an object has with the [hasOwnProperty](https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/Object/hasOwnProperty) method, so we can use that to test our hypothesis.

{% highlight js linenos %}
var emptyArray = new Array(10);
emptyArray.hasOwnProperty(0); // false
emptyArray.hasOwnProperty(1); // false

var fullArray = [1,2,3];
fullArray.hasOwnProperty(0); // true
fullArray.hasOwnProperty(1); // true
fullArray.hasOwnProperty(99); // false: gone past the end
{% endhighlight %}

So where does that leave us? Nowhere, really.  At least I'm a little clearer about JavaScript's fake arrays.  Imitating Ruby's Array constructor is pretty much out; it's easy enough, though a bit unsatisfying, to hand-roll our own:

{% highlight js linenos %}
Array.filled = function(n, fn) {
    var array = [];
    while(n-- > 0) {
        array.push(fn());
    }
    return array;
}
Array.filled(5, function() { return "drip"; });
// gives:
["drip", "drip", "drip", "drip", "drip"]
{% endhighlight %}

Perhaps the folks working on the new JavaScript standards can put in a line-item about initializing Arrays with all the right numbered slots, and that'll be unnecessary.

_While writing this post, I used the [JavaScript Shell 1.4](http://www.squarefree.com/shell/shell.html) in FireFox 3.6.3 on Windows 7.  I also redefined `Array.prototype.toString` to [display JavaScript arrays the way you type them]({% post_url 2010-02-02-array-prototype-tostring %})._
