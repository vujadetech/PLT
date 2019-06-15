#lang racket

(define (sq x) (* x x))
(define (one? x) (= 1 x))
(define id identity)

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

(define iff
  (λ (cond consequent alternative)
    (cond consequent alternative)))

(define troo*
  (λ (f t) t))

(define fawlse*
  (λ (f t) f))

(define if*
  (λ (cond)
    (λ (consequent)
      (λ (alternative)
        (cond consequent alternative)))))

(define iterate ; return f iterated n times
  (λ (f n)
    (if (zero? n) id (λ (x) (f ((iterate f (- n 1)) x))))))

(define and*
  (λ (x)
    (λ (y) (if* x y false*))))

; Church numerals
(define zero
  (λ (f x) x))
(define one
  (λ (f x) (f x)))

(define is-zero?
  (λ (n) (n (λ (y) (and* (λ (x) false*) y)) true*)))

(define succ
  (λ (n)
    (λ (f x) (f (n f x)))))
