(with-eval-after-load 'lsp-ui
  ;; (require 'lsp-ui)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-flycheck-enable t)
  (setq lsp-ui-flycheck-list-position 'right)
  (setq lsp-ui-doc-position 'at-point)
  (setq lsp-ui-doc-alignment 'window)
  (set-face-attribute 'lsp-ui-sideline-code-action nil :foreground "dark cyan")
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

(with-eval-after-load 'lsp-mode
  (setq lsp-prefer-flymake nil)
  (setq lsp-auto-guess-root t)
  (setq lsp-enable-indentation nil)
  (add-to-list 'lsp-language-id-configuration '(js-jsx-mode . "javascriptreact"))
  (add-hook 'lsp-mode-hook #'lsp-ui-mode))

(with-eval-after-load 'company
  ;; sort candidates
  (add-to-list 'company-transformers #'company-sort-prefer-same-case-prefix))

(add-hook 'c-mode-common-hook
          (lambda ()
            (lsp)
            (set (make-local-variable 'company-backends)
                 '(company-lsp))
            (add-yas)))

(projectile-mode)

(provide 'init-lsp)
