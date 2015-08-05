---
layout: post
title: Hacking the Browser's DOM for Fun
type: post
published: true
status: publish
categories:
- Programming
tags:
- JavaScript
author: Dan Bernier
date: 2006-01-18 18:44:00.000000000 -05:00
---

Hacking the browser's DOM is about traversing its structure, changing it around, and generating content.  It's the sexy half of [Ajax](http://en.wikipedia.org/wiki/AJAX) -- the part that changes the page _before your very eyes!_  I won't go into Ajax here, as there are other places that cover it far better than I can.  Without Ajax's other half, asynchronous HTTP, I'm not entirely sure how useful DOM hacking is, but it's fun, and I've found at least a few good uses for it.  YMMV -- others on my team find it somewhat less attractive than I do.  Along the way I'll talk about function pointers, and throw in some recursion.

### DOM Traversal


If you want to do anything interesting with the DOM, you have to see what's in there first.  The standard methods `document.getElementById()` and `document.getElementsByTagName()` are pretty useful here, but let's create a third option, one that's more flexible, and shows off our new function pointers knowledge:
{% highlight js linenos %}
function getElements (evalFunc, node) {
   if (!node) node = document.documentElement;

   var matches = new Array();  // storage space
   if (evalFunc(node))         // if it's a match...
       matches.push(node);     // store it

   var child = node.firstChild;
   while (child) {                // search thru each child
       matches = matches.concat(getElements(evalFunc, child));
       child = child.nextSibling;
   }

   return matches;
}
var headers = getElements(
   function(node) {
       return node.nodeName.length == 2 &&
       node.nodeName.charAt(0) == "H";
   });
{% endhighlight %}
Let's start with `getElements()`.  First, notice that it defaults `node` to `document.documentElement`, so if you call it without a node parameter, it'll cover the whole document.  Groovy, now we can forget about that.  Now notice the [recursion](http://en.wikipedia.org/wiki/Recursion#Recursion_in_computing), and the structure of what it does -- return an Array of nodes that meet `evalFunc`'s criteria.  It's classic recursive behavior:  work on `this`, then work on `this`'s children (if any), and collect all the results.

It might seem like overkill, creating a whole new function -- but look at how it's used, and the power it gives you.  We can get an Array of header tags by defining what a header looks like.  "If the node name is 2 long, and starts with 'H', include it."  We could use a regular expression if we wanted to.  We can pick nodes that match any criteria we can express in JavaScript.
{% highlight js linenos %}var leafNodes = getElements (function(node) {
   return !node.hasChildNodes(); // no children = a leaf node
});

var imagesWithAltText = getElements (
   function(node) {
       if (node.nodeName == "IMG") {
           return node.getAttribute("alt") != "";
       }
       return false;
   });
{% endhighlight %}
See how handy function pointers are?  They're like little nuggets of code you can throw around.  This "evaluator function" approach reminds me both of Ruby's `Enumerable.find_all` method, and Java's `FileFilter` and `FilenameFilter` interfaces.  Or really, any case where you want lots of control over how you select items from a collection.  Note that because Java doesn't have function pointers like Ruby and JavaScript, it makes you wrap your function in a class (technically called a _functor_).

### Creating Nodes


So now we can pick out nodes, let's start creating new ones.  This is pretty easy, except for the usual browser differences.  I run Firefox 1.5 and IE 6, and my code for here will work in IE 6.  I'll note some basic Firefox issues as I go, but nothing too extensive.

In IE 6, you create a new node like this:
{% highlight js linenos %}
var myDivNode = document.createElement("<div>");
{% endhighlight %}
You can stuff any valid HTML in there, as far as I know, except it has to be an empty node.  If you want to create, say, a hyperlink, you create both the anchor node and the text node, and append the text node into the anchor node:
{% highlight js linenos %}
var linkNode = document.createElement("<a href='http://www.google.com'></a>");
var linkLabel = document.createTextNode("Google");
linkNode.appendChild(linkLabel);
{% endhighlight %}
In Firefox 1.5, you only pass the tag name to `document.createElement()`, and you call `elem.setAttribute("attrName", "attrValue")` for all your attributes.  Definitely tedious.

Note that `linkNode.appendChild(linkLabel)` there.  It does just what it says:  makes `linkLabel` a child of `linkNode`.  Along with `insertBefore`, `removeChild`, and `replaceChild`, you can quickly get used to chaging the DOM at runtime.  [See this [JavaDoc-style JavaScript site](http://krook.org/jsdom/) for the details.]

I'll stop here, and save the practical applications for another post.  Some ideas, though:
<ul>
<li>creating a table of contents from all header tags</li>
<li>putting captions on all images that have alt text</li>
<li>formatting external links differently from internal ones</li>
</ul>
