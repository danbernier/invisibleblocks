---
layout: post
title: Firebug and Monaco, on Windows
type: post
published: true
status: publish
categories:
- Tools
tags:
- Firebug Monaco fonts
author: Dan Bernier
date: 2009-11-20 18:06:45.000000000 -05:00
comments:
- author: MkFly
  content: "I love Firebug, but the developer would like us to use the OS X \"Monaco\"
    font instead of letting the user decide which monospaced font to use (via the
    system default).\r\n\r\nMonaco sucks.\r\n\r\nA quick-fix I made, apply via the
    Stylish extension:\r\nhttp://monacosucks.pastebin.com/3KwAg1Le"
  date: '2010-06-08 16:27:42'
  author_email: mmkfly@gmail.com
---

I've been running [Firebug](http://getfirebug.com/) at work for a long time, it's a really solid tool.  A while ago, I started using a [Monaco.ttf for Windows](http://www.webdevkungfu.com/textmate-envy-aka-monaco-font-for-windows/).  I think it looks much better on my Ubuntu system, but it's nice to have on Vista.

Firebug was apparently written for the Mac, because it uses Monaco all over the place. That would be very nice, but on Windows, a bold Monaco is a wider Monaco.  This makes the line number gutters uneven, and makes the screen flash when you scroll through text:

[<img class="alignnone size-full wp-image-361" title="Firebug and Monaco on Vista" src="{{ site.baseurl }}/assets/2009/11/firebug-monaco-vista2.gif" alt="" width="349" height="257" />]({{ site.baseurl }}/assets/2009/11/firebug-monaco-vista2.gif)

I finally got irritated enough to google it, and I found this [post by Thomas Scholz](http://toscho.de/2009/schrift-in-firebug-aendern/) (it's in German, here's [Google's translation](http://translate.google.com/translate?js=y&prev=_t&hl=en&ie=UTF-8&u=http%3A%2F%2Ftoscho.de%2F2009%2Fschrift-in-firebug-aendern%2F&sl=de&tl=en)).

The details: Firebug's CSS files are located in its extension directory, which is probably someplace like this:

* Vista: C:\Users\{**USERNAME**}\AppData\Roaming\Mozilla\Firefox\Profiles\{**alphanumerics**}.default\extensions\firebug@software.joehewitt.com\skin\classic
* XP: C:\Documents and Settings\{**USERNAME**}\Application Data\Mozilla Firefox\Profiles\extensions\firebug@software.joehewitt.com\skin\classic

Search-and-replace the Monaco away, and restart Firefox.
