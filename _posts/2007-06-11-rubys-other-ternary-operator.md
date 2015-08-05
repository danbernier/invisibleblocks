---
layout: post
title: Ruby's other ternary operator
type: post
published: true
status: publish
categories: []
tags:
- Ruby
author: Dan Bernier
date: 2007-06-11 23:02:27.000000000 -04:00
comments:
- author: Reg Braithwaite
  content: "This is a well known Ruby trick, but it is not exactly the same thing
    as the ternary operator. Let's compare:\r\n\r\na ? b : c\r\n\r\nand\r\n\r\n(a
    &amp;&amp; b) || c\r\n\r\nThe former gives b whenever a is truthy and c otherwise,
    always. So if a == true, b == nil, and c == 'cee-threepio', (a ? b : c) =&gt;
    nil.\r\n\r\nBut (a &amp;&amp; b) || c =&gt; 'cee-threepio' for the same values.\r\n\r\nI
    prefer this form as well, but only when I know that the value of 'b' is guaranteed
    to be truthy."
  date: '2007-06-12 06:52:47'
  url: http://weblog.raganwald.com/
  author_email: raganwald+tickle@gmail.com
- author: Simen
  content: "You don't need the parantheses around your third and fourth lines. It
    works anyway:\r\n\r\n<code>irb(main):001:0&gt; a = true ? \"a\" : \"b\"\r\n=&gt;
    \"a\"\r\nirb(main):002:0&gt; b = false ? \"a\" : \"b\"\r\n=&gt; \"b\"\r\nirb(main):003:0&gt;
    a = true &amp;&amp; \"a\" || b\r\n=&gt; \"a\"\r\nirb(main):004:0&gt; b = false
    &amp;&amp; \"a\" || b\r\n=&gt; \"b\"\r\n</code>\r\n\r\nHowever, if you change
    &amp;&amp; to \"and\", you start running into dark corners of operator precedence:\r\n\r\n<code>irb(main):001:0&gt;
    a = true ? \"a\" : \"b\"\r\n=&gt; \"a\"\r\nirb(main):002:0&gt; b = false ? \"a\"
    : \"b\"\r\n=&gt; \"b\"\r\nirb(main):003:0&gt; a = true and \"a\" || b\r\n=&gt;
    \"a\"\r\nirb(main):004:0&gt; b = false and \"a\" || b\r\n=&gt; false\r\n</code>\r\n\r\nAnd
    why do you put \"var\" before user_name? Ruby isn't javascript."
  date: '2007-06-12 07:04:04'
  url: http://metametamorfosen.wordpress.com/
  author_email: dupe-2-toalett@gmail.com
- author: Dan Bernier
  content: "Reg, you're right, I didn't think of that.  I'll have to scan through
    the areas I've used this, and see whether that could happen...\r\n\r\nSimen,\r\n&gt;
    You don't need the parantheses around your third and fourth lines.\r\n\r\nYeah,
    I included them to emphasize the grouping, for clarity.\r\n\r\n&gt; And why do
    you put \"var\" before user_name? Ruby isn't javascript.\r\n\r\nYou're right...I
    think that 'var' snuck in from the javascript I've been doing, and the Scala I've
    been reading about."
  date: '2007-06-12 07:59:38'
  author_email: danbernier@gmail.com
- author: raichu
  content: i think that's how python programmers tried to get the convenience of the
    ternary operator into their programming language before they got their chainable
    syntax in version 2.5.  back then, their version also failed when the variable
    wasn't "truthy-worthy".
  date: '2007-06-14 07:35:09'
  author_email: raichu@raichu.raichu
- author: she
  content: "actually i think this is rather ugly\r\n\r\nand ternay operator is ugly
    too but at least used often enough to know it\r\nand sometimes it reduces a few
    lines of code"
  date: '2008-03-12 05:47:37'
  author_email: she@hot.com
- author: shawn
  content: "you cant do this if the action  you want done is a binary opertor, ie
    only test if a test operator was given:\r\n(action ? params[:action] == action
    : true)"
  date: '2008-09-26 23:30:02'
  author_email: instigatorirc@gmail.com
- author: Otto
  content: I think the ternary operator sucks. Ok, it's fairly easy to understand
    a, b and c, but when that involves more complex expressions, it's a pain. And
    there are those who like to put a ternary operator inside another operator...
  date: '2009-06-23 21:47:04'
  author_email: ottoptr@gmail.com
- author: Programmer
  content: Do you honestly think your expression is more readable than the ternary
    operator which is in use in many other languages?  The point is to write re-usable
    code that can be read and understood clearly, not to make things harder to read
    because you want to show you are smarter.
  date: '2010-01-05 12:31:15'
  url: http://programmer.com
  author_email: me@programmer.com
