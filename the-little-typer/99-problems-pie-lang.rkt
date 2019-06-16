#lang pie

; p01 - find last element, which was given in The little typer
; We could use lists, but let's use the Vector type to make things more interesting.

; VECTORS
(claim vec-42 (Vec Nat 1))
(define vec-42 (vec:: 42 vecnil))
;vec-42
(claim vec-7-42 (Vec Nat 2))
(define vec-7-42 (vec:: 7 vec-42))

(claim base-last
  (Π ((E U))
    (-> (Vec E (add1 zero)) E)))
(define base-last
  (λ (E es) (head es)))
;(base-last Nat vec-42)

(claim mot-last (-> U Nat U))
(define mot-last
  (λ (E k)
    (-> (Vec E (add1 k)) E)))
;(mot-last Atom 0)

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

; (last Atom 3 vec_p01) ; => (the Atom 'd)  TEST
; (last Atom 2 (tail vec_p01)); TEST

; p02 next-to-last, or for eggheads and know-it-alls, penultimate

(claim base-next-to-last
  (Π ((E U))
    (-> (Vec E (add1 (add1 zero))) E)))
(define base-next-to-last
  (λ (E es) (head es)))
;(base-next-to-last Nat vec-42)

(claim mot-next-to-last (-> U Nat U))
(define mot-next-to-last
  (λ (E k)
    (-> (Vec E (add1 (add1 k))) E)))
;(mot-next-to-last Atom 0)

(claim step-next-to-last
  (Π ((E U)
      (l-1 Nat))
    (-> (mot-next-to-last E l-1)
      (mot-next-to-last E (add1 l-1)))))
(define step-next-to-last
  (λ (E l-1 next-to-last_l-1 es)
    (next-to-last_l-1 (tail es))))

(claim next-to-last
  (Π ((E U)
      (l Nat))
      (-> (Vec E (add1 (add1 l)))
    E)))
(define next-to-last
  (λ (E l)
    (ind-Nat  l
              (mot-next-to-last E)
              (base-next-to-last E)
              (step-next-to-last E))))
(next-to-last Atom 2 vec_p01) ; => (the Atom 'c) TEST
