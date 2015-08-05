---
layout: post
title: Practical Applications of Browser DOM Hacking
type: post
published: true
status: publish
categories:
- Programming
tags:
- JavaScript
author: Dan Bernier
date: 2006-01-22 22:00:00.000000000 -05:00
comments:
- author: e40
  content: It would be nice if you put it all together and showed the final examples.  As
    is it, I find the info interesting, but have no idea how to really use it.
  date: '2006-01-27 11:04:00'
  url: http://www.blogger.com/profile/8323039
- author: Dan Bernier
  content: Yeah, I originally tried to get lots more sample JavaScript into the post,
    but Blogger does some weird parsing things when you go between Edit HTML, Compose,
    Preview, and Posted modes.  I'll try to get some samples hosted somewhere soon...I
    know I have the Table of Contents and the Image Auto Captioner built already.
  date: '2006-01-27 19:06:00'
  url: http://www.blogger.com/profile/6051054
- author: Dan Bernier
  content: e40, I posted some examples at http://www.myjavaserver.com/~danbernier/invisibleBlocks/domHacking/domHacking.html
    ...give them a look.
  date: '2006-03-07 11:36:00'
  url: http://www.blogger.com/profile/6051054
---

I've been talking about hacking the browser's DOM lately.  Now, here are some situations where this might be useful -- but I'll only lightly cover them, and leave further exploration up to you.  [Not because I'm trying to be clever and educational, but because Blogger strips out bunches of my HTML snips, even if I use escape chars.  If you have any suggestions, I'm all ears.]  Ok, practical applications of [new]({% post_url 2006-01-10-javascript-oo-and-function-pointers %}) [knowledge]({% post_url 2006-01-18-hacking-the-browsers-dom-for-fun %}), here we go!

### Generate a Table of Contents


Suppose we have some ordinary HTML:  some h1s, h2s, h3s, ps, and imgs.  Maybe we've thrown in some handy CSS, so it looks nice.  Now we want to generate a table of contents at the top of the page, so changes to the contents are automatically reflected above.  Let's say headers make up the links in the table of contents.

Using the getElements() function from [last post]({% post_url 2006-01-18-hacking-the-browsers-dom-for-fun %}), we can get an Array of all the header nodes:
{% highlight js linenos %}var headers = getElements(
    function(node) {
        return node.nodeName.length == 2 &&
        node.nodeName.charAt(0) == "H";
    });{% endhighlight %}
Now, we can create a TOC that lists each header.  At the top of the page, create and insert a div to hold the table of contents -- let's call it tocDiv.  Then, for each header node, do two things:

1. Insert an anchor into tocDiv.  Set its href to `'#' + header.innerText`.  Add to it a text node (using `document.createTextNode()`) containing the header's innerText.
2. Insert a named anchor right before the header, using `header.parentNode.insertBefore()`.  Set its name to `header.innerText`, so the TOC link points to it.

Now, at the top of the page, you have a list of links...each one linking to a header tag below, with the same text as the header it links to.  You can do some neat formatting with CSS, too...for the tocDiv links, set their CSS class attribute to something like `'toc_' + header.nodeName`. Then add CSS class definitions for `toc_h1`, `toc_h2`, etc, to make it look more like an outline (you know, make the h1's big and bold, the h2's smaller, that kind of thing).  If you want to get really fancy, you can wrap each header node in an anchor that links up to the table of contents...even give it a title of "Back to Table of Contents" using `node.setAttribute("title", "Back to Table of Contents")`.

### Make a "List of figures", and put captions on images


This one's also geared towards creating an outline, and will be pretty similar to the table of contents. Suppose you have images that aren't there for decoration or formatting, but are supposed to convey information (diagrams, charts, etc).  Let's assume that each has a meaningful alt tag.  We can create a list of figures that lists the title of the image (i.e., the alt text), and links to it.

First, like we did for the table of contents, insert a node into the document to hold your list of figures.  Let's say it's a div called figList.

Get all the images using `document.getElementsByTagName("img")`, and make a link pointing to each one. For each img node, again do two things:

1. Add an anchor to figList.  Get the img's alt text via `img.getAttribute("alt")` -- then use it for the anchor's text, and set the anchor's href to `'#' + altText`.
2. Insert a named anchor before each img node, and set its name to altText.

Adding captions is really simple.  While you're looping through the list of img nodes, insert a span after each one, with class set to "caption".  Set the text to `"Figure " + i + ": " + altText`, and you've got automatically numbered caption images.

### Format hyperlinks based on where they lead


I think I read a [Jakob Nielsen](http://www.useit.com) article that suggested telling users before they click on a link that it'll take them to another site.  Why not put an icon next to each link whose href starts with "http://"?
{% highlight js linenos %}
var externalLinks = getElements(
    function(node) {
        // nodeType == 1 means it's an Element
        if (node.nodeType == 1 && node.nodeName == "A") {
            return node.getAttribute("href").indexOf("http://") <= 0;
        }
    });
{% endhighlight %}
Using [AJAX](http://en.wikipedia.org/wiki/AJAX), you can get really crazy -- make a server-side component that returns the file size of a given URL.  Now, grab all the links that point to a .pdf, .doc, .zip, or whatever, get the actual size from the server, and tell the user up-front how big the file is.

### Checking our sanity


Just to reiterate, we're talking about changing the HTML structure at runtime.  Let's step back a sec and talk about that.

1. The server delivers a stream of text to the browser.
2. The browser parses it and builds a "mental" model of what it says.
3. The browser renders some text and color on the screen based on that model.

We're talking about changing that model around at runtime, not the bytes sent to the browser.  This means that if you View > Source on your page, you'll see the original HTML, and none of the fancy nodes you added or rearranged.

To help us see the havoc we've wreaked on the DOM, we can hack up a simple bookmarklet to dump out the DOM as HTML in a new window.  It's as easy as this:

* open a window
* write out a big textarea to it (use `style="width:100%;height:95%"`)
* fill the textarea with this window's `document.documentElement.innerHTML`

### Closing thoughts


There are some general ideas that I'm using in many of these suggestions:

* Use CSS classes, sometimes named after the node name, to keep your HTML-generating JavaScript clean.
* Use plain text for named anchors, like header.innerText or img.getAttribute("alt").  In programming, we usually shy away from using plain text for identifiers, because it's easy to mis-type...but if you're generating all your identifiers, who cares?
* Use function pointers as general-purpose selectors, instead of trying to support several types of limited selector.  For example, instead of getElementById(id), getElementNamed(tagName), and a hypothetical getElementWithAttribute(attrName, attrVal), why not just getElement(evalFunction)?
* Two of these ideas made the assumption that your HTML is organized a certain way, which isn't always possible.  If you have a page with lots of formatting (those pesky web designers), see if you can cordon off a section of clean HTML -- just a div with an id -- and only scan those nodes.  Another reason to use getElements() instead of the globally-scoped methods the browser provides.

Use these techniques to come up with new and exciting ways to bend the browser's DOM to your will.  Muahahahaha.

For more info:
[JavaDoc-style JavaScript](http://krook.org/jsdom/), pretty browser-independent
[Gecko DOM reference](http://www.mozilla.org/docs/dom/domref/dom_shortTOC.html) for Firefox
[AJAX](http://en.wikipedia.org/wiki/AJAX), DOM Hacking's most typical setting
