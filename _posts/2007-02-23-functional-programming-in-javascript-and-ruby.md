---
layout: post
title: Functional Programming in JavaScript and Ruby
type: post
published: true
status: publish
categories:
- Functional Programming
- Programming
tags:
- JavaScript
- Ruby
author: Dan Bernier
date: 2007-02-23 09:40:59.000000000 -05:00
comments:
- author: Masklinn
  content: "On the subject of `fold` and `map`: you should not implement them recursively
    in Javascript. They're usually implemented recursively in FP languages because:\r\n\r\n*
    They work on (linked)lists/conses, which are inherently recursive structures.
    Javascript doesn't have conses, only arrays. The slicings, array concatenations
    and single-element array creations of the recursive implementations generate _a
    lot_ of garbage and straing the JS interpreters.\r\n\r\n* FP languages all implement
    tail-recursion optimization, and even when the functions aren't tail-recursive
    they're usually quite efficient at recursion. Javascript doesn't implement tail-recursion
    optimization (which makes your tail-recursive fold -- \"fold-linear\" -- completely
    useless even though it would work in e.g. Scheme or SML) and is overall fairly
    bad at recursion (not as bad as PHP or VB, but still plenty bad).\r\n\r\nSo you
    should probably implement them iteratively, it's not that hard (and both are actually
    much shorter, unless you want to implement both `foldl` and `foldl1` as a single
    function in which case you get an ugly conditional.\r\n\r\nLikewise for Ruby by
    the way, don't overuse recursion when you don't have to.\r\n\r\nOn a side note,
    since map and filter (and some other functions) have been implemented natively
    in Firefox 1.5+ as part of JS 1.6 (http://developer.mozilla.org/en/docs/New_in_JavaScript_1.6#Array_extras),
    I'd strongly suggest using the same names in your implementation, and testing
    if the methods exist beforehand so that you don't overwrite them when they're
    already available. I'm noting that they didn't implement folds though. Shucks"
  date: '2007-02-23 15:24:36'
  author_email: masklinn@masklinn.net
- author: Dan Bernier
  content: "Masklinn,\r\n\r\nGood points.  I implemented map, fold, and find to test
    out my understanding of functional programming concepts, and the bits of SICP
    I've been reading -- not for serious usage.  I did write them all iteratively
    at first, and they were shorter, but still very imperative...I wanted to stretch
    out a bit.  I guess I should've made that clearer.\r\n\r\nStill, implementing
    them iteratively is probably a good thing, especially if, like you said, we check
    first for their existence before clobbering a native implementation with our own
    attempt.  My thinking is that if more programmers are used to them, their thought
    patterns will shift a bit, maybe rise to a higher level of abstraction.  Which
    would be good for everyone.\r\n\r\nAs far as map and filter in JS 1.6, I'd heard
    bits about that, and my excitement was tempered by the suspicion that IE 7 wouldn't
    include them.  Turns out I was right...\r\n\r\n\r\n```javascript\nvar a = [1,
    2, 3, 4, 5];\r\n\r\nif (![].map) {   // IE 7\r\n    Array.prototype.map = function(mapFunc)
    {\r\n        alert(\"custom map implementation!\");\r\n        var mapped = [];\r\n
    \       for (var i = 0; i &lt; this.length; i++) {\r\n            mapped.push(mapFunc(this[i]));\r\n
    \       }\r\n        return mapped;\r\n    }\r\n}\r\nif (![].filter) {   // IE
    7\r\n    Array.prototype.filter = function(filterFunc) {\r\n        alert(\"custom
    filter implementation!\");\r\n        var matches = [];\r\n        for (var i
    = 0; i &lt; this.length; i++) {\r\n            if (filterFunc(this[i])) {\r\n
    \               matches.push(this[i]);\r\n            }\r\n        }\r\n        return
    matches;\r\n    }\r\n}\r\nif (![].fold) {   // IE 7 and FFox 1.5 (I should upgrade...)\r\n
    \   Array.prototype.fold = function(base, foldFunc) {\r\n        alert(\"custom
    fold implementation!\");\r\n        var folded = base;\r\n        for (var i =
    0; i &lt; this.length; i++) {\r\n            folded = foldFunc(folded, this[i]);\r\n
    \       }\r\n        return folded;\r\n    }\r\n}\r\n\r\nvar squares = a.map(function(i)
    { return i * i; });\r\nalert(squares);\r\n\r\nvar evens = a.filter(function(i)
    { return i % 2 == 0; });\r\nalert(evens);\r\n\r\nvar sum = a.fold(0, function(tally,
    i) { return tally + i; });\r\nalert(sum);\r\n```\n\r\n\r\nThanks for your comments..."
  date: '2007-02-23 18:07:30'
  author_email: danbernier@gmail.com
- author: Nathan
  content: "Given isOdd as defined above, you can pass that method directly without
    the block, I don't know that it is any easier.\r\n\r\n[1,2,3,4].find_all &amp;method(:isOdd)\r\n=&gt;
    [1, 3]\r\n\r\n[1,2,3,4].find_all {|i| isOdd(i)}\r\n\r\nis one character less."
  date: '2007-02-23 18:36:43'
  author_email: nathan@acceleration.net
- author: Victor
  content: "JavaScript 1.5 includes these methods already (from the FF site):\r\n\r\nmap()\r\nCreates
    a new array with the results of calling a provided function on every element in
    this array. \r\n\r\nfilter()\r\nCreates a new array with all of the elements of
    this array for which the provided filtering function returns true. \r\n\r\nforEach()\r\nCalls
    a function for each element in the array. \r\n\r\nevery()\r\nReturns true if every
    element in this array satisfies the provided testing function. \r\n\r\nsome()\r\nReturns
    true if at least one element in this array satisfies the provided testing function.
    \r\n\r\n--\r\n\r\nThere is no existing fold() in javascript, as far as I know.
    The same function is also referred to as \"reduce\" in some languages."
  date: '2007-02-23 21:20:36'
  author_email: vwallen@antlab.net
- author: mfp
  content: "It seems you have gotten some terminology mixed up. You've written that
    fold_recursive (foldr) generates a \"recursive process\" and fold_linear (foldl)
    a \"linear recursive process\", but If I'm reading the SICP page correctly, foldr
    generates a linear recursive process and foldl a linear *iterative* process (i.e.
    the function is tail-recursive).\r\n(Also, note that you aren't using the \"base\"
    argument in fold_linear). \r\n\r\n\"Look at sum_w_proc and sum_w_block…sum_w_block
    is a bit clearer, isn't it? But if you use blocks, you lose the ability to pass
    a function reference as a parameter.\" &gt;\r\n\r\nWell, does this count?\r\n\r\n[1,
    2, 3].fold_w_block(0, &amp;lambda{|a,b| a+b})    # =&gt; 6\r\n\r\n(Another small
    braino: you say that fold_w_block and fold_w_proc are based on fold_linear, but
    they're actually foldr...)"
  date: '2007-02-24 07:16:59'
  url: http://eigenclass.org
  author_email: mfp@acm.org
