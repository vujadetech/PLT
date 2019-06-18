#lang pie

; VECTORS for Nat testing
(claim vec-42 (Vec Nat 1))
(define vec-42 (vec:: 42 vecnil))
(claim vec-7-42 (Vec Nat 2))
(define vec-7-42 (vec:: 7 vec-42))

; utilities
(claim +
  (->  Nat Nat
     Nat))
(define +
  (λ (j k)
    (iter-Nat j k (λ (sum-so-far) (add1 sum-so-far)))))

; p01 - find last element, which was given in The little typer
; We could use lists, but let's use the Vector type and ind-Nat
; (induction on natural numbers) to make things more interesting.

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
; (base-next-to-last Nat vec-7-42) ; TEST

(claim mot-next-to-last (-> U Nat U))
(define mot-next-to-last
  (λ (E k)
    (-> (Vec E (add1 (add1 k))) E)))
; (mot-next-to-last Atom 0)

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
;(next-to-last Atom 2 vec_p01) ; => (the Atom 'c) TEST
;(next-to-last Nat 0 vec-7-42) ; TEST

; p03, try kth-from-last first in keep with the "last" theme

(claim base-kth-from-last
  (Π ((E U))
    (-> (Vec E (add1 zero)) E)))
(define base-kth-from-last
  (λ (E es) (head es)))
;(base-kth-from-last Nat 0 vec-42)

(claim mot-kth-from-last (-> U Nat U))
(define mot-kth-from-last
  (λ (E n-k-1)
    (-> (Vec E (add1 n-k-1)) E)))
(mot-kth-from-last Atom 2)
(mot-last Atom 0)

(claim step-kth-from-last
  (Π ((E U)
      (l-1 Nat))
    (-> (mot-kth-from-last E l-1)
      (mot-kth-from-last E (add1 l-1)))))
(define step-kth-from-last
  (λ (E l-1 kth-from-last_l-1 es)
    (kth-from-last_l-1 (tail es))))

(claim kth-from-last
  (Π ((E U)
      (l-k+1 Nat))
      (-> (Vec E (add1 l-k+1))
    E)))
(define kth-from-last
  (λ (E l-k+1)
    (ind-Nat  l-k+1
              (mot-kth-from-last E)
              (base-kth-from-last E)
              (step-kth-from-last E))))

(kth-from-last Atom 3 vec_p01) ; => (the Atom 'c) TEST
;(kth-from-last Nat 1 vec-7-42) ; => (the Atom 'c) TEST


; p05, reverse
; For comparison, drop-last (base mot step)

(claim base-drop-last
  (Π ((E U))
    (-> (Vec E (add1 zero)) (Vec E zero))))
(define base-drop-last
  (λ (E es) vecnil))
;(base-drop-last Nat vec-42)

(claim mot-drop-last (-> U Nat U))
(define mot-drop-last
  (λ (E k)
    (-> (Vec E (add1 k)) (Vec E k))))
;(mot-drop-last Atom 1)

(claim step-drop-last
  (Π ((E U)
      (l-1 Nat))
    (-> (mot-drop-last E l-1)
      (mot-drop-last E (add1 l-1)))))
(define step-drop-last
  (λ (E l-1 drop-last_l-1 es)
    (vec:: (head es) (drop-last_l-1 (tail es)))))

(claim drop-last
  (Π ((E U)
      (l Nat))
      (-> (Vec E (add1 l))
    (Vec E l))))
(define drop-last
  (λ (E l)
    (ind-Nat  l
              (mot-drop-last E)
              (base-drop-last E)
              (step-drop-last E))))
;(drop-last Atom 1 vec_carrot_celery)

(claim base-reverse
  (Π ((E U))
    (-> (Vec E zero) (Vec E zero))))
(define base-reverse
  (λ (E es) vecnil))

; * version of reverse is non ind-Nat
(claim step-reverse*
  (Π ((E U))
    (-> E (List E) (List E) (List E))))
#;(define step-reverse*
  (λ (E)
    (λ (e es acc)
      (snoc E acc e))))

#;(claim reverse
  (Π ((E U))
    (-> (List E) (List E))))
#;(define reverse
  (λ (E)
    (λ (es)
      (rec-List es
                (the (List E) nil)
                (step-reverse E)))))
