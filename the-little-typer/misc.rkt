#lang pie

; 42
(claim +
  (->  Nat Nat
     Nat))
(define +
  (λ (j k)
    (iter-Nat j k (λ (sum-so-far) (add1 sum-so-far)))))

(claim Pear U)
(define Pear (Pair Nat Nat))
;(the Pear (Pair 0 0))
;(the Pear (cons 3 4))

(claim sub1 (-> Nat Nat))
(define sub1
  (λ (n)
     (which-Nat n 0 (λ (n) n))))

(claim - (->  Nat Nat Nat))
(define -
  (λ (j k)
    (iter-Nat k j
	(λ (diff) (sub1 diff)))))

(claim *
  (->  Nat Nat
     Nat))
(define *
  (λ (j k)
    (iter-Nat j
 	0
	(λ (prod) (+ k prod)))))
;(* 3 3)

;(iter-Nat 5 0 (λ (n) n))
(claim ^
  (->  Nat Nat
     Nat))
(define ^
  (λ (j k)
    (iter-Nat k
 	1
	(λ (prod) (* j prod)))))

(claim double (-> Nat Nat))
(define double
   (λ (j)
      (rec-Nat j
	0
          (λ (n-1 sum) (+ 2 sum)))))

(claim double2 (-> Nat Nat))
(define double2
   (λ (j)
      (iter-Nat j
	0
          (λ (sum) (+ 2 sum)))))

