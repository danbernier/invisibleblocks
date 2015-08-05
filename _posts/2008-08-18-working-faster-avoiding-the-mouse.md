---
layout: post
title: Working Faster, Avoiding the Mouse
type: post
published: true
status: publish
categories:
- Productivity
- Programming
tags: []
author: Dan Bernier
date: 2008-08-18 12:40:13.000000000 -04:00
comments:
- author: todd
  content: Thanks for this. I use Enso which is similar, but have been frustrated
    by its inability to open urls that haven't been bookmarked and "learned by Enso."
  date: '2008-08-18 15:36:41'
  url: http://levinsontodd.tumblr.com
  author_email: levinsontodd@gmail.com
- author: Dan Bernier
  content: I tried <a href="http://humanized.com/enso" rel="nofollow">Enso</a> once
    for a bit.  It was really interesting, but its use of caps-lock as the trigger
    really bit me...I guess partly because I'm on Dvorak, and O is where S is on a
    QWERTY -- Caps-lock+S is uncomfortable.  But also, there seemed to be too much
    magic.  Sometimes, I just want to tell my launcher what I want it to do.  Still,
    though, it's worth a try, if only to see what it's all about.
  date: '2008-08-18 16:39:33'
  author_email: danbernier@gmail.com
- author: Luis Lavena
  content: "I've been using Launchy with Win+Spacebar.\r\n\r\nI've setup custom commands
    to start and stop services (or even restart them).\r\n\r\nOther things include
    special links and folders with shortcuts to faster access special projects locations.
    so:\r\n\r\n1) Win+Spacebar, \r\n2) type prj and hit (tab) completes to Projects\r\n3)
    type a few letters of the name of the project, then hit enter.\r\n\r\nThe more
    I use them the better it rate, so I don't have to type the exact project name.\r\n\r\nThe
    thing with this shortcut is that open a explorer window being this project folder
    the root (instead of My Computer).\r\n\r\nThe used command line is:\r\n\r\n%windir%\\explorer.exe
    /e,/root,[FOLDER NAME]\r\n\r\nHTH,\r\nLuis Lavena"
  date: '2008-08-20 18:27:43'
  url: http://blog.mmediasys.com
  author_email: luislavena@gmail.com
---

I'm moving away from my mouse all the time.  On the one hand, it's so much faster to keep my fingers in the same place, and on the other, it's easier to automate keystrokes than mouse motions & clicks.  I especially don't like mousing through menus, so I'm always on the lookout for keyboard shortcuts.  Here are two tools that help me stay away from the mouse.

### SlickRun


[SlickRun](http://www.bayden.com/SlickRun/) is an application launcher: a special keystroke brings up a small pseudo-command-line window, you type in a command, and it launches the associated application.  By default, it uses a tiny window, but I made mine use an 18pt font, right in the middle of the screen -- it's my main focus when I use it, and it disappears right after.  When it first pops up, I have it display the date & time.

[<img class="alignnone size-medium wp-image-119" src="{{ site.baseurl }}/assets/2008/08/datetime.gif" alt="" width="300" height="50" />]({{ site.baseurl }}/assets/2008/08/datetime.gif)

You can type in URLs, and it launches them in the default browser.  It includes the Ctrl+Enter shortcut, so "google" + Ctrl+Enter launches "http://www.google.com", just like in Firefox and IE.  You can type in file paths, and it helps you with tab completion.

[<img class="alignnone size-medium wp-image-120" src="{{ site.baseurl }}/assets/2008/08/filesystem_completion.gif" alt="" width="300" height="46" />]({{ site.baseurl }}/assets/2008/08/filesystem_completion.gif)

You define "magic words", short names for applications, so "mail" launches Outlook, "ffox" for Firefox, etc.  But long, descriptive magic words are no problem, because it auto-completes them for you.  I can launch "editor_programmers_notepad" with only "ed".

[<img class="alignnone size-medium wp-image-121" src="{{ site.baseurl }}/assets/2008/08/long_magic_words_are_great.gif" alt="" width="300" height="49" />]({{ site.baseurl }}/assets/2008/08/long_magic_words_are_great.gif)

Magic words can take parameters too.  Here, the magic word "release" opens explorer to a network share where my team stores release information, each release in its own folder.  The magic word uses the release name to create the path, and launches explorer.

[<img class="alignnone size-medium wp-image-122" src="{{ site.baseurl }}/assets/2008/08/parameters.gif" alt="" width="300" height="42" />]({{ site.baseurl }}/assets/2008/08/parameters.gif)

SlickRun can export and import its list of magic words, which is great, because I move between three computers regularly.  If you're curious, you can import [my magic words](http://danbernier.googlepages.com/magic_words.qrs).

SlickRun comes with Jot, which is a pop-up notepad for short-term notes.  It's kind of strange,  coupling this with a launcher.  I never really use it, but if you have a use for it, it's there.

I've used SlickRun for about a year, and at this point, I don't think I could live without a launcher.  I'm thinking of trying [Launchy](http://www.launchy.net), which looks very promising.

### StExBar


[StExBar](http://tools.tortoisesvn.net/StExBar) is an add-in for Windows Explorer that I found on the [wiki](http://productiveprogrammer.com/wiki/index.php/Acceleration) for [The Productive Programmer](http://www.amazon.com/gp/product/0596519788?ie=UTF8&tag=invisblock-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0596519788)<img style="border:none !important;margin:0 !important;" src="http://www.assoc-amazon.com/e/ir?t=invisblock-20&l=as2&o=1&a=0596519788" border="0" alt="" width="0" height="1" />.  It creates hot-key shortcuts for common actions:  Ctrl+Shift+N creates a new folder, Ctrl+M opens a command prompt in the current folder, Ctrl+Shift+C copies the full paths of selected files, Ctrl+Shift+R renames files in the current folder with regular expressions.  This is really nice -- it shows the current file name on the left, and the new on the right, based on the pattern you typed in.  You know exactly how the rename will work before you run it.

It also lets you define custom commands.  So far, I have Ctrl+E opening the file for editing in [Programmer's Notepad](http://www.pnotepad.org/), Shift+U running svn update on the selected items, and Ctrl+B opening a cygwin bash shell in the current folder.  **UPDATE:** I just added Ctrl+Shift+D for running a diff.

I just installed StExBar three days ago, so it's not ingrained into my fingers yet, but I already missed it at home this weekend.  It fills a narrow spot, adding hotkeys to Explorer, but it does it really well.