- author: Colin Bartlett
  content: "\"This is a lot like the a ||= 'a' trick,\r\n which expands to a = a ||
    'a', \r\n giving the variable a default value,\r\n if it's not already initialized.\"\r\n\r\nNot
    precisely correct - using (unnecessary) brackets to make things clear:\r\n  whereas
    operators like  x += y  expand to  x = (x + y)\r\n  the operator  x ||= y  expands
    to  x || (x = y)\r\n  and the operator  x &amp;&amp;= y  expands to  x &amp;&amp;
    (x = y)\r\n\r\nRick De Natale has a good post on this here:\r\nhttp://talklikeaduck.denhaven2.com/2008/04/26/x-y-redux"
  date: '2010-03-22 11:22:11'
  author_email: colinb2r@gmail.com
- author: Dan Bernier
  content: "Colin, thanks for clarifying.  So, when x has a value, it's basically
    a no-op?\r\n\r\nFunny, it expands to almost the opposite this JavaScript idiom:\r\n\r\n```javascript\nfunction
    foo(x) {\r\n    x = x || \"default\";\r\n}\r\n```\n"
  date: '2010-03-22 13:06:24'
  author_email: danbernier@gmail.com
- author: Ruby Ternary Operations « OmegaDelta
  content: "[...] Ruby's other Ternary Operator [...]"
  date: '2010-12-17 00:46:17'
  url: http://omegadelta.net/2010/12/17/ruby-ternary-operations/
- author: wyderp
  content: these discussions should also include performance considerations. if you're
    like me and work on back end in a production environment you often have to use
    code that isn't pretty or easy to maintain but runs fast.
  date: '2011-10-27 07:52:54'
  author_email: bill.dwyer@associates.dhs.gov
- author: Alfredo Amatriain
  content: "I confess I'm not too proficient with Ruby, but isn't your ternary example
    wrong? I think you're missing a couple \"=\" and they should be written like this:\r\n\r\na
    == true  ? 'a' : 'b' #=&gt; \"a\"\r\nb == false ? 'a' : 'b' #=&gt; \"b\"\r\n\r\nOf
    course I fully expect to be told why I'm wrong and how much I still have to learn
    :)"
  date: '2012-11-07 14:09:01'
  author_email: geralt@gmail.com
- author: Dan Bernier
  content: "No, I meant to use assignment (=), not equality testing (==). The effect
    I was after was to set a to \"a\", and b to \"b\".\r\n\r\nHere are some parentheses
    to clarify:\r\na = (true ? 'a' : 'b')  #=&gt; \"a\"\r\nb = (false ? 'a' : 'b')
    \ #=&gt; \"b\"\r\n\r\nDoes that help?"
  date: '2012-11-07 14:14:59'
  author_email: danbernier@gmail.com
- author: Dan Bernier
  content: "...and hey, we've ALL got a lot to learn. :)"
  date: '2012-11-07 14:15:37'
  author_email: danbernier@gmail.com
- author: amatriain
  content: Ah, I see. I got the associativity wrong. Thanks.
  date: '2012-11-07 14:17:22'
  author_email: geralt@gmail.com
- author: Programmer
  content: So, what is the code that runs the fastest?  How was this tested out?
  date: '2012-11-13 14:44:35'
  author_email: asucis2001@yahoo.com
- author: Dan Bernier
  content: I don't know which is faster, but I doubt it's an order-of-magnitude difference.
    This was an article about language expressivity, not performance, so I didn't
    worry about it.
  date: '2012-11-13 14:48:38'
  author_email: danbernier@gmail.com
---

This may be a well-know Ruby trick, but I thought I'd share it anyway.

Ruby has the ternary operator:

{% highlight ruby linenos %}
a = true  ? 'a' : 'b' #=> "a"
b = false ? 'a' : 'b' #=> "b"{% endhighlight %}

But it also has something else...

{% highlight ruby linenos %}
a = (true  && 'a') || b #=> "a"
b = (false && 'a') || b #=> "b"{% endhighlight %}

All statements in Ruby return the value of the last expression evaluated, so `true && 'a'` returns 'a', and the 'b' is ignored (via boolean short-circuiting).  `false && 'a'` evaluates to `false`, so Ruby moves on, and returns 'b'.

&nbsp;

This is a lot like the `a ||= 'a'` trick, which expands to `a = a || 'a'`, giving the variable a default value, if it's not already initialized.

If Ruby already has the ternary operator, why bother?  Personally, I find this form more natural (which surprised me, after years of using the ternary operator in Java and C#).  For some reason, it reads more like natural language to me.

{% highlight ruby linenos %}
user_name = (user.authenticated? && user.name) || 'guest'{% endhighlight %}

Does anyone else see it?

&nbsp;
