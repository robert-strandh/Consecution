(cl:in-package #:consecution)

(define-condition must-be-nonnegative-integer (type-error)
  ()
  (:default-initargs :expected-type '(integer 0)))

(define-condition must-be-cons (type-error)
  ()
  (:default-initargs :expected-type 'cons))

(define-condition must-be-sequence (type-error)
  ()
  (:default-initargs :expected-type 'sequence))

(define-condition must-be-function-designator (type-error)
  ()
  (:default-initargs :expected-type '(or function symbol)))

(define-condition must-be-list (type-error)
  ()
  (:default-initargs :expected-type 'list))

(define-condition must-be-proper-list (type-error)
  ()
  (:default-initargs :expected-type 'list))

(define-condition must-be-recognizable-subtype-of-sequence (type-error)
  ()
  (:default-initargs :expected-type 'sequence-type-specifier))

(define-condition must-be-recognizable-subtype-of-vector
    (must-be-recognizable-subtype-of-sequence)
  ())

(define-condition must-be-result-type (type-error)
  ())

(define-condition must-be-count (type-error)
  ()
  (:default-initargs :expected-type '(or null integer)))

;;; Index Handling

(define-condition invalid-sequence-index (type-error)
  ((%in-sequence :initarg :in-sequence :reader in-sequence)))

(define-condition invalid-bounding-index (invalid-sequence-index)
  ())

;;; This condition is used by sequence functions when the START
;;; bounding indexes is invalid.  This can be because it is not an
;;; integer, or because it is less than 0 or greater than the length
;;; of the sequence.
(define-condition invalid-start-index (invalid-bounding-index)
  ())

;;; This condition is used by sequence functions when the END bounding
;;; indexes is invalid.  This can be because it is neither an integer
;;; nor NIL, or because it is less than 0 or greater than the length
;;; of the sequence.
(define-condition invalid-end-index (invalid-bounding-index)
  ())

(define-condition end-less-than-start (invalid-bounding-index)
  ((%start-index :initarg :start-index :reader start-index)))

;;; Test and Test-Not Handling

(define-condition both-test-and-test-not-given (error)
  ())

(define-condition warn-both-test-and-test-not-given (warning)
  ())
