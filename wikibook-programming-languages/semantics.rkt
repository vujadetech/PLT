#lang racket

(define (sq x) (* x x))
(define (one? x) (= 1 x))
(define id identity)
(define (++ x) (+ x 1))

(define create-adder
  (λ (n)
    (λ (m) (+ n m))))

(define create-subber
  (λ (n)
    (λ (m) (- n m))))

(define true*
  (λ (t f) t))
(define false*
  (λ (t f) f))
(define t* true*)
(define f* false*)



; (map (λ(x) (apply f x)) (apply-to-all f all-combos))

(define if*
  (λ (cond consequent alternative)
    (cond consequent alternative)))

(define not*
  (λ (x) (if* x false* true*)))

(define bool-eq*
  (λ (x y) (if* x y (not* y))))

(define and*
  (λ (x y) (if* x y false*)))

(define or*
  (λ (x y) (if* x true* y)))

(define equal*
  (λ (x y) (if* x y (not* y))))

; all 4 combos of  binary vars
(define all-combos '((false* false*) (false* true*) (true* false*) (true* true*)))

(define apply-to-all ; f is a 2-ary func
  (λ (f ps) (map (λ(x) (apply f x)) (map (λ (p) (map eval p)) ps))))

(define test-f
  (λ (f) (apply-to-all f all-combos)))

; Church numerals

; iterate will just be for convenience of dealing with Church numerals 
(define iterate ; return f iterated n times
  (λ (f n)
    (if (zero? n) id (λ (x) (f ((iterate f (- n 1)) x))))))

(define zero (λ (_ x) x))
;(define one (λ (f x) (f x)))
;(define two (λ (f x) (f (f x))))

(define is-zero?
  (λ (n) (n (λ (y) (and* false* y)) true*)))


(define succ
  (λ (n)
    (λ (f x) (f (n f x)))))
; since (zero f x) = x, (succ zero) = (λ (f x) (f x)), that is, it applies its first input to its 2nd input

(define one (succ zero))
;(define two (succ one))

#;(define add1 ; using name from The Little Typer; succ with with f = (+ 1)
  (λ (n)
    (λ (x) (succ n ++ 0))))

(define plus (λ (n m) (n succ m)))
(define plus-2 (λ (n) (n succ two)))
(define plus-c ; curried plus 
  (λ (m)
    (λ (n) (plus n m)))) ;  (n succ m))))
(define times ; to multiply church numerals, iterate adding m to zero n times in a row
  (λ (n m) (n (plus-c m) zero)))
(define times-c
  (λ (n) (λ (m) (n (plus-c m) zero))))

(define pow
;  (λ (n m) (m (λ (x) (times n x)) one)))
  (λ (n m) (m (times-c n) one)))

;(is-zero? (plus zero zero))
;(is-zero? (plus zero one))
;(is-zero? (plus one zero))
(define two (plus one one))
(define three (plus two one))
(define four (plus two two))
(define six (three plus-2 zero))
(define eight (four (plus-c two) zero))

#;(define make-church ; make church numeral from arabic numeral
  (λ (x) (iterate )))

;(define get-arabic