- author: Kirit
  content: "I also used Javascript for an analysis of recursion. I did some timings
    of the various approaches you may be interested in taking a look at.\r\n\r\nhttp://www.kirit.com/Recursive%20rights%20and%20wrongs\r\n\r\nThe
    basic outcome is that Javascript is absolutely terrible for recursion probably
    due to a very high function call overhead (which given that it must do a load
    of runtime analysis to support closures probably shouldn't be all that surprising),
    at least in Microsoft's implementation.\r\n\r\nDoing this sort of thing in C++
    is interesting because the functor objects passed into things like std::transform
    (the C++ name for 'map') can store state. Clearly breaks the 'no side effect'
    rule, but can be used for some interesting effects.\r\n\r\nPersonally I think
    Javascript is a great language to do this sort of experimenting on because nearly
    everybody has several pretty good implementations on their computer."
  date: '2007-02-24 07:38:49'
  url: http://www.kirit.com/
  author_email: kirit@kirit.com
- author: Trenton Miller
  content: "Just for the record:\r\n\r\nfoldr and foldl in Ruby\r\nhttp://snippets.dzone.com/posts/show/3259"
  date: '2007-02-24 11:32:28'
  author_email: trentom@mailinator.com
- author: Dan Bernier
  content: "Nathan,\r\n&gt; Given isOdd as defined above, you can pass that method
    directly without the block.\r\n\r\nMy point was to show that Ruby doesn't let
    you pass the method name like a regular parameter like JavaScript does, and I
    think your examples bear that point out...though I didn't know about &amp;method(:sym).
    \ How does it work?  Does it return a method pointer?  I don't have my pickaxe
    handy...I'll have to read up.\r\n\r\nmfp, allow me some time to consider your
    comment.  I was -pretty- sure I had my linear recursive and recursive straight,
    but I've been wrong before.  Like I said, I'm still learning.\r\n\r\nKirit,\r\n&gt;
    Personally I think Javascript is a great language to do this sort of experimenting
    on because nearly everybody has several pretty good implementations on their computer.\r\n\r\nMy
    thoughts exactly.  When I started the coding for this post, I was on lunch break
    from an ASP.Net class, so rather than install Ruby on the machine, I used the
    ubiquitous JavaScript.  I scanned your \"Recursive rights and wrongs\", I'll give
    it a more thorough read soon."
  date: '2007-02-24 15:00:38'
  author_email: danbernier@gmail.com
- author: Masklinn
  content: "&gt; My thinking is that if more programmers are used to them, their thought
    patterns will shift a bit, maybe rise to a higher level of abstraction. Which
    would be good for everyone.\r\n\r\nI do agree with that, even though nothing beats
    using actually functional languages to understand what Higher Order Functions
    are about (and have a hard time coding in Java after that)\r\n\r\n&gt; As far
    as map and filter in JS 1.6, I'd heard bits about that, and my excitement was
    tempered by the suspicion that IE 7 wouldn't include them. Turns out I was right…\r\n\r\n'course
    you are, I don't think Opera and Safari implement JS 1.6 either. As a matter of
    fact, I'm pretty sure only Mozilla browsers implement them, for the moment at
    least.\r\n\r\n&gt; JavaScript 1.5 includes these methods already\r\n\r\nNo, that's
    in Javascript 1.6, the confusion comes from the fact that the first implementation
    of JS 1.6 is Firefox 1.5 (and Firefox 2.0 is the first restricted implementation
    of JS 1.7)\r\n\r\n&gt; It seems you have gotten some terminology mixed up. You've
    written that fold_recursive (foldr) generates a \"recursive process\" and fold_linear
    (foldl) a \"linear recursive process\"\r\n\r\nI think he meant that foldr was
    a recursive process executed in constant memory (which is true in a strict-evaluating
    tail-optimizing language, which javascript isn't). His terminology is debatable,
    but that's the feeling I got\r\n\r\n&gt; The basic outcome is that Javascript
    is absolutely terrible for recursion [...] at least in Microsoft's implementation.\r\n\r\nYou'll
    find that the other implementations fare no better. Maybe we'll see a better support
    for recursion with the first JIT implementations (e.g. Adobe's Tamarin http://www.mozilla.org/projects/tamarin/),
    but for the moment JS is one of those language which make you want to use FP,
    but forces you to be very careful about it.\r\n\r\ngt; My point was to show that
    Ruby doesn't let you pass the method name like a regular parameter like JavaScript\r\n\r\nYes,
    but that's because just writing the name of the message in Ruby means that you're
    sending the message to the objet (foo.bar is exactly the same as foo.send(:bar))
    while in javascript the semantic is that of a \"method call\": writing the method
    name (foo.bar) is not enough, you have to call it (foo.bar()) for it to be executed.\r\n\r\n&gt;
    How does it work?\r\n\r\nTaken straight from `ri Object#method`:\r\n\r\nObject#method\r\n
    \    obj.method(sym)    =&gt; method\r\n------------------------------------------------------------------------\r\n
    \    Looks up the named method as a receiver in _obj_, returning a\r\n     +Method+
    object (or raising +NameError+). The +Method+ object acts\r\n     as a closure
    in _obj_'s object instance, so instance variables and\r\n     the value of +self+
    remain available.\r\n\r\n        class Demo\r\n          def initialize(n)\r\n
    \           @iv = n\r\n          end\r\n          def hello()\r\n            \"Hello,
    @iv = #{@iv}\"\r\n          end\r\n        end\r\n\r\n        k = Demo.new(99)\r\n
    \       m = k.method(:hello)\r\n        m.call   #=&gt; \"Hello, @iv = 99\"\r\n\r\n
    \       l = Demo.new('Fred')\r\n        m = l.method(\"hello\")\r\n        m.call
    \  #=&gt; \"Hello, @iv = Fred\"\r\n\r\n&gt; Does it return a method pointer?\r\n\r\nIt
    returns a Method object (http://www.ruby-doc.org/core/classes/Method.html) without
    calling it, while just using \"foo.bar\" calls the method object outright."
  date: '2007-02-26 05:47:00'
  author_email: masklinn@masklinn.net
- author: Masklinn
  content: "&gt; I also used Javascript for an analysis of recursion. I did some timings
    of the various approaches you may be interested in taking a look at.\r\n&gt;\r\n&gt;
    http://www.kirit.com/Recursive%20rights%20and%20wrongs\r\n\r\nKirit, the issue
    I have with your post is that the second category is far too closed: you consider
    that recursion is bad period, while the issue really is that most popular langages
    suck at recursion (e.g. in languages such as Erlang or Scheme recursion is not
    only a powerful tool but one that's used often) (the fact that these languages
    usually lack iterative structures helps, too)"
  date: '2007-02-26 05:50:44'
  author_email: masklinn@masklinn.net
- author: Kirit
  content: "&gt;Kirit, the issue I have with your post is that the second category
    is far too closed: you consider that recursion is bad period\r\n\r\nIs that really
    what I said? That certainly wasn't the intent. It is certainly a tool I use often,
    but I'm ultimately careful with it because it can be a source of problems.\r\n\r\nHere
    is my summary:\r\n\r\n&gt;Recursion is a very powerful tool and it often enables
    us to spot algorithms that we wouldn't otherwise see. We should however be very
    careful of using it in production software, especially where the parameters for
    the recursion ultimately derive from user input, or any other non-trusted source.\r\n\r\nIn
    languages like Scheme (which I specifically mention) writing tail recursive functions
    is really writing a loop anyway because you know the language is going to convert
    it for you.\r\n\r\nThe reason for writing the subject up in that was because I
    hadn't seen anybody point to the obvious problems involved in exhausting the stack
    with recursive functions.\r\n\r\nDespite much hiding of heads in sand about the
    issue it is still an important consideration whenever recursion is used. That
    isn't the same as saying don't use it though."
  date: '2007-02-26 21:31:49'
  url: http://www.kirit.com/
  author_email: kirit@kirit.com
- author: Masklinn
  content: "&gt; In languages like Scheme (which I specifically mention) writing tail
    recursive functions is really writing a loop anyway because you know the language
    is going to convert it for you.\r\n\r\nI don't think it's \"really like writing
    a loop anyway\", it's the same to the machine, but you sure think recursively,
    not iteratively, even if the code is executed iteratively.\r\n\r\nPlus I didn't
    limit my scope to iterative structures: while tail-recursive implementations clearly
    are the best, functional languages often have very powerful and efficient recursion
    abilities even on non tail-recursive functions. And they still don't have any
    iterative structures."
  date: '2007-02-27 05:06:16'
  author_email: masklinn@masklinn.net
- author: Kirit
  content: "Masklinn, I know this sounds like we're arguing, but I can't bring myself
    to believe that we actually have any real difference of opinion here. We may be
    looking out over the landscape of software development in different directions,
    but we're seeing the same features.\r\n\r\nI think we both agree that there are
    all sorts of algorithms that are easier to find and to understand in recursive
    forms.\r\n\r\nI think we also agree that it is better to write those recursive
    functions that are tail recursive so that they consume O(1) memory rather than
    O(n).\r\n\r\nThe only other thing I say in my article is that sometimes non-tail
    recursive functions are better off re-written because the heap is bigger than
    the stack and is less likely to be exhausted.\r\n\r\nWe're writing for different
    audiences so of course our emphasis is in different places, but I don't think
    we disagree anywhere.\r\n\r\nI'm going to have a think about adding some notes
    to my article to clarify where the issues I raise are of concern primarily to
    people using non-functional languages in case it can be mis-read."
  date: '2007-03-01 01:19:48'
  url: http://www.kirit.com/
  author_email: kirit@kirit.com
- author: justin
  content: Nice article!  Some how this filled in a lot of the blanks I had about
    jscript and functional prototyping.  Thanks for the good work...
  date: '2007-03-02 10:24:33'
  author_email: juwiley+invisibleblocks@gmail.com
- author: Dan Bernier
  content: "mfp,\r\n\r\nI finally re-read the SICP page more carefully, and you're
    right.  Thanks for the catch.  I updated the post, to avoid confusion.\r\n\r\nI
    also found <a href=\"http://en.wikipedia.org/wiki/Fold_(higher-order_function)\"
    rel=\"nofollow\">this Wikipedia article about foldr and foldl</a>, which helped
    me understand things.\r\n\r\nThanks..."
  date: '2007-03-02 20:17:39'
  author_email: danbernier@gmail.com
- author: Jordan Callicoat
  content: "You can pass around blocks in ruby as well, given that you define them
    as Proc objects:\r\n\r\n<code>def a (b, &amp;block)\r\n  if block\r\n    block.call()\r\n
    \ end\r\nend\r\na(\"foo\", &amp;Proc.new { puts \"blah\" })</code>"
  date: '2007-10-18 16:17:49'
  author_email: MonkeeSage@gmail.com
- author: Jordan Callicoat
  content: "same as ...\r\na(\"foo\") { puts \"blah\" }"
  date: '2007-10-18 16:19:23'
  author_email: MonkeeSage@gmail.com
- author: Jordan Callicoat
  content: "I.e., you can pass a method to a proc-taking method using the #to_proc
    method of Methods and Symbols. For example, given a foldl and foldr...\r\n\r\n\r\n<code>\r\nclass
    Array\r\n  def foldr(base, &amp;cat)\r\n    if self.empty?\r\n      base\r\n    else\r\n
    \     cat.call(self.first, self[1..-1].foldr(base, &amp;cat))\r\n    end\r\n  end\r\n
    \ def foldl(base, &amp;cat)\r\n    if self.empty?\r\n      base\r\n    else\r\n
    \     self[1..-1].foldl(cat.call(base, self.first), &amp;cat)\r\n    end\r\n  end\r\nend\r\n</code>\r\n\r\n\r\n...they
    can be called like...\r\n\r\n\r\n<code>\r\na.foldl(0, &amp;:-.to_proc())\r\na.foldr(0,
    &amp;:-.to_proc())\r\na.foldr(0, &amp;lambda { |x, y| x - y }.to_proc())\r\n</code>\r\n"
  date: '2007-10-19 10:56:39'
  author_email: MonkeeSage@gmail.com
- author: remcoder
  content: another reason not to implement these functions recursively is the <a href="http://novemberborn.net/javascript/callstack-size"
    rel="nofollow">limited stack size in browsers</a>, especially Safari.
  date: '2007-12-19 14:47:29'
  url: http://remcoder.wordpress.com/
  author_email: remcoder@geeknet.nl
- author: p1999
  content: "I think the second \"iterative\" fold function is a fold_right function
    and it's different from the first. Also, in my opinion, the second function looks
    almost like a for-loop so you might just as well do so (a fold_left though):\r\n\r\nArray.prototype.fold_iterative
    = function(combineFunc,t) {\r\n    var a;\r\n    for(a=0;a&lt;this.length;a++)
    {\r\n        t=combineFunc(t,this[a]);\r\n    }\r\n    return t;\r\n}"
  date: '2009-07-19 05:25:07'
  url: http://lwz.110mb.com
  author_email: p199999991@gmail.com
- author: p1999
  content: Sorry for the last comment... it's the first function that is fold_right,
    and the second function is supposed to do a fold_left, but doesn't do it correctly.
    I think the it should be combineFunc(tally, this.first()) in the recursive call.
  date: '2009-08-02 22:22:25'
  url: http://lwz.110mb.com
  author_email: p199999991@gmail.com
---

[**UPDATE:** I've been lucky enough to have some commenters who know much more about functional programming than I do. There's some good reading in the [comments](#comments), and you especially should read them before using this stuff in production.]

I've been playing with functional JavaScript tonight. It's not the greatest of OO-functional hybrid languages, but it's good to supplant my fledgling functional skills with something besides Ruby. Plus, I'm [not](http://javascript.infogami.com/Functional_Javascript) the [only](http://www.svendtofte.com/code/practical_functional_js/) [one](http://www.b-list.org/weblog/2006/10/11/functional-language-s-right-under-your-nose) [doing](http://blog.360.yahoo.com/blog-Vdrx7eU3fqovesPu9Y8Y?p=24) it, so I can compare notes. And who doesn't love JavaScript, right? ...right?

Before I get much farther, I should thank [Adam Turoff](http://notes-on-haskell.blogspot.com) for his post [What's Wrong with the For Loop](http://notes-on-haskell.blogspot.com/2007/02/whats-wrong-with-for-loop.html). It gets at the root of the why we'd use a functional programming language instead of an OO or procedural one, and (bonus!) it helped me grok Ruby's `inject` method (it's the same as my new friend `fold`). Go read his post, it's good for you. And if you like it, we recommend the [1981 <span class="caps">SICP</span> lectures](http://swiss.csail.mit.edu/classes/6.001/abelson-sussman-lectures/). Robusto!

### Here we go!


Introductions to functional programming usually discuss three methods: `map`, `find`, and `fold`. The names aren't always the same, but those are the three amigos of functional programming. They all do something different to arrays (or lists, or collections, or whatever you want to call them):

* `find` does what it says. You give it some criteria, it returns all the matching elements. The criteria is expressed as a function, a little bit of code that says "yes, I want this one," or "no, skip it." If we're picking out the red gumballs, you could say (in Ruby) `gumballs.find_all { |ball| ball.isRed? }` `find` is also known as `filter`. [Ruby only calls it `find_all` because it uses `find` for returning just the first match.] Po-tay-to, po-tah-to.
* `fold` takes each element, and "folds" it into a running total. Think of summation—you're folding each new number into a running tally. In Haskell (and, it seems, many functional languages), it comes in two varietes, `fold_left` and `fold_right`, which just mean "start from the left" and "start from the right". Ruby calls it `inject`, which confuses some people (like me).
* `map` is the mathiest of them (don't be scared, it's easy!). In English, we'd say "change each item like _this_, and give me the new results." Let's down-case a list of words. "Change each word to _lowercase_, and give me the downcased words." `words.map { |word| word.downcase }`. The name "map" comes from [functions in math](http://en.wikipedia.org/wiki/Function_%28math%29) (surprise), where you map each input to one output. The whole `y = f(x)` thing…`f` is for "function". Ruby also calls this `collect`.

Now, none of these comes predefined in JavaScript. How can this be? Well, all the JavaScript engines out there are in browsers, and we know that "when browser elephants battle, it is the JavaScript grass that suffers." The browser developers are busy with other things. But this oversight means we have some easy examples to write. It's boring to re-implement existing stuff, just for the exercise. So here we go—I'll compare examples in JavaScript and Ruby.

### A quick word about JavaScript's open classes


JavaScript has open classes, just like Ruby. In other words, you can re-open a class definition, give it a method, and then start using that method on instances of that class. JavaScript's OO is prototype-based, not class-based, so it looks a little weird:

{% highlight js linenos %}
Array.prototype.first = function() {
    return this[0];
}
[1, 2, 3].first();  // 1

Array.prototype.rest = function() {
    return this.slice(1);
}
[1, 2, 3].rest();  // [2, 3]

Array.prototype.isEmpty = function() {
    return this.length == 0;
}
[].isEmpty();    // true
[1].isEmpty();   // false
{% endhighlight %}

"For the prototypical Array, the Array from which all other Arrays spring forth, create a property called 'first', which shall be this function, which returns the first element of the Array…" Just a Biblical way of defining a method for a class.

Open classes is good news, because it'll make our job of adding `map`, `find`, and `fold` possible, since they'll be going into the Array class.

### Find


`find` is the easiest, so we'll start there. Let's take a look:
{% highlight js linenos %}
Array.prototype.find = function(isAMatch) {
    var matches = [];
    for (i = 0; i < this.length; i++) {
        if (isAMatch(this[i])) {
            matches.push(this[i]);
        }
    }
    return matches;
}
{% endhighlight %}

`find` is a function, and it takes the function `isAMatch` as a parameter. One of the hallmarks of the functional programming style is that functions are first-class citizens in the language: they can be treated like any other variable, so they can be passed around as parameters, and returned from other functions. [[Closures](http://en.wikipedia.org/wiki/Closure_%28computer_science%29) and [anonymous functions](http://en.wikipedia.org/wiki/Anonymous_function) are also major features.] `isAMatch` is a function that tells you whether we should include any given element of the Array. Use `find` like this:

{% highlight js linenos %}
var evens = [1, 2, 3, 4, 5].find(
    function(i) {
        return i % 2 == 0;
    }
);

function isOdd(i) {
    return i % 2 != 0;
}
var odds = [1, 2, 3, 4, 5].find(isOdd);
{% endhighlight %}

The first example uses an in-line, anonymous function; the second uses a named function. Both work fine, but here is where we start to see JavaScript's awkward syntax get in the way. Consider the Ruby version:

{% highlight ruby linenos %}
# find_all comes pre-defined in Array, via the Enumerable module,
# but this is what it would look like...
class Array
  def find_all
    matches = []
    self.each do |item|   # Ruby says 'self', not 'this'.
      if yield(item)      # yield says "Call the block we were given"
        matches.push(item)   # Stuff item into matches
      end
    end
    return matches
  end
end

evens = [1, 2, 3, 4, 5].find_all { |i|
  i % 2 == 0
}

def isOdd(i)
  i % 2 != 0
end

odds = [1, 2, 3, 4, 5].find_all { |i|
  isOdd(i)
}
{% endhighlight %}

In Ruby, every expression returns a value, so `return` disappears. And Ruby's blocks mean we don't need to wrap our match condition inside `function(i) { ... }`. But Ruby's `find_all` won't take a reference to a method as a parameter:
{% highlight ruby linenos %}
def isOdd(i)
    i % 2 != 0
end

odds = [1, 2, 3, 4, 5].find_all(isOdd)
# gives error: `isOdd': wrong number of arguments (0 for 1) (ArgumentError)
{% endhighlight %}

Once you've defined a function in JavaScript, you can pass it around by name, like any other variable, but you need that `function(i) { ... }` syntax around your test. In Ruby, `find_all` takes a block instead of parameters, so you can't pass a reference. Given how nice blocks are in Ruby, I guess this can be forgiven, but it's a little weird.

### Fold


Now we'll get into the recursive guys. `find` is a pain to implement recursively in JavaScript, so I did it iteratively, but recursion works well for `fold` and `map`. Since recursion seems to be more idiomatic in functional languages, we'll use it here.

I took two shots at `fold` in JavaScript (I'm learning). Here they are:

{% highlight js linenos %}
Array.prototype.fold_recursive = function(combineFunc, base) {
    if (this.isEmpty()) {    // I added isEmpty, first, and rest, as above
        return base;
    }
    else {
        return combineFunc(
            this.first(),
            this.rest().fold_recursive(combineFunc, base));
    }
}

Array.prototype.fold_iterative = function(combineFunc, tally) {
    if (this.isEmpty()) {
        return tally;
    }
    else {
        return this.rest().fold_iterative(
            combineFunc,
            combineFunc(this.first(),
                        tally));
    }
}
{% endhighlight %}

The first is straightforward recursion. If the list is empty, we're done, so return the base value (zero, if we're adding). Otherwise, combine the first value with whatever the rest of the items fold up to. [If you have trouble writing recursively, this is the canonical pattern you should probably follow: if done, do base case; else, do _this_ element, then the _rest_ of them.]

The second is a little different. You've got a starting `base`, the `tally` so far, and a `combineFunc` that folds each value into the `tally`. If the list is empty, we're done, so return the `tally`. Otherwise, fold the first item into the tally for the rest of the list.

It the first, you hang around, waiting for the answer to the rest of the problem, before you add in your part of the sum. In the second, you push your part of the sum down into the next round of processing, so you don't have to remember anything. When the answer comes back from the recursive call, it'll already have your part of the sum in it.

[The first one is a "linear recursive process", the second is "linear iterative process", even though both are recursive procedures. If your interest is piqued, check out [this <span class="caps">SICP</span> page](http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2.1), but it's not needed for this article. For the rest of this post, I'll be using the linear recursive version, because it's conceptually clearer. Thanks to mfp for keeping me honest.]

Here's how `fold` is used:

{% highlight js linenos %}
// A handy adding function
function add(a, b) {
    return a + b;
}

Array.prototype.sum_recursive = function() {
    return this.fold_recursive(add, 0);
}
[1, 2, 3].sum_recursive();  // 6
{% endhighlight %}

To `sum` the elements of an array, we want to `fold` the numbers together by `add`-ing them, starting at 0. Easy, isn't it?

Here are two Ruby versions, based on `fold_recursive`...one that takes a function (called a "procedure object" in Ruby) as a parameter, one that takes a block:

{% highlight ruby linenos %}
class Array
  def rest     # We'll define rest, to keep the examples similar
    self[1..-1]
  end

  def fold_w_proc(combineFunc, base)
    if self.empty?
      base
    else
      # "func.call(args)" instead of JavaScript's "func(args)"
      combineFunc.call(
        self.first,
        self.rest.fold_w_proc(
          combineFunc,
          base)
        )
    end
  end

  def fold_w_block(base, &combineFunc)
    if self.empty?
      base
    else
      combineFunc.call(
        self.first,
        self.rest.fold_w_block(
          base,
          &combineFunc)
        )
      end
  end

  def sum_w_proc
    fold_w_proc(lambda { |a, b| a + b }, 0)
  end
  def sum_w_block
    fold_w_block(0) { |a, b| a + b }
  end
end

[1, 2, 3].sum_w_proc    # 6
[1, 2, 3].sum_w_block   # 6
{% endhighlight %}

Notice how similar `fold_w_block` and `fold_w_proc` are to the JavaScript `fold_recursive`. The thing that differentiates `fold_w_block` and `fold_w_proc` is how they're used. The definitions themselves are nearly identical, except for the order of the parameters. Look at `sum_w_proc` and `sum_w_block`...`sum_w_block` is a bit clearer, isn't it? But if you use blocks, you lose the ability to pass a function reference as a parameter.

### Map


`map` looks a lot like `fold`.

{% highlight js linenos %}
Array.prototype.map = function(mapFunc) {
    if (this.isEmpty()) {
        return this;
    }
    else {
        return [mapFunc(this.first())].concat(
                this.rest().map(mapFunc));
    }
}

function cube(i) { return i * i * i; }

[1, 2, 3].map(function(i) { return i * i; });  // [1, 4, 9]
[1, 2, 3].map(cube);  // [1, 8, 18]
{% endhighlight %}

Again, it's basic recursion…if we're out of items, return the empty list (ie, this). Otherwise, make an array of the first mapped item, and concatenate it with the rest of the mapped items. Again, with JavaScript, you can pass your function in-line, or by reference.

Here's a recursive definition of `map` in Ruby:

{% highlight ruby linenos %}
class Array
  def map(&mapFunc)
    if self.empty?
      self
    else
      [mapFunc.call(self.first)] + self.rest.map(&mapFunc)
    end
  end
end

[1, 2, 3].map { |i| i * i }  # [1, 4, 9]
{% endhighlight %}

As before, calling `map` with a block certainly looks nicer than by passing in functions, but you lose the ability to define a function somewhere, and pass it in by name, like we did with `cube` in JavaScript.

### Wrap-up


If you want to explore functional programming, both JavaScript and Ruby are good candidates. They both have their goods and bads. Up to now, I've only used Ruby, but JavaScript certainly has its benefits, and exposure to both balances out my understanding.

I hope that, if you were curious about functional programming before, this was a helpful read. If you're a functional programmer, and I got something wrong, please let me know…I'm still learning. For instance, I now better understand how recursive processes differ from linear recursive processes.
