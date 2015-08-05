---
layout: post
title: Long-running averages, without the sum of preceding values
type: post
published: true
status: publish
categories:
- Programming
tags:
- average
- c#
- math
- Ruby
author: Dan Bernier
date: 2008-07-30 13:54:42.000000000 -04:00
comments:
- author: Bill
  content: "Very cool solution to the problem - thanks for sharing your thoughts.\r\n\r\nOut
    of curiosity to see how exact this method is I figured I would do a very simple
    test.  Both examples have an average of 2 after 200 iterations but the 201st iteration
    passes in a value of x=4 - the two resultant averages are very, close to each
    other (I imagine the difference is due to the calculator I used forcing a rounding
    on me) - I just figured I would post it here for consideration:\r\n\r\nTraditional
    Result: (404/201)\r\n2.0099502487562189054726368159204\r\n\r\nYour Algorithim:
    2 + (2/201)\r\n2.009950248756218905472636815920398\r\n\r\nAgain, thanks for sharing.
    \ I like it and it seems like an easier way, in general, to compute a running
    average."
  date: '2008-07-30 16:04:38'
  url: http://cf-bill.blogspot.com
  author_email: bill.rawlinson@gmail.com
- author: Dan Bernier
  content: Whoa!  That aspect of the problem didn't occur to me, but I don't think
    I'd have expected that result, even if it had.  I guess I can deal with only-accurate-to-30-decimal-places.  Thanks!
  date: '2008-07-30 16:16:24'
  author_email: danbernier@gmail.com
- author: Paul
  content: If you replace your count with a weight factor you've got an exponential
    average (http://en.wikipedia.org/wiki/Exponential_average#Exponential_moving_average).  No
    chance for overflow but current values have more weight in the average that prior
    values.
  date: '2008-07-30 16:28:23'
  author_email: MorganPaulW@Hotmail.com
- author: Dan Bernier
  content: "Paul, thanks for pointing that out...especially since it links to <a href=\"http://en.wikipedia.org/wiki/Triangle_number\"
    rel=\"nofollow\">Triangle numbers</a>, which I'd thought about, but didn't know
    had a name.\r\n\r\nEvery time I drive my Prius, I want it to give me a weighted
    running average of my mileage, instead of the straight running average.  I care
    more about my mileage over this tank of gas, or the past few weeks, than I do
    about 4 months ago.  I'll send this to Toyota.  :)"
  date: '2008-07-30 16:39:01'
  author_email: danbernier@gmail.com
- author: Drew
  content: "I had thought of doing this, but I was always worried that in a long-running
    system you'd reach a point where a (x - average)/count = 0 due to precision problems.
    \ Essentially each iteration becomes less precise until you've lost all your precision.
    \ Then it will never change even if the next (10 * count) values of x are (average
    + 1)\r\n\r\nI suppose as long as this takes a few orders of magnitude longer than
    the sum version, then it is useful."
  date: '2008-07-30 17:50:35'
  author_email: drew.haven@gmail.com
- author: Dan Bernier
  content: "@Drew\r\n\r\nYou mean, as count gets really huge, (x-average)/count tends
    towards 0, and eventually the precision will bottom out, right?  I hadn't thought
    of that, good point.  I tried it out in ruby -- a really tiny x-average, and count
    is .Net's long.MaxValue, 263, or ~9 quintillion.\r\n\r\n1.0e-300 / (2 ** 63)  #-&gt;
    1.08417765323403e-319\r\n\r\nSo there's enough precision (in ruby, on WinXP 32,
    at least) to last through all that.  I guess that's the few orders of magnitude
    difference.  :)"
  date: '2008-07-30 18:24:14'
  author_email: danbernier@gmail.com
