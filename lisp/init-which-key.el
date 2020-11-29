;; -*- coding: utf-8; lexical-binding: t; -*-

(creature/install-packages 'which-key)

;; which key
(which-key-mode)
(setq which-key-idle-delay 0.4)

(defun creature/which-key-declare-prefixes (prefix key doc &rest bind)
  "Define the DOC of KEY with PREFIX like `evil-leader/set-key'.
  BIND is rest sets of KEY and DOC."
  (while key
    (let ((key1 (concat prefix " " key)))
      (which-key-add-key-based-replacements key1 doc))
    (setq key (pop bind)
          doc (pop bind))))
(put 'creature/which-key-declare-prefixes 'lisp-indent-function 'defun)

(creature/which-key-declare-prefixes creature/prefix-key
  "b"  "buffer"
  "c"  "comments"
  "e"  "errors"
  "el" "lines"
  "ex" "error message"
  "f"  "files"
  "g"  "magit"
  "gf" "magit files"
  "h"  "help"
  "q"  "quit option"
  "s"  "evil surround"
  "y"  "youdao"
  "j"  "jump"
  "yp" "pronunciation"
  "ys" "translate")

(provide 'init-which-key)
