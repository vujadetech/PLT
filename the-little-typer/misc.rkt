#lang pie

42
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

(claim / (->  Nat Nat Nat Nat Nat))
(define /
  (λ (j k acc init)
    (rec-Nat acc j
      (λ (j-1 acc) (+ k acc)))))
;(/ 6 1 0 6)

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

(claim sgn (-> Nat Nat))
(define sgn (λ (n) (which-Nat n 0 (λ (_) 1))))
(claim sgn-bar (-> Nat Nat))
(define sgn-bar (λ (n) (which-Nat n 1 (λ (_) 0))))
(claim adf (-> Nat Nat Nat))
(define adf (λ (n m) (+ (- n m) (- m n))))
(claim x-eq (-> Nat Nat Nat))
(define x-eq (λ (n m) (sgn-bar (adf n m))))
;(x-eq 2 3)


(claim step-mod (-> Nat Nat Nat Nat))
(define step-mod (λ (m n-1 acc) (* (sgn-bar (x-eq acc (sub1 m))) (* (sgn m) (add1 acc)))) )
;(step-mod 7 2 0)

(claim mod (-> Nat Nat Nat))
(define mod
  (λ (n m)
    (rec-Nat n 0 (step-mod m))))
(mod 10 3)
(mod 11 4)
(mod 42 2)


;(claim / (->  Nat Nat Nat))
#;(define /
  (λ (j k)
    (iter-Nat k 1 (λ (quot)  quot))))

;(rec-Nat 7 2  (λ (n-1 almost)  ((step-mod 2) n-1 2)))

(claim modAcc (-> Nat Nat Nat Nat))
(define modAcc
  (λ (n k acc)
    (rec-Nat n 0 (λ (n-1 almost) ((step-mod k) acc almost)))))
;(modAcc 7 2 7)

(claim elim-Pair
  (Π ((A U) (D U) (X U))
      (-> (Pair A D)
        (-> A D
            X)
            X)))

(define elim-Pair
(λ (A D X)
  (λ (p f)
    (f (car p) (cdr p)))))

(claim kar (-> (Pair Nat Nat) Nat))
(define kar
  (λ (p)
    (elim-Pair Nat Nat Nat p
      (λ (a d) a))))