- author: Guy Hurst
  content: "I felt drawn to work on this problem before seeing your solution. (I tend
    to like such challenges). As I worked on it, I realized that it was just an exercise
    in transferring the use of precision on the left side of the decimal point to
    the right side. Really, what is the difference between multiplying two numbers
    for a large result and dividing two numbers for a tiny result? The computer is
    just bit shifting in the opposite direction, now that I think about it.\r\n\r\nSo,
    in the end, it is all about precision, whether during multiplication or division.
    You started out trying to keep things within 32 bits, but notice how you resolved
    the division precision with 63 :)  We will run into a similar situation if the
    count exceeds that as well.\r\n\r\nIn any case, thank you for the stimulating
    post!"
  date: '2008-07-31 01:41:15'
  author_email: gnhurst@gmail.com
- author: Stoat
  content: "You're not summing an int, or a long, you are summing a float (http://steve.hollasch.net/cgindex/coding/ieeefloat.html).
    \ If you use a double-precision one, this will not top-out at 2^63, but roughly
    2^1023.  Your algorithm will top-out much faster than this, as it will break horribly
    when your integer 'count' overflows 2^32 and your reasoning for ignoring this
    depends on the values of x being larger than 1, and the value of sum also being
    an int. Finally, your algorithm is susceptible to ignoring any total contribution
    from small numbers that are not near the mean (summation underflow). Do everything
    in double precision, and be careful, and you'll be able to make it run forever.
    \ See http://en.wikipedia.org/wiki/Kahan_summation_algorithm for some ideas.\r\n\r\nStoat."
  date: '2008-07-31 06:00:34'
  author_email: anj@anjackson.net
- author: Dan Bernier
  content: 'Stoat, witness the sloppy thinking:  I was actually thinking of summing
    ints, not floats, when I started the problem.  Then, when integer division caused
    wicked rounding errors, I thought "oh, right," and made them floats, forgetting
    about the change in range that meant.  Maybe I should have phrased the whole thing
    as just a mental exercise, with silly constraints, and a proof of correctness
    in code.  I trust no one''s going to drop this code into production soon.'
  date: '2008-07-31 07:56:08'
  author_email: danbernier@gmail.com
- author: Jim McCusker
  content: "This is a great way of keeping running averages. I've used this for computing
    cluster centroids, since the average *is* the centroid, it's easier to keep the
    count, as you said. We worked with floats exclusively, as the values were multidimensional
    vectors converted from various data types. There's a variation on this that can
    be used to recompute the standard deviation from the new mean by tracking the
    power sum average, but you do need to recompute the sums:\r\n\r\n(python)\r\n\r\ncount=0\r\nmean=0\r\npwrSumAvg=0\r\nstdDev=0\r\n\r\ndef
    update(x):\r\n    count += 1\r\n    mean += (x-mean)/count\r\n    pwrSumAvg +=
    ( x*x - pwrSumAvg) / count\r\n    stdDev = sqrt(pwrSumAvg*count - mean*count)
    / (count*(count-1))"
  date: '2008-07-31 14:39:03'
  url: http://subluminal.wordpress.com
  author_email: mccusker@gmail.com
- author: Running Standard Deviations « Subluminal Messages
  content: "[...] 31, 2008   My friend Dan at Invisible Blocks came up with a great
    way to compute a long-running mean from the count and [...]"
  date: '2008-07-31 15:53:16'
  url: http://subluminal.wordpress.com/2008/07/31/running-standard-deviations/
- author: Top Posts « WordPress.com
  content: "[...]  Long-running averages, without the sum of preceding values Here's
    a little lunch-time diversionary math.  Suppose you want a function that takes
    a number, and returns the [...] [...]"
  date: '2008-07-31 20:01:55'
  url: http://botd.wordpress.com/2008/08/01/top-posts-826/
- author: Guy
  content: "Could you please explain how you came to the expression:\r\n\r\naverage
    += (x - average) / count ?\r\n\r\nfrom the brute-force version:\r\n\r\naverage(n)
    = ( sum(n-1) + x ) / ( count(n-1) + 1 )\r\n\r\nThanks!"
  date: '2008-08-01 03:29:23'
  author_email: Guy.Eschemann@gmail.com
