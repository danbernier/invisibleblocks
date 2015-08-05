---
layout: post
title: 'Continuations: a warm-up'
type: post
published: true
status: publish
categories:
- Functional Programming
tags:
- JavaScript
- Ruby
- scheme
author: Dan Bernier
date: 2008-03-13 16:53:12.000000000 -04:00
---

[Continuations](http://en.wikipedia.org/wiki/Continuation) and [continuation-passing style](http://en.wikipedia.org/wiki/Continuation-passing_style) (CPS) are introduced in [The Little Schemer](http://www.amazon.com/Little-Schemer-Daniel-P-Friedman/dp/0262560992), chapter 8, using collectors: functions that collect values, through being repeatedly redefined.  It was a tough chapter for me, but the idea is simple once you get it, so I'd like to leave some help for others.  I'll use Ruby for the examples, with some JavaScript and Scheme at the end.

In languages with first-class functions, you can assign functions to variables, and re-assign those variables.  Consider this Ruby example:
{% highlight ruby linenos %}
func = lambda { |x| puts x }

['a', 'b', 'c'].each { |ch|
    old_func = func
    func = lambda { |x| old_func[x + ch] }
}

func['d']  #=> prints 'dcba'{% endhighlight %}
By re-defining `func` in terms of `old_func`, we're building up a recursive computation.  It's like normal recursion, but approached from the other side -- without explicit definitions.  Since a Ruby function is a closure, it remembers the value of the variables in scope when it was created; each layer of this recursion holds its own value for `ch` and `old_func`.  When we call the last `func`, it sees `ch` = 'c' and `x` = 'd'.  It concatenates them, and calls its version of `old_func`...which sees `x` = 'dc' and `ch` = 'b', concatenates them, and passes it to _its_ `old_func`, and so on.In fact, if we wrote it like this, the execution of all those lambdas would be exactly the same:
{% highlight ruby linenos %}
func_puts = lambda { |x| puts x }
func_add_a = lambda { |x| func_puts[x + 'a'] }
func_add_b = lambda { |x| func_add_a[x + 'b'] }
func_add_c = lambda { |x| func_add_b[x + 'c'] }
func_add_c['d']  #=> prints 'dcba'{% endhighlight %}
We could calculate factorials this way:
{% highlight ruby linenos %}
def factorial(n, func)
    if n == 1
        func[1]
    else
        factorial(n - 1, lambda { |i| func[i * n] })
    end
end
factorial(3, lambda { |fact| puts fact })  #=> prints 6{% endhighlight %}

1. On the first call to factorial, `n` = 3, and `func` just prints its argument.  But `func` isn't called yet...since `n` isn't 1, we recurse with `n - 1` = 2, and a new function that calls `func` with its argument `i` times 3.
2. On the recurse, `n` = 2, and `func` calls the original printer `func `with its argument `i` times 3.  Since `n` still isn't 1, we recurse again, with `n - 1` = 1, and a new function that calls our `func` with _its_ argument `i` times 2.
3. On the final round, `n` = 1, so we (finally!) call `func` with 1, which...
4. ...calls the previous `func` with 1 * 2, which...
5. ...calls the _original_ `func` with (1 * 2) * 3, which...
6. prints 6.

As `factorial` recurses, it builds up a recursive tower of `func` calls.  In `factorial`'s base case, the last (and outermost) `func` is called, and we begin to climb down the `func `tower, to its bottom floor, the original `func`.  It's recursion in two directions.

In case Ruby isn't your favorite language, here are versions in JavaScript and Scheme:

{% highlight js linenos %}
function factorial(n, func) {
    if (n == 1)
        func(1)
    else
        factorial(n - 1, function(i) {
            func(n * i)
        });
}

factorial(3, function(fact) { print(fact) }){% endhighlight %}
<pre>; Too bad WordPress doesn't format Scheme or Lisp!
(define factorial
  (lambda (n func)
    (cond ((= n 1) (func 1))
          (else (factorial (- n 1)
                           (lambda (i) (func (* n i))))))))

; Here, the original func is just an identity function.
(factorial 4 (lambda (fact) fact))</pre>

Once this is clear, you can see many other applications:

* You could find all the even numbers in a list: instead of passing a number to `func`, pass the list of even numbers, and add each even number in.
* You could separate the numbers into evens and odds: instead of passing just one list to `func`, pass two lists, for evens and odds, and add each number to the correct list.
* You could separate any list of items by _any_ criteria:  instead of hard-coding "is even?" into the function, pass a predicate function.  (Maybe you want to extract all occurrences of 'tuna' from a list of words.)

That should be enough of a warm-up for chapter 8.  See you in chapter 9, when they derive the [Y-combinator](http://en.wikipedia.org/wiki/Y_combinator)!
