---
layout: post
title: ActiveRecord and Repositories
type: post
published: false
status: draft
categories: []
tags: []
author: Dan Bernier
---

[Mixins: A refactoring anti-pattern](http://blog.steveklabnik.com/posts/2012-05-07-mixins--a-refactoring-anti-pattern), _wherein Steve Klabnik proposes using Repositories_

Related Klabnik, but not what I was looking for:
http://blog.steveklabnik.com/posts/2011-09-22-extracting-domain-models-a-practical-example
http://blog.steveklabnik.com/posts/2011-09-06-the-secret-to-rails-oo-design
http://blog.steveklabnik.com/posts/2011-09-09-better-ruby-presenters
http://blog.steveklabnik.com/posts/2011-12-30-active-record-considered-harmful

My old post, Falling Out of Love with ActiveRecord:
http://invisibleblocks.com/2012/05/08/out-of-love-with-active-record/

~ ~ ~
Maybe the problem is that we're conflating - [complecting](http://www.infoq.com/presentations/Simple-Made-Easy) - our ActiveRecord models with our ActiveRecord repositories. Maybe, instead of Model.scope.scope.scope, or Model.class_method, we should have Repo.scope.scope.scope and Repo.class_method. The pain point in testing your Model always is the point where we have to persist it - it tests out so nice, so fast, until we have to smear ActiveRecord all through it. Why subclass it? I mean, ok, we want our magic column methods, but those should be written against an in-memory hash, not a database connection. It seems like we want to test _instances_ of our model classes - a Blog, a Post, a User - but the _class-level_ behavior gets in the way - querying, loading, persisting. Put another way, we want to test the behavior of our objects, but we want to declare how they're persisted. Persistence & behavior are two different concerns - we shouldn't tie them together. We could have ActiveRecord::Base be basically that hash-wrapper, and have a separate class, maybe ActiveRecord::Repository, that gives us our scopes and finders.

~ ~ ~
I used to live in the world of .Net- and NHibernate-style DDD, where we designed our domain objects without much regard for their persistence (we configured mappings for that), and we designed the methods on our repositories with care for how, and when, it loaded which parts of our domain objects, because you wrote them all by hand, and you don't want tons of them floating around, muddying up the Repository's API. The really nice part about this arrangement was that the domain classes had no connection to NHibernate, and they were trivial to test. We didn't test our repositories, because they had only a few methods that just called the NHibernate API. We didn't test our mappings, because we just configured NHibernate to do it correctly. The sucky part about it was that we had to _manually_ write out these mapping files, because C# doesn't metaprogram. And each repository's API was designed from scratch, with care, method by method, manually, with inconsistencies always creeping in, because we didn't have scopes and convention-over-configuration to help. Separation made our models testable, but no metaprogramming made repositories hard to build. Rails has the opposite trade-offs: complection makes it hard to test our models, but metaprogramming against conventions makes repositories easy. But Rails doesn't _have to_have that complection. We can separate our repositories from our models, for the testability, and we can use meta-programming to help with that. You could write your model without worrying about its persistence, and test it. When it's time to persist, you could build a repository, and decide whether to use ActiveRecord or a more general, flexible ORM - you could even have one of each, if that made sense. If our repositories could tie into the ORM by composition, instead of by inheritance, it'd be that much easier to mock our repositories for testing our controllers. How hard could it be to make something like this?

{% highlight ruby linenos %}
class Posts < ActiveRecord::Repository
  def some_special_query
    ...
  end
end
class Post < ActiveRecord::Base
end
Posts.find(42)
Posts.find_by_author('Douglas Adams')
Posts.some_special_query
{% endhighlight %}

I know there are inconsistencies with what we do today, and things would have to change,

----------------------------------------
One problem with this would be lazy-loading certain fields. .... When you say Foo.find(42).bar, it doesn't create an empty Foo from select id from foos, and _then_, when you call #bar, select bar from foos where foos.id = ? select id from foos where id = ?; select bar from foos where id = ?; No, it gets the whole Foo, and returns its attributes from memory. select * from foos where id = ?;
