(define (apply-bitmask mask val)
(if (empty? val) '()
  (if (= 1 (car mask)) (cons (car val) (apply-bitmask (cdr mask) (cdr val))) 
    (apply-bitmask (cdr mask) (cdr val)))))

(writeln (apply-bitmask '(1 0 1 0) '(8 9 7 6)))


(define (my-reverse original accumulator)
  (if (empty? original) accumulator
        (my-reverse (cdr original) (cons (car original) accumulator)
                 )))

(writeln (my-reverse '(1 2 3 4) '()))

(define (my-reverse original) (my-reverse-aux original '()))

(define (fun1) "returned by fun1")

(define (eval-arg arg) (arg))

(writeln (eval-arg fun1))

(define (my-map function lis)
  (if (empty? lis) '()
  (cons (function (car lis)) (my-map function (cdr lis)))))

(writeln (my-map (lambda [x] (+ x 1)) '(10 10 10 10)))

; A function that returns itself
(define (return-me msg)
  (printf "calling return-me from ~a\n" msg)
  (lambda [msg*] (return-me msg*)))

(return-me "thing")

(define (fun2 fun)
  (fun3 (return-me "fun2")))

(define (fun3 fun)
  (fun4 (return-me "fun3")))

(define (fun4 fun)
  ((return-me "fun4") "fun4 again"))

(fun2 return-me)
