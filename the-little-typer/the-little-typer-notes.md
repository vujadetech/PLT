### The Little Typer Notes

- First Commandment of _cons_
	- Two cons-exps are the same (Pair A D) if their cars are the same A and cdrs the same D, where A and D are any type.
	
- Ill typed
	- __(Pair (cdr (cons Atom 'olive)) (car (cons 'oil Atom)))__ is neither described by a type, nor is it a type, so asking for its normal form is meaningless. Also called _ill-typed_.

- Values
	- An expression with a constructor at the top is called a _value_. Values are also called _canonical expressions_.
	
- The constructors of Nat are _zero_ and _add1_, while the constructor of __Pair__ is _cons_.

- Everything is an Expression

- The Commandment of add1
	- If n is the same Nat as k, then (add1 n) is the same Nat as (add1 k).
	
- Constructors create _data_, not types. So Pair isn't a constructor.

- Constructors build values, and eliminators take apart values built by constructors. E..g, car and cdr are eliminators.

- Eliminating Functions: Applying a function to arguments _is_ the eliminator for functions.

- Renaming variables is called _alpha conversion_, from Alonzo Church.

- The Initial Law of Application
	- If f is an (-> Y X) and _arg_ is a Y, then (f _arg_) is an X.
	
- The Initial First Commandment of lambda
	- Two lambda-expressions that expect the same number of arguments are the same if their bodies are the same after consistently renaming their variables.
	
- Initial second commandment of lambda
	- If f is an (-> Y X) then it's the same as (\ (y) (f y)) as long as y doesn't occur in f.
	
- The law of renaming variables
	- Consistently renaming variables can't change the meaning of anything.
	
- The Commandment of Neutral Expressions
	- Neutral expressions that are written identically are the same, _no matter their type_.

- The Second Commandment of cons
	- If p is a (Pair A D), then it is the same (Pair A D) as (cons (car p) (cdr p)).
	
	
- rec-Nat/primitive recursion
	- Second Commandment of rec-Nat
		- If (rec-Nat (add1 n) base step) __is an X, then it is the same X as__ (step n (rec-Nat n base step)).
		
	- example, (step-* j) returns a function of two arguments
	(define * (lambda (n j) (rec-Nat n 0 __(step-\* j)__)))

- Recursion, "replace the gray box" (p
- The commandment of the: Use "the" to test type
	- (the (Pair Atom Atom) (cons 'spinach 'kale))
	
- The second Commandment of rec-Nat
	- if __(rec-Nat (add1 n) base step)__ is an X, then it is the same X as __(step n (rec-Nat n base step)__.
	
- which-Nat vs iterNat vs rec-Nat (p 70)
	- which-Nat applies its step

- general note (from wiki/intuitionistic\_type\_theory) on Type theory for set theorists: Types contain terms just as sets contain elements. Terms belong to only one type. Terms like 2 + 2 compute/reduce to canonical terms like 4.

- The Second Commandment of rec-List
	- If __(rec-List (:: e es) base step)__ is an X, then it is the same X as __(step e es (rec-List es base step))__.

- The Law of __Vec__
	- If E is a type and k is a Nat, then (Vec E k) is a type.

- The law of __vecnil__
	- vecnil is a (Vec E zero)
	
- The law of __vec::__
	- If e is an E and es is a (Vec E k), then __(vec:: e es)__ is a __(Vec E (add1 k))__.
	
- The law of __Π__
> The expression __(Π ((y Y)) X)__ is a type when Y is a type, and X is a type if y is a Y.

- __-> and Π__
> The type __(-> Y X)__ is a shorter way of writing __(Π ((y Y)) X)__ when y is not used in X.

- The final law of __λ__ 
> If x is an X and y is a Y, then __(λ (y) x)__ is a __(Π ((y Y)) X)__.

- __motive for ind-Nat__
> ind-Nat needs one more argument than rec-Nat which states _how_ the types of both the base and the step's almost-answer depend on the target Nat, which is called the _motive_. It can be any (-> Nat U).

- __The Law of ind-Nat__
	- If target is a __Nat__, 
	- mot is a __(-> Nat U)__,
	- base is a __(mot 0)__, and
	- step is a __(Π ((n-1 Nat)) (-> (mot n-1) (mot (add1 n-1))))__,
	- then __(int-Nat target mot base step)__ is a __(mot target)__.
	
- __The first commandment of ind-Nat__
	- The ind-Nat expression __(ind-Nat 0 mot base step)__ is the same __(mot zero)__ as base.
	
- __The second commandment of ind-Nat__
	- The ind-Nat expression __(ind-Nat (add1 n) mot base step)__ and __(step n (ind-Nat n mot base step))__ are the same __(mot (add1 n))__.

- __ind-Nat's Step Type__
	- The step takes 2 args: a Nat n and an acc whose type is the motive applied to __n__. The step's answer type is the motive applied to __(add1 n)__. The step's type is: __(Π ((n Nat)) (-> (mot n) (mot (add1 n))))__.


