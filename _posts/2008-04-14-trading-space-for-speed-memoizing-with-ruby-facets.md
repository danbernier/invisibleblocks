---
layout: post
title: 'Trading Space for Speed: Memoizing with Ruby Facets'
type: post
published: true
status: publish
categories:
- Functional Programming
- Programming
tags:
- FacetsTour
- Ruby
- RubyFacets
author: Dan Bernier
date: 2008-04-14 07:37:26.000000000 -04:00
comments:
- author: Magnus Holm
  content: 'Why not rewrite Memoized like this: http://pastie.textmate.org/180528?'
  date: '2008-04-14 11:39:52'
  url: http://judofyr.net
  author_email: judofyr@gmail.com
- author: Dan Bernier
  content: "@Magnus, that's a much nicer version of Memoized, I should have thought
    of that.  All I can say in my defense is that I was thinking more about the article
    and example, and less about the ruby code itself.  But I think the points I raised
    are still valid:\r\n\r\n- \"we need to track our previous results in a separate
    variable\"  Still true.\r\n\r\n- \"the memoization code is mixed up with the actual
    calculation (the part we care about)\"  Still true, but barely.  This is a great
    example of how ruby can redeem bad code.\r\n\r\n- \"we can't easily use it with
    other functions\"  You can use the <i>pattern</i> in other classes, but not the
    code itself.\r\n\r\n- \"the pattern only works for functions of one argument\"
    \ Still true.  Of course, if you look at the facets source, you can see this is
    pretty easy anyway, since ruby lets us use Arrays as Hash keys.\r\n\r\nFacets
    wraps it up so nicely, I can't think of a good reason to avoid it, unless I'm
    explicitly trying to avoid dependencies."
  date: '2008-04-14 13:15:12'
  author_email: danbernier@gmail.com
- author: gem install facets « Tecnogemas
  content: '[...] Hoy en día encuentro 2 tendencias, a los que les vale optimizar
    y los que quieren pero frecuentemente caen en optimizaciones absurdas. Pocas veces
    uno puede decir "haz esto"; sin poner una lista interminable de cuando sí, cuando
    no. Pero hoy les digo que pueden hacer que sus funciones recuerden. [...]'
  date: '2008-04-16 13:27:46'
  url: http://tecnogemas.wordpress.com/2008/04/16/gem-install-facets/
- author: David James
  content: "You might also want to take a look at 'memoize' as mentioned in the Pickaxe:\r\nhttp://raa.ruby-lang.org/project/memoize/"
  date: '2009-10-18 02:21:40'
  url: http://djwonk.com
  author_email: davidcjames@gmail.com
- author: Ruby Convention
  content: You know the Ruby convention for indenting is 2 spaces?
  date: '2009-10-18 02:25:34'
  author_email: davidcjames@gmail.com
- author: Dan Bernier
  content: Indeed I do.  My editor at the time, programmer's notepad 2, didn't allow
    different tab widths for each language, so I left it at 4, to match all the other
    languages I often use.  Conventions are great, but they're just that.
  date: '2009-10-21 07:59:17'
  author_email: danbernier@gmail.com
---

