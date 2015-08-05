---
layout: post
title: Programmable Text Editing on Windows with EmEditor
type: post
published: true
status: publish
categories:
- Programming
tags:
- Ruby
author: Dan Bernier
date: 2007-02-21 14:04:49.000000000 -05:00
comments:
- author: Raj
  content: "Check out Intype @ http://intype.info/home/index.php\r\n\r\nIt is only
    an Alpha release right now, but it seems to have a lot of potential to be an outstanding
    editor (ala Textmate) for Windozites\r\n\r\nIn their forum there is an Intype
    Project Manager that someone wrote in Delphi that acts as a wrapper around the
    editor. The combination of the two has given me a workable solution until the
    product gets released.\r\n\r\nPlease do check it out."
  date: '2007-02-24 10:55:01'
  author_email: rrajen@comcast.net
- author: Rob Bazinet
  content: "Dan,\r\n\r\nI am a Windows guy trying to do Rails and Ruby and knowing
    how the Mac fanboys over at 37Signals and around the Rails community love TextMate
    I ran across E-Texteditor.  It is basically TextMate for Windows with bundles
    and everything like TextMate.  It is in beta but I have been using it for a few
    months now and it is good with frequent updates and good support.\r\n\r\nIt here
    - http://www.e-texteditor.com/index.html if you are interested."
  date: '2007-06-27 09:14:11'
  url: http://rbazinet.wordpress.com/
  author_email: rbazinet@gmail.com
- author: Dan Bernier
  content: "I really need to update this post...after playing with EmEditor for a
    bit, I found <a href=\"http://www.pnotepad.org/\" rel=\"nofollow\">Programmer's
    Notepad</a>.  It's opensource, free, and (my favorite) it lets you pump a buffer
    to any executable.  Just what I wanted!  The find-replace has some quirks, but
    it works, and the project is active, so I have high hopes.  I have Ctrl-Shift-R
    set up to run the buffer as in-line Ruby, which is awesome...I don't even use
    IRB anymore.\r\n\r\nRaj, I've been checking out InType periodically, and it looks
    promising.  I'm sure I'll be downloading the trials a few more times, to see how
    it comes along.\r\n\r\nRob, I also checked out e, and liked it ok.  I'm not already
    hard-wired for TextMate, so I'd have some learning to do (no sweat).  The only
    thing that turns me off at all is, I want to make my own extensions...I guess
    I'd be making bundles, in e.  That looks like it'd be a bit more involved."
  date: '2007-07-02 09:22:52'
  author_email: danbernier@gmail.com
- author: Sayak
  content: "Hi,\r\n\r\nPlease help me in running a ruby programme from EMEditor.\r\n\r\n\r\nThanks,\r\nSayak"
  date: '2008-04-04 04:19:40'
  author_email: sahasayak30@yahoo.co.in
- author: Dan Bernier
  content: "Sayak,\r\n\r\nI stopped using EmEditor about a year ago, so at this point,
    I'd say EmEditor's help files would be the place to go.  Assuming, of course,
    you successfully have both ruby and EmEditor installed and running properly."
  date: '2008-04-04 12:29:03'
  author_email: danbernier@gmail.com
---

Windows lacks a decent programmable text editor.

I know there's [Emacs](http://en.wikipedia.org/wiki/Emacs) and [Vim](http://www.vim.org/), but I want something that looks good, and is easy to learn.  If it's free or cheap, that's good, too.  Based on screencasts I've seen, I'd say I want something like [TextMate](http://macromates.com/), but I've never actually used it, so that's just a guess.

It has to be programmable.  I spend lots of time working with text, and I want an editor that lets me write code to process my text.  I want to take a list of values, and generate SQL from it.  I want to auto-format HTML.  I want to insert custom code templates, based on keywords I type.

Really, I want something like Ruby's text-mashing power, built into my editor.  If I could send a buffer's contents through some code, and replace the buffer with the script's output, that'd be something.  This would let me automate probably 99% of the repeatable things I do.  It doesn't have to be Ruby, but that'd be nice.

### EmEditor's Programmable Macros


I found [EmEditor](http://www.emeditor.com/), which gets me pretty close.  It has a 30-day trial, and it's $40 to buy.  It has programmable macros, with a decent set of variables that give you access to the buffers, editors, and all menu items.  The macros are run through the [Windows Script Host](http://msdn2.microsoft.com/en-us/library/ms950396.aspx) (WSH), which is a little scary, but it means that you can _write your macros in JavaScript_.  Actually, since WSH is language-agnostic, you can write your macros in _any language_ with a WSH interface.  Including [Ruby](http://arton.hp.infoseek.co.jp/).  Or [Haskell](http://www.haskell.org/haskellscript), or [Lua](http://www.luascript.thersgb.net/luascript), which makes it easier for me to experiment with them now.  And of course there's [Python and Perl](http://www.activestate.com).  I think this is pretty nifty.

### The Downside


Since it's built on WSH, you don't have any means of including other files.  Nothing like Ruby's `require`, Java's `import`, C#'s `using`.  This means no library re-use, no utility functions.  No [RedCloth](http://whytheluckystiff.net/ruby/redcloth/) for blog posting, no [REXML](http://www.germane-software.com/software/rexml/) for auto-formatting XML, no [Hpricot](http://code.whytheluckystiff.net/hpricot) for digging through generated HTML.  How about a nice, clean interface to WSH's hairy objects?  I'd love to write one!  (Well, I'd love to _have_ one, so I'd be _willing_ to write it.)  But you couldn't use it, if I did.  I think this is a pretty significant problem.  You have to start from scratch with each script.  Someone please tell me I'm missing something here.

None of this is stopping me from rolling up my sleeves yet.  Here are some tasks I've automated so far (you can get some of the .js files from my [Google Pages](http://danbernier.googlepages.com/emeditormacros)...I'll put up more when I have a minute):

* Replacing "smart quotes" and other funny characters with their plain-text equivalents.  Great for copying code and data out of MS Office products.
* Delete all copies of whatever text is selected.  When I'm cleaning up generated HTML, I remove lots of code (`<td>, <tr>, class="foo"`), so I can see the parts I care about.  Just highlight, run, _poof_.  All gone.
* Make the word I just typed into an opened-and-closed HTML tag, with the cursor in between.  I have this hooked up to Ctrl-space, and Shift-Ctrl-space adds in a newline and tab indent.  "b" ctrl-space produces `<b>|</b>`, and the cursor is where the `|` is.  "table" shift-ctrl-space "tr" shift-ctrl-space "td" ctrl-space.  Much faster.
* Run some JavaScript on each line, and replace the line with the code's return value.  You can use this for chewing on data, cleaning up formatting, calculating values, or whatever.  If you have to change many lines of similar C# or Java, you can chew each line up, and rewrite the code with this.  Powerful, easy to make a mess with, and all that.  This is probably my favorite.

Things I haven't gotten around to yet:
<ul>
<li>Tidying XML or HTML</li>
<li>Customizeable templates.  These would work like my HTML-tag-izer, where you type a word, then Ctrl-space, and your word is replaced with a template of code.  Eclipse has this, and TextMate comes with a whole mess of really nicely defined ones for Ruby.</li>
</ul>

Maybe someday, I'll have learned emacs, and I'll look back on this post and laugh at myself.  "Windows _Script Host??_  What was wrong with me?"  In the meantime, I have something that helps me along, lets me have fun automating things, and lets me explore other languages.
