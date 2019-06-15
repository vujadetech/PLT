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

;((length Atom) expectations)
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
;((step-append Atom) 'e nil expectations)

(claim append
  (Π ((E U))
    (-> (List E) (List E) (List E))))
(define append
  (λ (E)
    (λ (start end)
      (rec-List start
                end
                (step-append E)))))
;((append Atom) nil nil)
;((append Atom) (the (List Atom) (:: 'a nil)) (the (List Atom) (:: 'a nil)) )
;(claim append-a)
;(define append-a ((append Atom) (the (List Atom) (:: 'a nil))))

; append* is append but without step-append
(claim append*
  (Π ((E U))
    (-> (List E) (List E) (List E))))
(define append*
  (λ (E)
    (λ (start end)
      (rec-List start
                end
                (λ (e es acc) (:: e acc))))))

(claim snoc
  (Pi ((E U))
    (-> (List E) E
      (List E))))
(define snoc
  (λ (E)
    (λ (start e)
      (rec-List start
                (:: e nil)
                (step-append E)))))

(claim snoc-Nat
  (-> (List Nat) Nat
    (List Nat)))
(define snoc-Nat
  (λ (start e)
    (rec-List start
              (:: e nil)
              (step-append Nat))))
;(snoc-Nat (:: 99 (:: 42 nil)) 0)
;(snoc Atom expectations 'marryMotherInLaw)

; snoc* uses append instead of rec-List
(claim snoc*
  (Pi ((E U))
    (-> (List E) E
      (List E))))
(define snoc*
  (lambda (E)
    (lambda (start e)
      (append E start (:: e nil)))))
;(snoc* Nat (:: 1 nil) 42)

(claim step-reverse
  (Π ((E U))
    (-> E (List E) (List E) (List E))))
(define step-reverse
  (λ (E)
    (λ (e es acc)
      (snoc E acc e))))

(claim reverse
  (Π ((E U))
    (-> (List E) (List E))))
(define reverse
  (λ (E)
    (λ (es)
      (rec-List es
                (the (List E) nil)
                (step-reverse E)))))
;(reverse Atom expectations)

(claim step-concat
  (Π ((E U))
    (-> E (List E) (List E) (List E))))
(define step-concat
  (λ (E)
    (λ (e es concat_es)
      (:: e concat_es))))

(claim concat
  (Pi ((E U))
    (-> (List E) (List E)
      (List E))))
(define concat
  (λ (E)
    (λ (start end)
      (rec-List start
                end
                (step-concat E)))))

(claim step-concat*
  (Π ((E U))
    (-> E (List E) (List E) (List E))))
(define step-concat*
  (λ (E)
    (λ (e es concat_es)
      (snoc E concat_es e))))

(claim concat*
  (Pi ((E U))
    (-> (List E) (List E)
      (List E))))
(define concat*
  (λ (E)
    (λ (start end)
      (rec-List (reverse E end)
                start
                (step-concat* E)))))

;(the (List Atom) (:: 'a nil))
(claim x Nat)
(define x 42)
(claim a (List Atom))
(define a (:: 'a nil))
(claim ab (List Atom))
(define ab (:: 'a (:: 'b nil)))
(claim cd (List Atom))
(define cd (:: 'c (:: 'd nil)))
(claim efg (List Atom))
(define efg (:: 'e (:: 'f (:: 'g  nil))))
;(append Atom ab cd)
;(append* Atom ab cd)
;(append Atom ab (:: 'c nil))
;(concat Atom ab cd)
;(concat* Atom ab cd)
;(concat Atom ab efg)
;(concat* Atom ab efg)
;(concat Atom efg ab)
;(concat* Atom efg ab)


;(claim Pear U)
;(define Pear (Pair Nat Nat))
;(the Pear (Pair 0 0))
;(the Pear (cons 3 4))

; VECTORS
(claim vec-42 (Vec Nat 1))
(define vec-42 (vec:: 42 vecnil))
;vec-42
(claim vec-7-42 (Vec Nat 2))
(define vec-7-42 (vec:: 7 vec-42))
;vec-7-42
;(head vec-7-42)

; Vector of sublists of Nat
;(the (Vec (List Nat) 1) (vec:: (:: 42 nil) vecnil))

;(head (the (Vec Nat 2) (vec:: 7 (vec:: 42 vecnil))))
;(tail (the (Vec Nat 2) (vec:: 7 (vec:: 42 vecnil))))


(claim first-of-one
  (Π ((E U))
    (-> (Vec E 1) E)))
(define first-of-one
  (λ (E)
    (λ (v) (head v))))
;(first-of-one Nat vec-42)
;(first-of-one Nat vec-7-42) ; compiler complains about length, which is good
;(first-of-one Nat vecnil) ; ditto

(claim first-of-two
  (Π ((E U))
    (-> (Vec E 2) E)))
(define first-of-two
  (λ (E)
    (λ (v) (head v))))
;(first-of-two Nat vec-7-42)
;(first-of-two Nat vec-42)

(claim first
  (Π ((E U) (l Nat))
    (-> (Vec E (add1 l)) E)))
(define first
  (λ (E l)
    (λ (es) (head es))))
;(first Nat 0 vec-42)
;(first Nat 1 vec-7-42)

; alternate way of writing Pi w/o arrow as show on p128
(claim first*
  (Π ((E U)
      (l Nat)
      (es (Vec E (add1 l))))
    E))
(define first*
  (λ (E l es) (head es)))
;(first* Nat 0 vec-42)
;(first* Nat 1 vec-7-42)

(claim rest
  (Π ((E U) (l Nat))
    (-> (Vec E (add1 l)) (Vec E l))))
(define rest
  (λ (E l)
    (λ (es) (tail es))))
;(rest Nat 0 vec-42)
;(rest Nat 1 vec-7-42)

; arrow-less/Pi only version
(claim rest*
  (Π ((E U)
      (l Nat)
      (es (Vec E (add1 l))))
    (Vec E l)))
(define rest*
  (λ (E l)
    (λ (es) (tail es))))
;(rest* Nat 0 vec-42)
;(rest* Nat 1 vec-7-42)

; ind-Nat
(claim mot-peas (-> Nat U))
(define mot-peas
  (λ (k) (Vec Atom k)))

(claim no-peas (-> Nat U))
;(define no-peas (mot-peas 0))
;(mot-peas 0)
;(mot-peas 1)
;(::vec 'peas )

(claim step-peas
  (Π ((l-1 Nat))
      (-> (mot-peas l-1) (mot-peas (add1 l-1)))))
(define step-peas
  (λ (l-1 acc) (vec:: 'peas acc)))
;(step-peas 0)
;(step-peas 1)

; step-peas*, step-peas without arrows/arrowless
(claim step-peas*
  (Π ((l-1 Nat)
      (acc (mot-peas l-1)))
    (mot-peas (add1 l-1))))
(define step-peas*
  (λ (l-1 acc) (vec:: 'peas acc)))

(claim peas
  (Π ((n Nat)) (Vec Atom n)))
(define peas
  (λ (n)
    (ind-Nat  n
              (λ (k) (Vec Atom k))
              vecnil
              step-peas*))) ; (λ (n-1 peas_n-1) (vec:: 'pea peas_n-1)))))
;(peas 3)
;(peas 0)

(claim also-rec-Nat
  (Π ((X U))
    (-> Nat
        X
        (-> Nat X
          X)
        X)))
(define also-rec-Nat
  (λ (X)
    (λ (target base step)
      (ind-Nat target
             (λ (k) X)
             base
             step))))

; also-rec-Nat* = arrowless version
(claim also-rec-Nat*
  (Π ((X U)
      (target Nat)
      (base X)
      (step (-> Nat X X)))
    X))
(define also-rec-Nat*
  (λ (X)
    (λ (target base step)
      (ind-Nat target
             (λ (k) X)
             base
             step))))

(claim also-rec-Nat**
 (Π ((X U)
     (target Nat)
     (base X)
     (step (-> Nat X X)))
   X))
(define also-rec-Nat**
  (λ (X)
   (λ (target base step)
     (ind-Nat target
            (λ (k) X)
            base
            step))))

(claim repeat-a
  (Π ((n Nat))
    (List Atom)))
(define repeat-a
   (λ (j)
      (rec-Nat j
	             (the (List Atom) nil)
               (λ (n-1 acc) (:: 'a acc)))))
;(repeat-a 3)

; repeat-a* is also-rec-Nat version
(claim repeat-a*
  (Π ((n Nat))
    (List Atom)))
(define repeat-a*
   (λ (j)
      (also-rec-Nat (List Atom)
                    j
	                  nil ; Don't have to say (the (List Atom) nil) here since X=(List Atom) passed first
                    (λ (n-1 acc) (:: 'a acc)))))
;(repeat-a* 2)

; fac* = fac using also-rec-Nat*
 (claim fac* (-> Nat Nat))
 (define fac*
  (λ (n) (also-rec-Nat* Nat n 1
      (λ (n-1 acc) (* (add1 n-1) acc)))))
; (fac* 5)


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

; step-peas*, step-peas without arrows/arrowless
#;(claim step-peas*
  (Π ((l-1 Nat)
      (acc (mot-peas l-1)))
    (mot-peas (add1 l-1))))
#;(define step-peas*
  (λ (l-1 acc) (vec:: 'peas acc)))

#;(define also-rec-Nat
  (λ (X)
    (λ (target base step)
      (ind-Nat target
             (λ (k) X)
             base
             step))))

;(first Nat 0 vec-42)
;(first Nat 1 vec-7-42)

;ΠΠΠΠΠΠ
;ΣΣΣΣΣΣ
;λλλλλλ
