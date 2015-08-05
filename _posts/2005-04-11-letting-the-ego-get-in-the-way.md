---
layout: post
title: Letting the ego get in the way
type: post
published: true
status: publish
categories:
- Software Thinking
tags:
- Job
author: Dan Bernier
date: 2005-04-11 13:58:00.000000000 -04:00
---

One of Robert Glass' [Fallacies of Software Engineering](http://www.amazon.com/exec/obidos/ASIN/0321117425/amzna9-1-20/ref=nosim/104-8747188-9452743?dev-t=D26XECQVNV6NDQ%26camp=2025%26link_code=xm2) is that "Programming can and should be egoless." People think that ego gets in the way of writing good software -- you need to be cool, calm, and collected. No room for ego here, thanks, we're detached professionals. Glass, though, argues that ego is part of what makes a programmer good -- it provides incentive, personal attachment, motivation. Your software reflects on you, so make it good. This is all fine, and makes some sense to me. However, I want to talk about another aspect of ego that I think is less discussed, and more of a problem.

Maybe I should start with an illustration. In a recent meeting, I was trying to understand the new requirement the customer was asking for. The BA, having a great business background but very little IT background, already understood the problem -- and solved it for me. It took some polite work for me to find out for myself what the new requirement was about, so I could design an appropriate solution. Part of the new requirement meant that I'd have to interface with an existing enterprise user profile system that stores user groups in a hierarchy. The BA couldn't understand why it had to be in a hierarchy -- she kept saying, "look, can't we just get a list of the users, and use that?  It just seems easier to me."

I think this illustrates a common problem. Customers who have limited IT skills will insist that you use the solution they came up with. When you hear someone say, "I just see this in my head...why can't we do that?", you're probably facing this.

If you're building a system, you're working with someone who understands the problem that system should solve. I'll just call him the customer, although I think sometimes, this also applies to business analysts. Whoever it is, he also has an ego (he's human, isn't he?). He has an idea, at some level, how the system should solve the problem, and this is where the ego gets in the way.

Now, if you write software for a living, then you probably have more experience building systems than this person does. It's what you do. This person does something else, by definition. You're probably better able to imagine complex systems, deal with complex algorithms and data structures, and foresee the consequences of different design or solution decisions. Not because you're smarter than the customer, but because, again, it's what you do.

But when a customer has an idea for a system, it's his idea. He's thought some about this, and brought you his idea to be implemented. The more he's thought about it, probably the firmer he is about the idea. If he identifies with it, if it's "his idea," you'll have a hard time making him see any of its flaws. On the flip side, if you suggest a solution that he can't readily understand, it can scare him away. You get that look that says "what kind of whack-o would want to deal with something that complex?"

I guess this is one of those situations where you can't fix it, you can only deal with it.  But understanding that customers and BAs may have this kind of attachment can provide a lot of calm in these situations, and calm is the path you want to take.

---
Here's a [review](http://www-106.ibm.com/developerworks/rational/library/2073.html) of Glass' Facts and Fallacies of Software Engineering that I just found, but haven't read yet.
