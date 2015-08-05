---
layout: post
title: Disable Your Links, or Gate Your Functions?
type: post
published: true
status: publish
categories:
- Functional Programming
tags:
- JavaScript
author: Dan Bernier
date: 2010-07-01 19:02:18.000000000 -04:00
---

It's pretty common to disable links and buttons that cause updates, so those updates don't happen twice, and re-enable them when the update has finished.

At work, our app's links are usually wired to javascript functions that use jQuery to scrape the form data and post it to web services via ajax.  We normally disable links and buttons something like this:

{% highlight js linenos %}
var updateLink = $('#updateLink');  // Find the link.
updateLink.click(function() {       // When it's clicked...
   updateLink.disable();            // disable it...
   ajax({
      data: getFormData(),          // ... & send the form data
      url: 'http://someWebService', // to some web service.
      success: function(results) {  // When the service
         if (results.hasErrors) {   // finishes,
            showErrors(results);    // show any errors,
            updateLink.enable();    // and enable the link
         }                          // so they can try again.
      }
   });
});
{% endhighlight %}

We added those enable() and disable() functions to jQuery -- they just add or remove the `disabled` attribute from whatever they're called on.  But it seems Firefox doesn't support `disabled` on anchor tags, like IE8 does, so we couldn't stop the repeat-calls that way.

We got to thinking, what if the link _always_ called its javascript function, but the function could turn itself off after the first call, and back on after a successful ajax post?  That led to this:

{% highlight js linenos %}
function makeGated(fn) {
   var open = true;
   var gate = {
      open: function() { open = true; }
      shut: function() { open = false; }
   };

   return function() {
      if (open) {
         fn(gate);
      }
   };
}
{% endhighlight %}

makeGated takes your function, and wraps it in another function, a gate function (it "makes your function a gated function").  When you call the function it creates, it will only call your function if the gate is open -- which it is, at first. But then, your function can decide whether to close the gate (that's why the gate is passed to your function).  You could use it like this:

{% highlight js linenos %}
var updateLink = $('#updateLink');  // Find the link.
updateLink.click(
   makeGated(function(gate) {       // When it's clicked...
      gate.shut();                  // shut the gate...
      ajax({
         data: getFormData(),       // ...same as before...
         url: 'http://someWebService',
         success: function(results) {
            if (results.hasErrors) {
               showErrors(results);
               gate.open();  // Open the gate
                             // so they can try again.
            }
         }
      });
   }));
{% endhighlight %}

We dropped this in, and it worked pretty much as expected: you can click all you want, and the update will only fire once; when the update completes, it'll turn back on.

The downside? Since it doesn't disable the link, the user has no idea what's going on.  In fact, since the closed-gate function finishes so quickly, it seems like the button's not doing anything at all, which might even make it look broken.

So we chucked it, and hid the links instead. It's not as nifty, and it's not reusable, but it's clear enough for both end-users and programmers who don't grok higher-order functions.  Even when you have a nice, flexible language, and can make a sweet little hack, it doesn't mean the dumb approach won't sometimes win out.
