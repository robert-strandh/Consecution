(defsystem :consecution-test
  :serial t
  :depends-on
  ("consecution" "rt")
  :components
  ((:file "packages")
   (:module "auxiliary"
    :components
    ((:file "ansi-aux-macros")
     (:file "universe")
     (:file "ansi-aux")
     (:file "random-aux")
     (:file "remove-aux")
     (:file "remove-duplicates-aux")
     (:file "search-aux")
     (:file "sort-aux")
     (:file "subseq-aux")))
   (:file "concatenate")
   (:file "copy-seq")
   (:file "count-if")
   (:file "count-if-not")
   (:file "count")
   (:file "elt")
   (:file "fill")
   (:file "fill-strings")
   (:file "find-if")
   (:file "find-if-not")
   (:file "find")
   (:file "length")
   (:file "make-sequence")
   (:file "map-into")
   (:file "map")
   (:file "merge")
   (:file "mismatch")
   (:file "nreverse")
   (:file "nsubstitute-if")
   (:file "nsubstitute-if-not")
   (:file "nsubstitute")
   (:file "position-if")
   (:file "position-if-not")
   (:file "position")
   (:file "reduce")
   (:file "remove-duplicates")
   (:file "remove")
   (:file "replace")
   (:file "reverse")
   (:file "search-bitvector")
   (:file "search-list")
   (:file "search-string")
   (:file "search-vector")
   (:file "sort")
   (:file "stable-sort")
   (:file "subseq")
   (:file "substitute-if")
   (:file "substitute-if-not")
   (:file "substitute")))
