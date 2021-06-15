;; -*- coding: utf-8; lexical-binding: t; -*-

(with-eval-after-load 'lsp-ui
  (setq lsp-ui-doc-enable nil
        lsp-ui-flycheck-list-position 'right
        lsp-ui-doc-position 'top
        lsp-ui-doc-alignment 'frame
        ;; lsp-ui-peek-fontify 'always
        )

  (set-face-attribute 'lsp-ui-sideline-code-action nil :foreground "dark cyan")
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

(defun creature/tailwindcss-setup ()
  "Setup tailwindcss."
  (setq lsp-tailwindcss-add-on-mode t)
  ;; avoid this issue: https://github.com/tailwindlabs/tailwindcss-intellisense/issues/318
  ;; issue fixed
  ;; (setq lsp-tailwindcss-server-version "0.5.10")
  (require 'lsp-tailwindcss))

(with-eval-after-load 'lsp-mode
  (setq lsp-restart 'auto-restart
        lsp-log-io nil
        lsp-lens-enable t
        lsp-keep-workspace-alive nil
        lsp-eldoc-enable-hover t

        lsp-auto-configure t
        lsp-auto-guess-root t
        lsp-completion-enable t
        lsp-completion-provider :capf
        lsp-enable-indentation nil
        lsp-enable-folding nil
        lsp-enable-snippet nil
        lsp-enable-file-watchers nil
        lsp-enable-text-document-color nil
        lsp-enable-on-type-formatting nil
        lsp-enable-symbol-highlighting t

        lsp-headerline-breadcrumb-enable nil
        lsp-modeline-code-actions-enable nil
        lsp-modeline-diagnostics-enable t
        lsp-modeline-diagnostics-scope :file

        lsp-diagnostic-clean-after-change t
        lsp-diagnostics-provider :auto
        )

  (creature/tailwindcss-setup)

  (add-to-list 'lsp-language-id-configuration '(js-jsx-mode . "javascriptreact"))
  (add-hook 'lsp-on-idle-hook #'creature/setup-yasnippet))

(with-eval-after-load 'company
  ;; sort candidates
  (add-to-list 'company-transformers #'company-sort-prefer-same-case-prefix))

(defun lsp-setup ()
  (when (and
         (buffer-file-name)
         (not (derived-mode-p 'json-mode))
         (if (fboundp #'so-long-detected-long-line-p)
             (not (so-long-detected-long-line-p))
           t)
         (if (featurep 'tramp)
             (not (tramp-tramp-file-p (buffer-file-name)))
           t))
    (lsp-deferred))
  (when (derived-mode-p 'css-mode 'scss-mode 'less-css-mode)
    (setq-local lsp-overlay-document-color-char "")))

(defun creature/lsp-eslint-checker-init ()
  (make-local-variable 'flycheck-checkers)
  (when (and flycheck-mode
             (flycheck-valid-checker-p 'lsp)
             (flycheck-valid-checker-p 'javascript-eslint))
    (flycheck-add-next-checker 'lsp 'javascript-eslint)))

(add-hook 'lsp-diagnostics-mode-hook #'creature/lsp-eslint-checker-init)

(dolist (hook '(c-mode-hook
                c++-mode-hook
                html-mode-hook
                css-mode-hook
                scss-mode-hook
                js-mode-hook
                js-jsx-mode-hook
                web-mode-hook
                typescript-mode-hook))
  (add-hook hook #'lsp-setup))

(provide 'init-lsp)
