
(in-package :ccl)

;;; guard against eof in mid sequence

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))

  (DEFun %%assq-combined-method-dcode (stuff args)
  ;; stuff is (argnum eql-method-list . default-method)
  ;(declare (dynamic-extent args))
  (if (listp args)
    (let* ((args-len (list-length args))
           (argnum (car stuff)))
      (when (>= argnum args-len)
        (Error "Too few args to ~s."
               (or (ignore-errors (%method-gf (cddr stuff)))
                   (combined-method.gf (cddr stuff)))))
      (let* ((arg (nth argnum args))
             (thing (assq arg (cadr stuff)))) ; are these things methods or method-functions? - fns    
        (if thing 
          (apply (cdr thing) args)
          (apply (cddr stuff) args))))
    (let* ((args-len (%lexpr-count args))
           (argnum (car stuff)))
      (when (>= argnum args-len)
        (Error "Too few args to ~s."
               (or (ignore-errors (%method-gf (cddr stuff)))
                   (combined-method.gf (cddr stuff)))))
      (let* ((arg (%lexpr-ref args args-len argnum))
             (thing (assq arg (cadr stuff)))) ; are these things methods or method-functions? - fns    
        (if thing 
          (%apply-lexpr (cdr thing) args)
          (%apply-lexpr (cddr stuff) args))))))
  )

