(cl:in-package #:sicl-sequence)

(defmacro for-each-relevant-cons
    ((cons index list start end &optional (from-end nil)) &body body)
  (check-type cons symbol)
  (check-type index symbol)
  (alx:once-only (list start end)
    (let ((forward
            (alx:with-gensyms (iterator more)
              `(with-cons-iterator (,iterator) (,list ,start ,end)
                 (loop
                   (multiple-value-bind (,more ,cons ,index) (,iterator)
                     (declare (ignorable ,index))
                     (unless ,more (return))
                     ,@body)))))
          (backward
            (alx:with-gensyms (fn rest length)
              `(with-list-start-and-end (,start ,end ,length) (,list ,start ,end)
                 (setf ,list (nthcdr ,start ,list))
                 (setf ,length (- ,end ,start))
                 (labels ((,fn (,rest ,index ,length)
                            (declare (type fixnum ,length))
                            (when (> ,length 0)
                              (when (consp ,rest)
                                (traverse (cdr ,rest)
                                          (1+ ,index)
                                          (1- ,length))
                                (let ((,cons ,rest))
                                  ,@body))))
                          (traverse (rest index length)
                            (declare (type fixnum index length))
                            (if (< length 100)
                                (,fn rest index length)
                                (let* ((p8 (ash length -1))
                                       (p4 (ash p8 -1))
                                       (p2 (ash p4 -1))
                                       (p1 (ash p2 -1))
                                       (p3 (+ p2 (ash (- p4 p2) -1)))
                                       (p6 (+ p4 (ash (- p8 p4) -1)))
                                       (p5 (+ p4 (ash (- p6 p4) -1)))
                                       (p7 (+ p6 (ash (- p8 p6) -1)))
                                       (p12 (+ p8 (ash (- length p8) -1)))
                                       (p10 (+ p8 (ash (- p12 p8) -1)))
                                       (p9 (+ p8 (ash (- p10 p8) -1)))
                                       (p11 (+ p10 (ash (- p12 p10) -1)))
                                       (p14 (+ p12 (ash (- length p12) -1)))
                                       (p13 (+ p12 (ash (- p14 p12) -1)))
                                       (p15 (+ p14 (ash (- length p14) -1)))
                                       (r1 (nthcdr p1 rest))
                                       (r2 (nthcdr (- p2 p1) r1))
                                       (r3 (nthcdr (- p3 p2) r2))
                                       (r4 (nthcdr (- p4 p3) r3))
                                       (r5 (nthcdr (- p5 p4) r4))
                                       (r6 (nthcdr (- p6 p5) r5))
                                       (r7 (nthcdr (- p7 p6) r6))
                                       (r8 (nthcdr (- p8 p7) r7))
                                       (r9 (nthcdr (- p9 p8) r8))
                                       (r10 (nthcdr (- p10 p9) r9))
                                       (r11 (nthcdr (- p11 p10) r10))
                                       (r12 (nthcdr (- p12 p11) r11))
                                       (r13 (nthcdr (- p13 p12) r12))
                                       (r14 (nthcdr (- p14 p13) r13))
                                       (r15 (nthcdr (- p15 p14) r14)))
                                  (declare (type fixnum p1 p2 p3 p4 p5 p6)
                                           (type fixnum p7 p8 p9 p10 p11)
                                           (type fixnum p12 p13 p14 p15))
                                  (traverse r15 (+ index p15) (- length p15))
                                  (traverse r14 (+ index p14) (- p15 p14))
                                  (traverse r13 (+ index p13) (- p14 p13))
                                  (traverse r12 (+ index p12) (- p13 p12))
                                  (traverse r11 (+ index p11) (- p12 p11))
                                  (traverse r10 (+ index p10) (- p11 p10))
                                  (traverse r9 (+ index p9) (- p10 p9))
                                  (traverse r8 (+ index p8) (- p9 p8))
                                  (traverse r7 (+ index p7) (- p8 p7))
                                  (traverse r6 (+ index p6) (- p7 p6))
                                  (traverse r5 (+ index p5) (- p6 p5))
                                  (traverse r4 (+ index p4) (- p5 p4))
                                  (traverse r3 (+ index p3) (- p4 p3))
                                  (traverse r2 (+ index p2) (- p3 p2))
                                  (traverse r1 (+ index p1) (- p2 p1))
                                  (traverse rest (+ index p1) p1)))))
                   (traverse ,list ,start ,length))))))
      `(block nil
         ,(cond ((eql from-end nil) forward)
                ((eql from-end t) backward)
                (t `(if ,from-end ,backward ,forward)))))))
