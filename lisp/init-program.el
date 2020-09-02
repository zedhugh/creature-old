(add-hook 'lua-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 (push 'company-lua company-backends))))

;;; indentation
;; indent style
(setq c-default-style "linux")
(setq c-basic-offset 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;;; flycheck
(add-hook 'prog-mode-hook 'setup-flycheck)

;;; folding
(add-hook 'prog-mode-hook 'hs-minor-mode)

(with-eval-after-load 'flycheck
  (setq flycheck-emacs-lisp-load-path load-path)
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(add-hook 'prog-mode-hook
          (lambda ()
            (font-lock-add-keywords
             nil '(("\\<\\(FIXME\\|DEBUG\\|TODO\\):"
                    1 font-lock-warning-face prepend)))))

(provide 'init-program)
