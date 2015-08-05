---
layout: post
title: 'Rails 3: Selectively Override Email Recipients'
type: post
published: true
status: publish
categories:
- Programming
tags:
- ActionMailer
- rails
- Ruby
author: Dan Bernier
date: 2012-07-12 08:40:00.000000000 -04:00
---

It's a common thing, in your test environments, to intercept out-going email, and stuff it in some dumpster out back, so you don't bother your users. We do this at SeeClickFix, and we're upgrading to Rails 3, so I went searching for the new way to do this, and found Rob Aldred's [handy post on the subject](http://robaldred.co.uk/2010/10/override-actionmailer-recipient-rails-2-and-3-for-development-or-testing/).

So we deployed our Rails 3 branch to a test environment & unleashed our QA staff on it, but they all knew that they'd never get email from that environment, so they never checked for them. Which was a problem, because _all the email were broken in QA._ Oops.

It'd be nice to only dump _certain_ messages (the ones to your normal users) and let through others (the ones to your QA staff). Can we do this? Let's see.

ActionMailer::Base lets you register an interceptor, and every time it's about to send an email, it'll call your interceptor's #delivering_email method with the email as an argument. All the examples I found register a class as an interceptor, with #delivering_email implemented as a class method, like this:

{% highlight ruby linenos %}
class FooInterceptor
  def self.delivering_email(message)
    message.to = "dump@example.com"
  end
end

ActionMailer::Base.register_interceptor(FooInterceptor)
{% endhighlight %}

Now that's fine, but why pass a class with a class method? Why not an object with an instance method? Especially since a class is just an object, an instance of Class. Will ActionMailer::Base#register_interceptor do something funny with its argument? Try to call #new on it? Who knows?

I tried this just to see if it would work:

{% highlight ruby linenos %}
class FooBarRecipient
  def delivering_email(message)
    message.to = "dump@example.com"
  end
end

ActionMailer::Base.register_interceptor(FooBarRecipient.new)
{% endhighlight %}

And it does! Nice job, register_interceptor, not doing anything funky with it. Thanks!

This means we can create an interceptor object with a whitelist:

{% highlight ruby linenos %}
class WhitelistInterceptor

  def initialize(whitelist)
    @whitelist = whitelist
  end

  def delivering_email(message)
    message.to = Array(message.to).map { |address|
      if @whitelist.include?(address)
        address
      else
        "dump@example.com"
      end
    }
  end

end
{% endhighlight %}

Of course that's really basic - you probably want to allow all email sent to your domain, for instance. And maybe you want the messages to be tagged somehow, so you can tell which test environment a message came from, so you give the  WhitelistInterceptor the Rails environment to add as a message header. But that's the idea. And my favorite part is that the class has no Rails dependencies, so it's trivial to test.

Is there any reason not to do this?
