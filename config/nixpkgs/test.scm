
(define (t cont n)
    (if (> n 10)
      (begin 
        (display "done")
        (cont "blah"))
      (begin 
        (t cont (+ n 1))
        (display n))))

(call/cc (lambda (cont) (t cont 0)))