Recently, I talked about a [faster, cheaper way]({% post_url 2008-03-22-a-faster-cheaper-fibonacci-definition %}) to calculate [Fibonacci](http://en.wikipedia.org/wiki/Fibonacci_number) numbers.  One of the optimizations I made was to remember the value of each Fibonacci number:  since F(7) is always 13, instead of recalculating it each time N=7, we can stuff _7 -> 13_ into a look-up table for future reference. The function builds up a cheat-sheet, to avoid doing the re-work.  It remembers.

This is called [memoization](http://en.wikipedia.org/wiki/Memoization), and it's a nice way to trade memory for performance.  But it only works when the function always returns the same answer for a given set of arguments -- otherwise it's first-in wins, forever.  This property of a function, returning the same answer for the same args, is called [referential transparency](http://en.wikipedia.org/wiki/Referential_transparency_%28computer_science%29).

#### A Sample Implementation


There are lots of ways you could memoize a function.  Hash tables are a natural choice, since they map a key to a value, just like functions map arguments to a value.  Even if you implement it differently, a hash table is a good working model for memoization.

Let's briefly consider factorials.  The regular version:

{% highlight ruby linenos %}
class Unmemoized
    def factorial(n)
        puts n
        if n < 1
            1
        else
            n * factorial(n-1)
        end
    end
end

unmemoized = Unmemoized.new

5.downto(1) { |i| puts "\t#{unmemoized.factorial(i)}" }{% endhighlight %}

...and the memoized version:

{% highlight ruby linenos %}
class Memoized
    attr_reader :factorial_memo
    def initialize
        @factorial_memo = {}
    end

    def factorial(n)
        puts n
        unless @factorial_memo.has_key? n
            if n < 1
                @factorial_memo[n] = 1
            else
                @factorial_memo[n] = n * factorial(n-1)
            end
        end

        @factorial_memo[n]
    end
end

memoized = Memoized.new

5.downto(1) { |i| puts "\t#{memoized.factorial(i)}" }

puts memoized.factorial_memo.inspect{% endhighlight %}

Printing the hashtable is especially telling:  `{5=>120, 0=>1, 1=>1, 2=>2, 3=>6, 4=>24}` It reads like a look-up table for factorials.

#### Memoization in Facets


As relatively easy as that example is, it has its drawbacks: we need to track our previous results in a separate variable, the memoization code is mixed up with the actual calculation (the part we care about), we can't easily use it with other functions, and the pattern only works for functions of one argument.  [Facets](http://facets.rubyforge.org/) makes memoization trivial, and removes all these issues.

{% highlight ruby linenos %}
require 'facets/memoize'

class FacetsMemoized
    def factorial(n)
        puts n
        if n < 1
            1
        else
            n * factorial(n-1)
        end
    end

    memoize :factorial # <= HINT
end

facets_memoized = FacetsMemoized.new

5.downto(1) { |i| puts "\t#{facets_memoized.factorial(i)}" }{% endhighlight %}

In case you missed it, this is just like `Unmemoized` above, except we added line 13, `memoize :factorial`...that's it.  Just like `attr_reader` and friends, you can pass a list of symbols to `memoize`, and it'll work on functions with any number of arguments:

{% highlight ruby linenos %}
require 'facets/memoize'

class MemoizedMath
    def add(n, m)
        n + m
    end
    def mult(n, m)
        n * m
    end
    memoize :add, :mult
end{% endhighlight %}

#### When You Might Use Memoization, and What to Avoid


There are a number of places where this is useful: calculating a value by [successive approximation](http://mitpress.mit.edu/sicp/full-text/sicp/book/node12.html), finding the path to the root node in an immutable tree structure, finding the _N_th number in a recursively-defined series, even simple derived values (like 'abc'.upcase).  In general, a function is a good candidate if it only looks at its arguments (no global, class, or member variables, no files or databases) -- especially if those arguments are immutable.

Relying on side-effects (printing to standard out, writing to a database or file, or updating a variable) in memoized methods is a bad idea: they'll only happen the first time your method is called with those arguments, which is probably not what you intend. (Unless you're printing the arguments to illustrate how memoizing works.) On the other hand, relying on side-effects [is generally a bad idea](http://www.google.com/search?q=favor+immutability) anyway. Even if you don't use a functional programming language, you can still benefit from minimizing state changes.

#### Further Reading


If memoization sounds interesting to you, you might like Oliver Steele's article about [memoizing JavaScript functions](http://osteele.com/archives/2006/04/javascript-memoization).  If you're curious about immutability, you might like this [Joshua Bloch interview](http://www.artima.com/intv/blochP.html).  If you're interested in functional programming, there are worse places to start than the excellent [Structure and Interpretation of Computer Programs](http://mitpress.mit.edu/sicp/full-text/book/book.html).  And of course, there's more where that came from, in [Ruby Facets](http://facets.rubyforge.org/).
