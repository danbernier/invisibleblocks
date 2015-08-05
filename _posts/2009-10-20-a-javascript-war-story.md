---
layout: post
title: A JavaScript War Story
type: post
published: true
status: publish
categories:
- Functional Programming
- Programming
tags:
- HTML
- JavaScript
- scheme
author: Dan Bernier
date: 2009-10-20 22:03:46.000000000 -04:00
comments:
- author: Jordi
  content: "Very nice description of a very useful higher-order function and how functional
    programming can be applied in real life. I have made similar functions in a previous
    job as well.\r\n\r\nWhat I don't really understand is why you would need to redraw
    everything when the window resized. It seems to me like the JavaScript generates
    the HTML and as we all know, the browser takes care of how that should look when
    the window is resized. It seems to me that if you are generating good HTML, you
    should not have to worry about this. Furthermore, wouldn't it have been a lot
    easier to just tell your users to not resize their browser windows all the time
    or to make a 'refresh' button that they can press after they're done resizing.
    Your final solution is very elegant, but if you spent a lot of time thinking about
    this, I can't help but wonder if it was worth it."
  date: '2009-10-21 05:25:48'
  author_email: jbieger@gmail.com
- author: Dan Bernier
  content: "Jordi,\r\n\r\nYeah, we probably could have generated better, more liquid
    HTML.  When we built the original report, we just made sure it looked good enough
    in IE6 (our clients were large corporations - their IT departments installed IE6
    and locked down the machine).  When we got to the report preview, we needed it
    to match the real report's HTML.  At the time, between a whole redesign of the
    report HTML, and throwing in delay(), we chose the latter.\r\n\r\nBesides, if
    we'd had better HTML, there'd be no war story.  :)"
  date: '2009-10-21 07:54:59'
  author_email: danbernier@gmail.com
- author: uberVU - social comments
  content: |-
    <strong>Social comments and analytics for this post...</strong>

    This post was mentioned on Reddit by Jack9: Nice solution,...
  date: '2009-10-21 15:43:02'
  url: http://www.ubervu.com/conversations/invisibleblocks.wordpress.com/2009/10/20/a-javascript-war-story/
---

_What follows is an account from the author's experience.  Some details have been changed for the usual reasons, and a poor memory has fuzzed out the rest._

_**UPDATE:** it [turns out](http://www.reddit.com/r/javascript/comments/9w53i/a_javascript_war_story/c0eqxrd) the technique described below is known as [debouncing](http://en.wikipedia.org/wiki/Switch#Contact_bounce).  What an awesome name!_

My last job was for a company that made case-management software.  With this software, you could track all kinds of data about your case: you could categorize it, sub-categorize it, say where and when it happened, note whether it was still open, track who was responsible...all kinds of stuff, great for data fiends.

One of our customers' favorite features was the reports, and they were pretty spiffin'.  But, not being ones to rest on our laurels, we were adding pivot-table reports, so you could count the number of cases, grouped by any criteria you wanted.  The input screen let the customer pick their pivot criterion, and which criteria they wanted as columns, for sub-counts.  We struggled to name these UI fields -- something lucid, something explanatory, something _evocative_ -- something to make them understand what kind of report they were in for.  After a while, we decided to just _show_ them: when they changed their pivot criterion, we'd run some javascript to render a skeleton report, same as the real report, but minus the data.  It would save them time, and save our servers.

The javascript was pretty involved.  It had to generate the same HTML as we did for the pivot table, which meant it had to know (or make up) values for each criterion, like all the case categories and sub-categories, and which sub-categories belonged to which categories.  And we let the customers pivot on up to THREE, count 'em, different criteria.  And it had to happen each time the user picked different pivot criteria.  It took a few tricks, but we got it working.  It ran slowly, maybe a few seconds, but it was quick enough, probably, especially once we threw in a little "please wait" spinner.  Then we realized we needed to re-render whenever the window resized.

No biggie, I thought, and I quickly added `window.onResize(reportPreview);`.  It worked great, except it re-rendered the report with every pixel-wide movement of the mouse, as the window was dragged to new widths and heights.  Calling a function, one that runs for a few seconds, _a hundred times_ in the time it took to widen the browser an inch, meant a locked browser.  It meant "time to get more coffee," and after, "time to fix the bug."

I knew we could delay calling `reportPreview`, but we only wanted to delay it when the window was being resized -- when the user changed the columns, there was no reason to wait.  I was sure `window.setTimeout()` would do what we needed, but I didn't want to muck up `reportPreview()` with it.

I'd been reading [The Little Schemer](http://www.amazon.com/gp/product/0262560992?ie=UTF8&tag=invisblock-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0262560992) lately, and noticing some striking similarities between javascript and scheme: first-class functions, and higher-order functions that take functions as arguments, and return other functions as values.  It was fun reading, with its strange teacher-student dialog style.  The material was better than brainteasers, and I knew it would make me a better programmer down the road, but I didn't think of it as relevant to the day-job, as...applicable.

Then I realized higher-order functions were a way out of this.  I could write a function, `delay`, that would wrap one long-running, slow-poke function in _another_ function: an intermediary that you could call as many times a second as you wanted, but it would only call the slow-poke once things had settled down.  `delay` would let us keep `setTimeout` out of `reportPreview`.  Something like this:

{% highlight js linenos %}
function delay(millis, slowPoke) {
    var timeoutId = undefined;

    // This is the intermediary.  Call it lots, it won't hurt.
    return function() {
        if (timeoutId) {  // If we're waiting...
            clearTimeout(timeoutId); // re-start the clock.
        }
        timeoutId = window.setTimeout(slowPoke, millis);
    }
}
{% endhighlight %}

The first time you call the intermediary, it tells the window to call `slowPoke` after a bit, but every time you call it after that, it starts the clock over.  It's like when you're in a five-minute time-out, and you start acting up after only three, so your mom says "Ok, buster, another five minutes."

{% highlight js linenos %}
var fiveMinutes = 5 * 60 * 1000;
var screamAndShout = delay(fiveMinutes, function() {
    getBackToPlaying();
});

screamAndShout(); // Aw nuts, I'm in time-out.

// I'll be good for as long as I can, but...
screamAndShout(); // dang, five MORE minutes!
{% endhighlight %}

Once `delay` was in place, running `reportPreview` when the window was resized was no problem.

{% highlight js linenos %}
function reportPreview() {
    // recursion, DOM manipulation, insanity...
}
columnPicker.onChange(reportPreview);
window.onResize(delay(100, reportPreview));
{% endhighlight %}

After testing, we found that delaying it for 100 milliseconds made all the difference in the world.

_Do you have a war story?  Share it, and start the healing: tell a short one in the comments, or link to a longer one on your own damn blog._
