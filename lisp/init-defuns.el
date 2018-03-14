;;; init-defuns.el --- functions

;;; Commentary:
;; all functions defined by myself.

;;; Code:

(require 'which-key)
(require 'evil-leader)
(defun creature/which-key-declare-prefixes (key doc &rest bind)
  "Define KEY's DOC with the same way of `evil-leader/set-key'.
BIND is rest sets of KEY and DOC."
  (while key
    (let ((key1 (concat evil-leader/leader key))
          (key2 (concat evil-leader/non-normal-prefix
                        evil-leader/leader " " key)))
      (which-key-add-key-based-replacements key1 doc)
      (which-key-add-key-based-replacements key2 doc))
    (setq key (pop bind)
          doc (pop bind))))

(defun kill-current-buffer ()
  "Define this function for version before 26."
  (interactive)
  (kill-buffer (buffer-name)))

(provide 'init-defuns)
;;; init-defuns.el ends here
