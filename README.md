MCL
===

[Macintosh Common Lisp](http://en.wikipedia.org/wiki/Macintosh_Common_Lisp) (still) continues to be an effective integrated development environment for Lisp.

This collection comprises patches for version 5.2. Create the directory `"CCL:patches;patches 5.2;"`, place the patch files there and add something like

    (defvar *patches-loaded* nil)
    (when (not *patches-loaded*)
      (ccl:load-patches "ccl:patches;" t)
      (setq *patches-loaded* t))

to the start-up process.
