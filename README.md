This is not meant to be an exhaustive guide to Racket or functional programming. It simply gives some basic examples that are meant to help the reader learn to think in terms of Racket, as well as a review of basic concepts that are needed for understanding these examples. For information about specific functions, one should refer first to the [Racket documentation](https://docs.racket-lang.org/reference/).

# Background
## You and functional programming
A functional language is one that emphasizes functions that return only one output for each input, regardless of what may have happened elsewhere in the program by this point. That is, if you expect f(x) to return y at one point in the execution of the program, you can assume it does so at all points. That makes the function easier to reason about it, because you can tell what it does without having to think about how the state of a global variable elsewhere in the program might be effecting the behavior of the function.

One way to follow along with this tutorial is to type the examples into a REPL (read-eval-print-loop) that you can get by opening up Dr. Racket or typing **racket** into a terminal.

## The Basic Idea
A Racket function returns the last expression it evaluates. That means there is no return statement. In fact, there are no statements in Racket, just a series of expressions to be evaluated.

What is an expression in Racket? Anything that starts with (. If you see an opening parenthesis, it means that the function that follows is the function being called. Some special forms are an exception, like

'(1 2 3)

The quote stops Racket from evaluating what follows as expression. More specifically, the above is a way to create a list. Racket is descended from LISP, which stands for list processing, so lists are a central aspect of Racket.

## The Basic Syntax

From the Racket docs, we define a function like so:

(define (id arg ...) body ...+)

which is a shorthand for

(define id (lambda (arg ...) body ...+)

I prefer the first way because it's less typing and easier to remember, but the second is more explicit, telling us exactly what is going on. First, the **lambda** returns a function that takes *arg* and returns the result of *body*. **define** then binds the function to id so that we can call it elsewhere in our program. If we omit the **define**, we can create a lambda function that can be passed an argument to another function. If you don't understand that last part, don't worry, we'll explore it in more depth later. For now it's enough that you know how to bind a function to an id.

The second way also reminds us what **define** is doing, which is evaluating an expression and binding it to a value (calling **lambda** is an expression). This means we can do

(define a (\* 2 2))

as well as

(define a 4)

In Java, this last is the same as

int a = 4;

## Working with lists
**cons** returns a new list that's the first argument appended to the second, which is a list. **car** returns the first element of a list. **cdr** returns the remainder of a list without the first element. Let's see them in action.

> (cons 1 '(2 3))
'(1 2 3)

> (car '(1 2 3))
1

> (cdr '(a b c))
'(b c)

(define things '(thing1 thing2))
> (cdr things)
'(thing2)

> (cdr (cdr things))
'()

## Recursion
A function that calls itself. Functions can also call each other repeatedly. For example, f can call g and g can call f until some condition is met. That condition is called the base case. A recursive function must have a base case so that at some point a function call will return without recursing. That's a lot of information. Let's break it down.

(define (contains-even? num-list)
  (cond
    [[empty? num-list] #f]
    [[even? (car num-list)] #t]
    [else (contains-even? (cdr num-list))]
  ))

A note on the square brackets: whether you use ( or \[ makes no difference in Racket, only you must close each paren with a paren of the same style. The way I'm using square brackets in the conditional here is simply a convention to make the code more readable.

The base case is that the list is empty. This is pretty typical. We can't recurse on an empty list, so we return false. Why false? Because by this point, we've checked every element of the list to see if it's even. If we had found an even number, the function would have returned true.

After that we check if the first element of num-list is even. If it is, we return true.

What's that **else** doing at the end? That's where we recursively call the function on the remainder of the list **that hasn't been checked**. Two things are worth noting: **cdr** and the recursive call. **cdr** returns the list without the first element. It then hands this new list to contains-even? to check.

> (contains-even? '(1 3))
\#f

## Composition
This is used when we want to create a new function that combines two functions.
(define f (compose g h))
is essentially the same as
(define [f some-arg] (g (h some-arg)))
**Compose** saves some typing and is more reusable, since you might later redefine g to take a different number of arguments.

## Reverse a String as a List

# Appendix
