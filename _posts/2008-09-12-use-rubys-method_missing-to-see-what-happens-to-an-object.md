---
layout: post
title: Use Ruby's method_missing to see what happens to an object
type: post
published: true
status: publish
categories:
- Programming
tags:
- Ruby
author: Dan Bernier
date: 2008-09-12 09:24:35.000000000 -04:00
comments:
- author: Rob Bazinet
  content: Good stuff here Dan, you have great posts.  Tell me, I thought you were
    using Textile?
  date: '2008-09-15 20:01:18'
  url: http://accidentaltechnologist.com
  author_email: rbazinet@gmail.com
- author: Rob Bazinet
  content: "Sorry Dan, I was thinking of LaTEX when I posted this, which you are not
    using.  I think I need more sleep at night. \r\n\r\nI am going to try my hand
    at using your method of writing in text and converting to Word.  Do you have some
    techniques you care to pass along?"
  date: '2008-09-15 21:18:47'
  url: http://accidentaltechnologist.com
  author_email: rbazinet@gmail.com
- author: Dan Bernier
  content: "Thanks Rob!  Yes, I'm using Textile.\r\n\r\nOne trick I have is a custom
    tool in Programmer's Notepad 2 that wraps the selected text in '@', or if the
    text has a newline, in pre-tags.  The '@' is for in-line code, and the pre-tags
    for code blocks, so I have it triggered by Ctrl+Shift+C.\r\n\r\nI'm considering
    doing a post on the whole text-to-Word thing at some point: the need, the approach,
    everything.  If there's any interest, I might even gem the whole thing up.  IMHO,
    it's a much nicer way to write MS Word .docs.  It's not perfect, but I think it
    beats Word's mousing and binary formats."
  date: '2008-09-16 07:51:40'
  author_email: danbernier@gmail.com
---

Lately I've been generating MS Word .docs from text files, with [RedCloth](http://whytheluckystiff.net/ruby/redcloth/) and [Hpricot](http://code.whytheluckystiff.net/hpricot/) (thank you, [why](http://whytheluckystiff.net/), for both of those), and [win32ole](http://www.ruby-doc.org/stdlib/libdoc/win32ole/rdoc/index.html).  It's been fun, except for the OLE parts:  the ruby bridge is great, but the OLE API itself is strange, good documentation is sparse, and things get...flaky, sometimes.

In troubleshooting a bug that turns bold text on and off at the _wrong_ times, I thought "it'd be nice if I could see all the calls that happen to this 'selection' object, in order they happen.  Maybe I don't realize I'm turning the 'bold' on at the wrong times."  Enter the Echoer:

{% highlight ruby linenos %}
class Echoer
    def initialize(name)
        @name = name
    end
    def method_missing(method_name, *args)
        puts "#{@name}.#{method_name}: #{args * ', '}"
        Echoer.new("#{@name}.#{method_name}")
    end
end
{% endhighlight %}

The `Echoer` is a stand-in for a regular object.  Whenever a method is called on it, it prints its own name, the name of the method called, and the arguments.

{% highlight ruby linenos %}
def get_me_my_object
    # RealObject.new
    Echoer.new('obj')
end
obj = get_me_my_object
obj.puts 'Hello there'
obj.name = "Puddin'head Wilson"

# prints:
obj.puts: Hello there
obj.name=: Puddin'head Wilson
{% endhighlight %}

Each method call returns a new Echoer, whose name is based on its name, and the method name, so  you can chain method calls.

{% highlight ruby linenos %}
obj.next.upcase.match /pattern/

# prints:
obj.next:
obj.next.upcase:
obj.next.upcase.match: (?-mix:pattern)
{% endhighlight %}

I should probably make Echoer a [BlankSlate](http://onestepback.org/index.cgi/Tech/Ruby/BlankSlate.rdoc) object, but I haven't run into a need for it just yet.  I could also inspect the method's arguments with `args.map { |arg| arg.inspect }`, so you can tell strings and symbols apart.

Back in OLE-land, I replaced all instances of the selection object with `Echoer.new('selection')`, re-ran my code, and watched the output.  I _still_ haven't found the source of the bug, but at least I know I'm not turning bold on or off when I don't expect to.

Thanks to Michael Feathers for this idea.  He wrote on the Beautiful Code blog about [Spelunking Ruby Methods with Pebbles](http://www.google.com/search?rlz=1C1GGLS_enUS291&sourceid=chrome&ie=UTF-8&q=Spelunking+Ruby+Methods+with+Pebbles), but it seems O'Reilly took the blog down.  All that's left are the links from sites like reddit...does anyone know if the content is floating around somewhere out there?
