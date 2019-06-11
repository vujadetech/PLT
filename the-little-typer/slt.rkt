#lang pie

(claim +
  (->  Nat Nat
     Nat))
(define +
  (λ (j k)
    (iter-Nat j
 	k
	(λ (sum-so-far) (add1 sum-so-far)))))
