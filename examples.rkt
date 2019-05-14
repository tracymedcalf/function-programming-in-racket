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

