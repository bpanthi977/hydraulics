;;;; hydraulics.asd

(asdf:defsystem #:hydraulics
  :description "Describe hydraulics here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:system-solver)
  :components ((:file "package")
               (:file "hydraulics")
			   (:file "hydraulics-book")
			   (:file "hydraulics-book-other")))