- author: jonathantan86
  content: "The math:\r\n\r\nLet a := old average, a' := new average\r\nLet n := *new*
    count\r\nLet x := value just inserted\r\n\r\nFrom brute-force:\r\n\r\na' = (a(n-1)
    + x) / n [a * (n-1) is the sum of the n-1 numbers]\r\n= a(n-1)/n + x/n\r\n= an/n
    - a/n + x/n\r\n= a + (x-a)/n\r\n\r\nwhich is average += (x - average)/n."
  date: '2008-08-01 05:27:11'
  author_email: jonathantan86@gmail.com
- author: Dan Bernier
  content: '@Guy, I think jonathantan86 did it just fine.  Though I have to admit,
    I didn''t go through all that rigor, going from brute force to new equation...I
    kind of felt my way through the problem, formalized the new version in code, and
    tested it against the brute force version.  What can I say?  <a href="http://www.oopsla.org/2005/ShowEvent.do?id=403"
    rel="nofollow">Programming is a Good Medium for Expressing Poorly Understood and
    Sloppily Formulated Ideas.</a>'
  date: '2008-08-01 08:39:17'
  author_email: danbernier@gmail.com
- author: annonymous
  content: "Thanks for the solution\r\n\r\nYou can also use boost/accumulators with
    tag::mean(immediate):\r\n\r\n#include \r\n#include \r\n#include \r\n\r\n#include
    \r\n#include \r\n#include \r\n\r\nnamespace bacc = boost::accumulators;\r\n\r\nvoid
    test1()\r\n{\r\n    int i, j;\r\n    typedef int16_t mytype;\r\n    bacc::accumulator_set<mytype,
    bacc::stats > bm;\r\n    for(i = 0; i < 100; i++) {\r\n\tfor(j = 0; j < 99; j++)
    {\r\n\t    bm(10000);\r\n\t}\r\n\tstd::cout << i << '%\\n';\r\n    }\r\n    std::cout
    << bacc::mean(bm) << '\\n';\r\n}\r\n\r\nvoid test2()\r\n{\r\n    int i;\r\n    typedef
    char mytype;\r\n    bacc::accumulator_set<mytype, bacc::stats > bm;\r\n    for(i
    = 0; i < 100; i++) {\r\n\tbm(i);\r\n\tstd::cout << 'bm: ' << bacc::mean(bm) <<
    '\\n';\r\n    }\r\n}\r\nvoid test3()\r\n{\r\n    int i;\r\n    typedef int64_t
    mytype;\r\n    bacc::accumulator_set<mytype, bacc::stats > bm;\r\n    for(i =
    0; i < 100; i++) {\r\n\tbm(i);\r\n\tstd::cout << 'bm: ' << bacc::mean(bm) << '\\n';\r\n
    \   }\r\n}\r\n\r\nint main()\r\n{\r\n    std::cout << 'TEST 1\\n';\r\n    test1();\r\n
    \   std::cout << 'TEST 2\\n';\r\n    test2();\r\n    std::cout << 'TEST 3\\n';\r\n
    \   test3();\r\n    return 0;\r\n}"
  date: '2011-01-08 11:50:23'
  author_email: ab@invalid.com.moon
- author: annonymoous
  content: "Gah... Includes got removed...\r\n\r\nHere are the ones I provided:\r\n\r\niostream\r\nboost/cstdint.hpp\r\nboost/accumulators/accumulators.hpp\r\nboost/accumulators/statistics/mean.hpp\r\nboost/accumulators/statistics/stats.hpp"
  date: '2011-01-08 11:52:05'
  author_email: ab@invalid.com.moon
- author: Charles
  content: "You still have a failure area, and that is the count can overflow, you
    can do this by faking a running average.\r\n\r\ndouble avg;\r\nvoid update(double
    val) {\r\n    avg = (avg + val / 9) * .9;\r\n}\r\n\r\nThat will give a nice running
    average for a fast updating system, a nice \"health monitor\" of some procedure
    or temperature with jittery inputs.\r\n\r\nPlay with 9 and .9 till you get the
    responsiveness you desire :)"
  date: '2011-06-16 16:12:35'
  url: http://flvcomm.org
  author_email: charles@loneaspen.com
