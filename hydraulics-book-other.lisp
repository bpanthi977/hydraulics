(in-package #:hydraulics)
;; Trapezoidal integration
(defun trapezoidal-integration (x y)
  (loop for i from 0 to (- (length x) 2)
     summing (* (- (nth (1+ i) y)
		   (nth i y))
		(+ (nth (1+ i) x)
		   (nth i x))
		0.5)))

;; Book data
(defun book-data ()
  (loop for y from 0 to 2.401 by 0.1
     collect (list y
		   (if (> y 2)
		       (- (- y 2))
		       (* 1.4 (- 1 (/ y 2)))))))
       
(defun book-problem ()
  (let ((data (book-data)))
    (calculate-coeffs (mapcar #'first data)
		      (mapcar #'second data)
		      1
		      0)))

;; Energy and Momentum Coefficient
(defun calculate-coeffs (ys vels b z)
  (let* ((xs (mapcar (lambda (d) (+ b (* 2 d z))) ys))
	 (ymax (first (last ys)))
	 (area (* (+ b (* z ymax)) ymax))
	 (av (/ (trapezoidal-integration (mapcar (lambda (x v) (* x v)) xs vels) ys) area))
	 (av2 (trapezoidal-integration (mapcar (lambda (x v) (* x (expt v 2))) xs vels) ys))
	 (av3 (trapezoidal-integration (mapcar (lambda (x v) (* x (expt v 3))) xs vels) ys)))
    (print av)
    (format t  "Average velocity: ~a~%" av)
    (format t "Momentum Coefficient: ~a~%" (/ av2 (expt av 2) area))
    (format t "Energy Coefficient: ~a~%" (/ av3 (expt av 3) area))))
    
(defun e-and-m-coeff ()
  (let ((b (progn (print "Base Width") (read)))
	(z (progn (print "Size Slope") (read)))
	(n (progn (print "Enter Number of depths") (read))))
    (print "Enter y and vel")
    (loop for i from 1 to n
       with vel = nil
       with depth = nil do
	 (print i)
	 (push (read) depth)
	 (push (read) vel)
       finally
	 (calculate-coeffs (reverse depth) (reverse vel) b z))))	
;; (defun direct-step ()
;;   (let ((y1 10)
;; 	(y2 5)
;; 	(b 10)
;; 	(z 1)
;; 	(manning-n 0.002)
;; 	(s0 0.0001)
;; 	(q 1)
;; 	(steps 10)
;; 	(final-delx 0))
;;     (format t "~% y a p r E sf avg_sf delx")
;;     (loop for n from 1 to steps
;;        with dely = (/ (- y2 y1) steps)
;;        with y = y1
;;        with avg-sf = nil
;;        with prev-sf = nil 
;;        with delx = nil 
;;        for  a = (* (+ b (* y z)) y)
;;        for p = (+ b (* 2 y (sqrt (1+ (* z z)))))
;;        for r =(/ a p)
;;        for E = (+ y (/ (expt q 2) (* 2 9.81 (expt a 2))))
;;        for sf = (expt (/ (* n q) (* a (expt r 2/3))) 2) do
;; 	 (when (> n 1)
;; 	   (setf avg-sf (* 0.5 (+ sf prev-sf)))
;; 	   (setf delx (/ e (- s0 avg-sf)))
;; 	   (incf final-delx delx))
;; 	 (format t "~% ~a ~a ~a ~a ~a ~a" y a p r E sf avg-sf delx)
;; 	 (incf y dely)
;;        finally (format t "~% Final Delx = ~a" final-delx))))

;; (defun three-reservoir ()
;;   (with-parameters (q1 q2 q3)
;;     (satisfying-relations (lambda (q1 q2 q3)
;; 			    (+ q1 q2 q3))
;; 			  (lambda (q1 q3)
;; 			    (+ (* 0.35 (expt (abs q1) 2) (signum q1))
;; 			       (* 0.6 (expt (abs q3) 1.95) (signum q3))
;; 			       -14.5))
;; 			  (lambda (q2 q3)
;; 			    (+ (* .46 (expt (abs q2) 1.85) (signum q2))
;; 			       (* .6 (expt (abs q3) 1.95) (signum q3))
;; 			       -10.5)))
;;     (solve-for (list q1 q2 q3))))
