---
layout: post
title: Passing by reference, and dog leashes
type: post
published: true
status: publish
categories:
- Learning
- Programming
- Software Thinking
tags: []
author: Dan Bernier
date: 2008-04-29 13:38:56.000000000 -04:00
---

Pass-by-reference and pass-by-value are pretty confusing when you start learning to code.  When I first saw them, I know I ignored the distinction (until I got tired of my code not doing what I expected).  Throwing collections into the mix just makes it worse.

Today, though, we stumbled on a pretty decent analogy for passing-by-reference: a reference to an object is like a leash to a dog.  Let's take our dog Dagwood for a walk.

{% highlight csharp linenos %}
Dog dagwood = new Dog("Dagwood");
{% endhighlight %}

`new Dog()` creates, of course, a new Dog object.  `Dog dagwood` creates a reference that can point to any Dog object -- it's really the leash, but we name our references for what they point to, rather than what they are: a reference, a handle, a leash.  The equals sign takes the leash, and hooks it to Dagwood's collar.  Now we can take Dagwood for a walk.

{% highlight csharp linenos %}
dagwood.walk();
{% endhighlight %}

To tell Dagwood it's time to walk, we tug on the leash.  He feels the tug, and gets the message, so he starts following us.  We come to a busy road, and wait for the crossing signal, but Dagwood's oblivious, and tries to cross anyway.

{% highlight csharp linenos %}
dagwood.halt();
{% endhighlight %}

Since we're stopped, he feels the tug of the leash again, gets the message, and stops.  We're sending messages to Dagwood through his leash.  In OO terms, sending a message to an object means calling one of its methods.  We're calling methods on our Dagwood **through** our reference to him, through the leash.

**Storing a reference in an array**

In the park, we find a snack shop.  We're getting hungry, but the snack shop doesn't let dogs inside.  Luckily, there's a chain link fence, and in our eyes, a chain link fence is nothing but a big row of places for us to attach a dog leash.  We tie a spare leash to the end of the fence, and attach it to Dagwood's collar.

{% highlight csharp linenos %}
Dog[] fence = new Dog[10]; // only room for 10 dogs
fence[0] = dagwood;
{% endhighlight %}

What's happening here in OO terms is that our reference to Dagwood, our leash, is **copied** into the zeroth slot on the fence.  It's not our leash, but it's one just like it.  So now there are two leashes on Dagwood: one in our hand, and one on the fence.  We'll take our leash off Dagwood, since we can't very well hold it while we're in the store.
{% highlight csharp linenos %}
dagwood = null;
{% endhighlight %}

Don't worry, he's fine...he's still tied to the fence, by that other leash.  Let's go buy cashews.

When we come out of the store, we want to re-attach our leash to Dagwood.

{% highlight csharp linenos %}
dagwood = fence[0];
{% endhighlight %}

Now let's untie him from the fence, and head over to the lake.

{% highlight csharp linenos %}
fence[0] = null;
{% endhighlight %}

**Passing by reference**

Passing references to methods works in much the same way.  Dagwood got kind of stinky, swimming in the lake, so let's bring him to the groomer for a bath.

{% highlight csharp linenos %}
DogGroomer.shampoo(dagwood);
{% endhighlight %}

When you pass a reference to a method, your reference is copied into that method.  Again, it's like a new leash, one just like ours, springs into the groomer's hand -- now Dagwood's attached to us, and the groomer.  He gets fidgety when he's getting bathed, so it's just as well.

From the groomer's perspective, it might look like this:

{% highlight csharp linenos %}
void shampoo(Dog doggie) {
    wet(doggie);
    apply(shampoo, doggie);
    rinse(doggie);
    towelDry(doggie);
}
{% endhighlight %}

The groomer doesn't care what Dagwood's name is, she just keeps calling him "doggie."  That's ok, she must see a lot of dogs during the day...names aren't that important to her.  The interesting thing is, even though it's the groomer who's shampooing our dog, since we still have a leash on him, we can observe him getting cleaner.

When she's done, the procedure ends, the method returns, and her leash to Dagwood disappears.  Which is fine, because he's stopped fidgeting, now that he's dry.

**Garbage collection**

We head back home through the park.  Dagwood's itching to run around, but we're tired, so we just unleash him.  Hopefully we can find him before it gets dark...

{% highlight csharp linenos %}
dagwood = null;
{% endhighlight %}

Unfortunately, the dog catcher spots him running around without a leash, which is illegal in these parts -- a stray dog will hang around forever, eating up resources.  The dog catcher carries off our poor Dagwood, and destroys him.  We take it in stride, and try to keep the whole circle of <span style="text-decoration:line-through;">life</span> allocation-deallocation in mind.

**So...**

So that's how references work.  It's why code like this (C#) will ensure the balloon bouquet has at least one balloon that says "Happy Birthday!":

{% highlight csharp linenos %}
List<Balloon> balloons = GetBalloons();
Balloon printed = balloons.Find(Balloon.IsPrinted);
if (printed == null) {
   printed = new Balloon();
   printed.PrintMessage("Happy Birthday!");
   balloons.Add(printed);
}
return balloons;
{% endhighlight %}
