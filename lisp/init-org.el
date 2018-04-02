;;; init-org.el --- config about org mode

;;; Commentary:

;; all configuration for org mode.

;;; Code:

(use-package org-pomodoro)

(use-package org
  :config
  (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-preview-latex-image-directory
        (expand-file-name "ltximg/" creature-cache))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((C          . t)
     (js         . t)
     (latex      . t)
     (shell      . t)
     (python     . t)
     (emacs-lisp . t)))

  ;; don't prompt before eval code
  (setq org-confirm-babel-evaluate nil)

  ;; add better src lang reflex to mode
  (dolist (src2mode creature/org-src-lang-modes)
    (add-to-list 'org-src-lang-modes src2mode)))

(provide 'init-org)
;;; init-org.el ends here
