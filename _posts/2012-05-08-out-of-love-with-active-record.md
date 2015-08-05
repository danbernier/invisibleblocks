---
layout: post
title: Out of Love with Active Record
type: post
published: true
status: publish
categories:
- Productivity
tags:
- rails
- Ruby
author: Dan Bernier
date: 2012-05-08 20:36:44.000000000 -04:00
comments:
- author: Sheldon Hearn
  content: "Thank you. You've validated both the sense of dread I feel when I consider
    moving beyond Active Record, and the sense of hope I feel about the potential
    results.\r\n\r\nHere's where I'm at with this:\r\n\r\nhttp://starjuice.net/post/27254089033/active-records-vs-objects"
  date: '2012-07-15 08:55:46'
  url: http://starjuice.net/
  author_email: sheldonh@starjuice.net
---

(I'm a new-comer to Rails. When I first found Ruby, and Rails, I liked the Ruby better. And I never found many Rails jobs near home anyway. So for years, Ruby flavored my C#, and C# is where I learned, among other things, to persist my domain aggregates with NHibernate. Now I'm a card-carrying Rails jobber, which is great, because I play with Ruby all day. And the Rails community is discovering domain-driven design, and ORMs...)

Steve Klabnik just posted about [resisting the urge to factor your models into behavior-in-a-mixin and dumb-persistence-with-active-record](http://blog.steveklabnik.com/posts/2012-05-07-mixins--a-refactoring-anti-pattern). He nails it when he says:
<blockquote>
Whenever we refactor, we have to consider what we're using to evaluate that our refactoring has been successful. For me, the default is complexity. That is, any refactoring I'm doing is trying to reduce complexity... One good way that I think about complexity on an individual object level [is its] 'attack surface.' We call this 'encapsulation' in object oriented software design.</blockquote>

If you learn only one thing from his post, let it be that "mixins do not really reduce the complexity of your objects." Greg Brown threw me when he said that mixins are just another form of inheritance, and I think he was getting at the same thing.

Steve's suggestion for separating persistence and behavior is to - duh, once you see it - separate them into different classes: a Post and a PostMapper, or a Post and a PostRepository. When I used C# and NHibernate, we loaded our Posts from the PostRepository, which used our PostMapper for data access. (Actually, our PostMapper was an XML mapping file.) You might call that overkill, but in a legacy app, it was nice to sheetrock our repositories over all the different data access technologies we'd acquired over the years, from the shiny new ORM to the crusty old Strongly-Typed DataSets.

When I was on that team, the thing that we worried about was, what grain should we build our repositories at? We didn't have simple models, we had domain aggregates: we'd load a ThirdPartyAdministrator, which had many Clients, which each had a number of Accounts of different types, each of which had different options and sub-objects. So, what kind of repositories should we build, and what methods should they have? If we want to load the Client's Accounts, should we load the ThirdPartyAdministrator, find the Client, and get its Accounts? load the Accounts directly? load the Client, and get its Accounts?

For a ridiculously simplified example, but to give you the flavor of it, say we load the ThirdPartyAdministrator, the aggregate root, and go from there:

{% highlight ruby linenos %}
class ThirdPartyAdministratorRepository
  def load_tpa(id)
    ...
  end
end

tpa = ThirdPartyAdministratorRepositor.load_tpa(42)
client = tpa.clients[client_id]
accounts = client.accounts
{% endhighlight %}

That's too coarse; do we really have to load the TPA before we can get the client we're after?

{% highlight ruby linenos %}
class ClientRepository
  def load_client(id)
    ...
  end
end

class AccountRepository
  def load_account(id)
    ...
  end
end

client = ClientRepository.load_client(client_id)
accounts = client.account_ids.map { |id|
  AccountRepository.load_account(id)
}
{% endhighlight %}

That's too fine a grain, too low-level; we don't want to have to muck around with Account IDs.

{% highlight ruby linenos %}
client = ClientRepository.load_client(client_id)
accounts = client.accounts
{% endhighlight %}

That might be a good middle-approach.

It comes down to knowing your application's data-access patterns, and your domain's constraints. If you often need a chunk of data, all together, you should probably have a repository for it. If one piece of data depends on another, your repository probably shouldn't make you get them separately.

With Rails' ActiveRecord, all this is sorted out for you - you define your associations, it provides all those querying methods, and you use the correct ones for what you need. With repositories, you have decisions to make - you have to design it, and design is choice. But choosing is work! and you can choose inconsistently! sometimes, it even makes sense to! I'm curious to see how the Rails community, with its culture of convention, tackles this. And for myself, I plan to check out DataMapper at some point.
