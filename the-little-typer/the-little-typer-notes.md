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


- general note (from wiki/intuitionistic_type_theory) on Type theory for set theorists: Types contain terms just as sets contain elements. Terms belong to only one type. Terms like 2 + 2 compute/reduce to canonical terms like 4.