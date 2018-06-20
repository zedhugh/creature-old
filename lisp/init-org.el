;;; init-org.el --- config about org mode

;;; Commentary:

;; all configuration for org mode.

;;; Code:

(defconst creature/org-src-lang-modes
  '(("js"   . js2)
    ("html" . web))
  "Better src lang reflex to mode.")

(when sys/win32p
  (with-eval-after-load 'org-pomodoro
    (setq org-pomodoro-audio-player "mplayer")))

;; inline image
(add-hook 'org-mode-hook 'org-display-inline-images)
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "RET") 'newline-and-indent)
  (setq org-image-actual-width nil)
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
    (add-to-list 'org-src-lang-modes src2mode))
  )

(provide 'init-org)
;;; init-org.el ends here