- author: Charles
  content: "Just a note about that routine....\r\n\r\navg = (avg + newval/A) * B;\r\n\r\nWhere
    B =  A / (A+1);  Choose A\r\n\r\nThis will amplify certain frequencies generated
    in the signal.  For fast update use A = .1;  For long use A=10 or more;"
  date: '2011-06-16 17:20:16'
  url: http://flvcomm.org
  author_email: charles@loneaspen.com
- author: moooeeeep
  content: 'Apparantly you have discovered that part of Welford''s algorithm to online
    compute the mean: http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#On-line_algorithm'
  date: '2012-03-14 09:51:21'
  author_email: skipjack@peru.com
- author: Charles
  content: Thanks...  I figured there was a name behind that one, I noticed it back
    in the early 1990's when writing some audio processing software that needed a
    frequency filter.   Random wave samples (white/pink noise) in, and you get a nice
    roar/boom around a certain frequency out.
  date: '2012-03-14 10:04:57'
  url: http://www.loneaspen.com
  author_email: charles@loneaspen.com
---

Here's a little lunch-time diversionary math.  Suppose you want a function that takes a number, and returns the average of all the numbers it's been called with so far.  Handy for continuously updated displays, that kind of thing.  Here's a method that will return this averaging function.
<pre>
private static Func MakeAverager()
{
    float sum = 0;
    int count = 0;
    return delegate(float x)
    {
        sum += x;
        count += 1;
        return sum/count;
    };
}
</pre>

It creates `sum` and `count` variables for the function to close over.  The function takes a number, `x`, and adds it to `sum`.  It increments `count`, and divides.  Pretty standard.

Now, let's get crazy, and pretend this code is going on [Voyager](http://voyager.jpl.nasa.gov/), and it'll be running for ever.  `sum` will get pretty high, right?  We'll blow through 2<sup>31</sup>, the upper-bound for .Net 32-bit ints.  Sure, we could make it a `long`, and go up to 2<sup>63</sup>, but that's not the point.  The point is, it'll eventually run out, because `sum` is too high.

I've been chewing on this brain-teaser for a while.  I knew there must be a way to calculate a long-running average without storing the sum and the count; it seems the average so far, and the count, should be enough, but I don't want to resort to `((average * count) + x) / count++`, because that's the exact same problem.  (Of course, `count` could still get so high it overflows, but that's somewhat less likely.  Hush, you.)

I finally sat down and figured it out.  The trick is, each successive x tugs your average up or down -- first by a lot, but by less over time.  With each x, the average gets harder to move:  the effect each new x has on the average is inversely proportionate to the count.  We can put it like this:
<pre>
average += (x - average) / count
</pre>

We tug average by `x - average`, the distance between them, scaled down by count.  Then, add that on to average (of course, if x < average, then x - average is negative, so it'll tug the average down).

Let's make a new averager.
<pre>
private static Func MakeNewAverager()
{
    float average = 0;
    int count = 0;
    return delegate(float x)
    {
        average += (x - average) / ++count;
        return average;
    };
}
</pre>

It works the same, but it'll take a lot longer for `count` to overflow than `sum`.

For the record, here's the ruby I used to sketch this idea out.  Of course, in ruby, this problem is even more bogus, because ruby's Bignum can handle any number that your machine has enough free RAM to store.  But still.

{% highlight ruby linenos %}
def make_averager
    sum, count = 0, 0
    lambda { |x|
        sum += x
        count += 1
        sum.to_f / count
    }
end

def make_sum_free_averager
    avg = 0.0
    count = 0
    lambda { |x|
        count += 1
        avg += (x - avg) / count
    }
end
{% endhighlight %}
