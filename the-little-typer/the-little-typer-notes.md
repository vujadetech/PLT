### The Little Typer Notes

- First Commandment of _cons_
	- Two cons-exps are the same (Pair A D) if their cars are the same A and cdrs the same D, where A and D are any type.
	
- Ill typed
	- __(Pair (cdr (cons Atom 'olive)) (car (cons 'oil Atom)))__ is neither described by a type, nor is it a type, so asking for its normal form is meaningless. Also called _ill-typed_.

- Values
	- An expression with a constructor at the top is called a _value_. Values are also called _canonical expressions_.
	
- The constructors of Nat are _zero_ and _add1_, while the constructor of __Pair__ is _cons_.