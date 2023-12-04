(cl:in-package #:consecution)

(progn
  (replicate-for-each-vector-class #1=#:vector-class
    (defmethod substitute-if-not (newitem predicate (sequence #1#)
                                  &key from-end (start 0) end count key)
      #2=
      (let ((count (canonicalize-count count)))
        (if (zerop count)
            sequence
            (let ((pos (position-if-not predicate sequence
                                        :key key :start start :end end
                                        :from-end from-end)))
              (if (not pos)
                  sequence
                  (let ((copy (copy-seq sequence)))
                    (setf (elt copy pos) newitem)
                    (if (not from-end)
                        (nsubstitute-if-not newitem predicate copy
                                            :key key :start (1+ pos) :end end
                                            :count (1- count) :from-end nil)
                        (nsubstitute-if-not newitem predicate copy
                                            :key key :start start :end pos
                                            :count (1- count) :from-end t)))))))))

  (defmethod substitute-if-not (newitem predicate (sequence list)
                                &key from-end (start 0) end count key)
    #2#))

(seal-domain #'substitute-if-not '(t t vector))
(seal-domain #'substitute-if-not '(t t list))
