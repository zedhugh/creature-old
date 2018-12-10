(electric-pair-mode)

(show-paren-mode)
(setq show-paren-when-point-in-periphery t)
(setq show-paren-when-point-inside-paren t)
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (advice-remove 'show-paren-function 'ad-Advice-show-paren-function)
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))

(dolist (hook '(lisp-mode-hook
                emacs-lisp-mode-hook
                lisp-interaction-mode-hook))
  (add-hook hook 'enable-paredit-mode))

;; there are some performance problem when involve both "paredit" and
;; "ggtags", finally "paredit-everywhere" resolveed this problem
(add-hook 'prog-mode-hook 'paredit-everywhere-mode)

(provide 'init-paredit)
