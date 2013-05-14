;; Simulation of Anki review growth.

(define cards-per-day 200)
(define max-ease 295)
(define min-ease 170)
(define avg-ease 246)
(define correct-percent 50)

(define correctly-answered?
 (lambda ()
    (<= (random 100) correct-percent)))

(define ease-range
  (- max-ease min-ease))

(define get-ease
  (lambda ()
   (/ (+ (random ease-range) min-ease) 100)))

(define reschedule-card
  (lambda (x)
    (cond
     ((correctly-answered?) (ceiling (* x (get-ease))))
     (else
      (add1 x)))))

(define todays-reviews
  (lambda (reviews day)
    (length (filter (lambda (x) (eq? day x)) reviews))))

(define add-cards
  (lambda (reviews scheduled-for)
    (append reviews (repeat scheduled-for cards-per-day))))

(define repeat
  (lambda (x n)
          (cond
           ((eq? n 0) '())
           (else
            (cons x (repeat x (sub1 n)))))))

(define reschedule
  (lambda (card day)
    (cond ((eq? card day) (reschedule-card card))
          (else card))))

(define reschedule-deck
  (lambda (reviews day)
    (map
     (lambda (card) (reschedule card day))
     (add-cards reviews day))))

(define how-many-due?
  (lambda (reviews day)
    (+ (* 2 cards-per-day) (length (filter (lambda (card) (eq? card day)) reviews)))))

(define simulate-n-days
  (lambda (reviews day n)
    (cond
     ((eq? day n) (cons (how-many-due? reviews day) '()))
     (else
      (cons
       (how-many-due? reviews day)
       (simulate-n-days (reschedule-deck reviews day) (add1 day) n))))))

(define sum
  (lambda (x)
    (foldl + 0 x)))

(define avg
  (lambda (x)
    (exact->inexact (/ (sum x) (length x)))))

(define cards-added-reviews-day
  (lambda (x n)
    (cond
     ((> x n) '())
     (else
      (set! cards-per-day x)
      (cons
       (cons x (list (avg (simulate-n-days '() 1 20))))
       (cards-added-reviews-day (+ x 5) n))))))

(cards-added-reviews-day 5 1000)
