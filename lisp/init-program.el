(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode)
              (ggtags-mode 1)
              (set (make-local-variable 'company-backends)
                   (add-to-list 'company-backends
                                '(company-c-headers company-irony)))
              (irony-mode))))

(add-hook 'irony-mode-hook #'irony-eldoc)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

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
  (setq flycheck-emacs-lisp-load-path load-path))

(provide 'init-program)