#;(claim orange-exists
  (Σ ((fruit Atom))
    (= Atom fruit 'orange)))

(claim Even (-> Nat U))
(define Even
  (λ (n)
    (Σ ((half Nat)) (= Nat n (double half)))))

(claim zero-is-even (Even 0))
(define zero-is-even (cons 0 (same 0)))

; double 5
;(which-Nat 5 0 (λ (n-1) (+ 2 (+ n-1 n-1))))

;(which-Nat 5 0 (λ (n-1) (* 2 (+ n-1 n-1))))

;(iter-Nat 3 2  (λ (sum-so-far) (add1 sum-so-far)))
;(iter-Nat 3 2  (λ (sum-so-far) (+ sum-so-far sum-so-far)))
;(which-Nat 3 2  (λ (sum-so-far) (add1 sum-so-far)))
;(^ 2 3)

#;(rec-Nat (add1 zero)
	0
	(λ (n almost)  (add1  (add1 almost))))

;(rec-Nat 1 0 (λ (n-1 almost)  (add1  (add1 almost))))

(claim fac (-> Nat Nat))
;(define fac (λ (n) (rec-Nat n 1 (λ (n-1 acc) (* (add1 n-1) acc)))
(define fac
  (λ (n) (rec-Nat n 0
      (λ (n-1 acc) (+ (add1 n-1) acc)))))

; gauss, book version
(claim step-gauss (-> Nat Nat Nat))
(define step-gauss
  (λ (n-1 gauss)
    (+ (add1 n-1) gauss)))

(claim gauss (-> Nat Nat))
(define gauss
  (λ (n)
    (rec-Nat n 0
    step-gauss)))

;(claim gauss (-> Nat Nat))
#;(define gauss
  (λ (n)
     (which-Nat n 0
        (λ (sum) (* n n)))))

; (gauss 5)
(claim gauss2 (-> Nat Nat))
(define gauss2
  (λ (n)
    (rec-Nat n 0
       (λ (n-1 acc)
    	(+ (add1 n-1) acc)))))

#;(rec-Nat 4 0
  (λ (n-1 acc) (+ (add1 n-1) acc)))

(claim *-rn (->  Nat Nat Nat))
(define *-rn
  (λ (j k)
    (rec-Nat j 0
      (λ (j-1 acc) (+ k acc)))))
;(*-rn 3 4)

;(claim mod (-> Nat Nat Nat))
;(define mod (λ (n k)  (rec-Nat     (λ (n-1 acc

;(rec-nat 11 3 (λ (

; rec-Nats
; *
;(rec-Nat 3 4 5 (λ (n-1 acc) (λ (j-1 acc) (+ k acc))))
; factorial
;(rec-Nat 5 1  (λ (n-1 almost)  (* (add1 n-1) almost)))

(claim step-* (-> Nat Nat Nat Nat))
(define step-* (λ (j n-1 *acc) (+ j *acc)))
(claim *_ (-> Nat Nat Nat))
(define *_ (λ (x y)
  (rec-Nat (- x y) 0 (step-* y))))
;(*_ 9 2)

(claim *__ (-> Nat Nat Nat))
(define *__ (λ (x y)
  (rec-Nat x 0 (λ (n-1 *acc) (+ y *acc)))))
;(*__ 2 3)

; Primitive recursive building blocks; for boolean functions the return type is Nat with 1=true, 0=false.
(claim sgn (-> Nat Nat))
(define sgn (λ (n) (which-Nat n 0 (λ (_) 1))))
(claim sgn-bar (-> Nat Nat))
(define sgn-bar (λ (n) (which-Nat n 1 (λ (_) 0))))
(claim adf (-> Nat Nat Nat))
(define adf (λ (n m) (+ (- n m) (- m n))))
(claim x-eq (-> Nat Nat Nat))
(define x-eq (λ (n m) (sgn-bar (adf n m))))
(claim x-neq (-> Nat Nat Nat))
(define x-neq (λ (n m) (sgn (adf n m))))
(claim x-gt (-> Nat Nat Nat))
(define x-gt (λ (n m) (sgn (- n m))))
(claim x-geq (-> Nat Nat Nat)) ; ge = greater or equal
(define x-geq (λ (n m) (+ (sgn (- n m)) (x-eq n m))))
(claim not (-> Nat Nat))
(define not (lambda (x) (sgn-bar x)))
;(not 3)
;(not 0)
;(x-geq 5 4)
;(x-geq 4 4)
;(x-geq 3 4)

(claim min (-> Nat Nat Nat))
(define min (λ (n m) (+ (* m (x-geq n m)) (* n (x-gt m n)))))

(claim max (-> Nat Nat Nat))
(define max (λ (n m) (+ (* n (x-geq n m)) (* m (x-gt m n)))))
;(max 2 2)
;(max 3 10)
;(max 4 0)
;(claim x-gt (-> Nat Nat Nat))
;(define x-gt (λ (n m) (sgn (- n m))))

; Gotta have some C++/Java, whatever you wanna call it. Hopefully Steve Ballmer and Alan Turing would approve.
(claim ++ (-> Nat Nat))
(define ++ (lambda (n) (add1 n)))
(claim -- (-> Nat Nat))
(define -- (lambda (n) (sub1 n)))

;(x-gt 2 3)
;(x-gt 3 3)
;(x-gt 4 3)

; Proof wiki rem(n+1, m), so acc = rem(n,m) there, or rem(n-2, m) here since passing in n-1.
(claim step-mod (-> Nat Nat Nat Nat))
(define step-mod
  (λ (m n-1 acc) (* (x-neq acc (sub1 m)) (++ acc))) ) ; (* (sgn-bar (x-eq acc (-- m))) (* (sgn m) (add1 acc)))) )

(claim mod (-> Nat Nat Nat))
(define mod
  (λ (n m)
    (rec-Nat n 0 (step-mod m))))
;(mod 10 3)
;(mod 11 4)
;(mod 42 2)

(claim dividesQ (-> Nat Nat Nat))
(define dividesQ
  (lambda (k n) (not (mod n k))))
;(dividesQ 2 4)
;(dividesQ 3 7)

(claim step-/ (-> Nat Nat Nat Nat))
(define step-/
  (λ (m n-1 acc) (+ (sgn-bar (mod (add1 n-1) m)) (* (sgn m) acc))))
(claim / (-> Nat Nat Nat))
(define /
  (lambda (n m)
    (rec-Nat n 0 (step-/ m))))
;(/ 11 2)
;(/ 12 4)
;(/ 1 2)
;(/ 3 3)
;(/ 4 4)
;(/ 2 0)

(claim step-zerop (-> Nat Atom Atom))
(define step-zerop
  (lambda (n-1 acc) 'nil))

(claim zerop (-> Nat Atom))
(define zerop
 (lambda (n)
   (rec-Nat n 't step-zerop)))
;(zerop 0)
;(zerop 42)

; elim-Pair takes types A, D and X (cAr, cDr for the first 2 presumably),
; a function that takes a pair and a function that takes an A and D to an X
; and returns an X.
(claim elim-Pair
  (Π ((A U) (D U) (X U))
      (-> (Pair A D) (-> A D X) X)))
(define elim-Pair
  (λ (A D X)
    (λ (p f)
      (f (car p) (cdr p)))))

(claim kar (-> (Pair Nat Nat) Nat))
(define kar
  (λ (p)
    (elim-Pair Nat Nat Nat p
      (λ (a d) a))))
(claim kdr (-> (Pair Nat Nat) Nat))
(define kdr
  (λ (p)
    (elim-Pair Nat Nat Nat p
      (λ (a d) d))))
;(kar (cons 99 42))
;(kdr (cons 99 42))

(claim swap (-> (Pair Nat Atom) (Pair Atom Nat)))
(define swap
  (lambda (p)
    (elim-Pair Nat Atom (Pair Atom Nat)
      p (lambda (a d) (cons d a)))))
;(swap (cons 1 'a))

; So flip is a generic swap? Seems to be what they're driving at but haven't said it that way.
(claim flip
  (Π ((A U) (D U))
    (-> (Pair A D) (Pair D A))))
(define flip
  (lambda (A D)
    (lambda (p)
      (cons (cdr p) (car p)))))

;((flip Nat Atom) (cons 2 'b))

(claim twin (Π ((Y U)) (-> Y (Pair Y Y))))
(define twin
  (λ (Y)
    (λ (x) (cons x x))))
;((twin Atom) 'duran)

(claim expectations (List Atom))
(define expectations (:: 'cook (:: 'eat (:: 'sleep nil))))
;expectations

(claim step-length (Π ((E U)) (-> E (List E) Nat Nat)))
(define step-length
  (λ (E)
    (λ (e es len_es) (add1 len_es))))

;(step-length Atom 'wake-up expectations 3)

(claim length
  (Π ((E U))
    (-> (List E) Nat)))
(define length
  (λ (E)
    (λ (es)
      (rec-List es
                0
                (step-length E)))))

((length Atom) expectations)
;expectations
;nil
;(the (List Atom) expectations)

(claim step-append
  (Π ((E U))
    (-> E (List E) (List E) (List E))))
(define step-append
  (λ (E)
    (λ (e es append_es)
      (:: e append_es))))
((step-append Atom) 'e nil expectations)

(claim append
  (Π ((E U))
    (-> (List E) (List E) (List E))))
(define append
  (λ (E)
    (λ (start end)
      (rec-List start
                end
                (step-append E)))))
((append Atom) nil nil)
((append Atom) (the (List Atom) (:: 'a nil)) (the (List Atom) (:: 'a nil)) )
;(append Atom)

;ΠΠΠΠΠΠ
;ΣΣΣΣΣΣ
;λλλλλλλ
