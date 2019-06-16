#lang pie

; p01 - find last element, which was given in The little typer


(claim base-last
  (Π ((E U))
    (-> (Vec E (add1 zero)) E)))
(define base-last
  (λ (E es) (head es)))
;(base-last Nat vec-42)

; NB some weird stuff: U since it's mapping types
(claim mot-last (-> U Nat U))
(define mot-last
  (λ (E k)
    (-> (Vec E (add1 k)) E)))
;(mot-last Atom 1)

(claim step-last
  (Π ((E U)
      (l-1 Nat))
    (-> (mot-last E l-1)
      (mot-last E (add1 l-1)))))
(define step-last
  (λ (E l-1 last_l-1 es)
    (last_l-1 (tail es))))

(claim last
  (Π ((E U)
      (l Nat))
      (-> (Vec E (add1 l))
    E)))
(define last
  (λ (E l)
    (ind-Nat  l
              (mot-last E)
              (base-last E)
              (step-last E))))
(claim vec_p01 (Vec Atom 4))
(define vec_p01  (vec:: 'a (vec:: 'b (vec:: 'c (vec:: 'd vecnil)))))
(last Atom 3 vec_p01) ; => (the Atom 'd)
