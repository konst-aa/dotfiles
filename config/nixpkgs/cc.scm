
(define (t cont n)
  (if (> n 100)
   (begin 
     (display "woo")
     (cont "blah"))
   (begin
     (t cont (+ n 1))
     (display n))))

(define (e n)
  (if (> n 100)
   (begin 
     (display "woo")
     "blah")
   (begin
     (e (+ n 1))
     (display n))))
(call/cc (lambda (cont) (t cont 0)))
(e 0)
