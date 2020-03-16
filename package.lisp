;;; package.lisp

(defpackage #:hydraulics
  (:use #:cl #:system-solver)
  (:export #:pipe
		   #:connect-pipes
		   #:re
		   #:vel
		   #:d
		   #:nu
		   #:q
		   #:a
		   #:r
		   #:hf
		   #:p1
		   #:p2
		   #:z1
		   #:z2
		   #:f
		   #:e
		   #:l
		   #:f*
		   #:k))
