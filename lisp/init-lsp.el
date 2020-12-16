;; -*- coding: utf-8; lexical-binding: t; -*-

(creature/install-packages
  '(lsp-mode
    lsp-ui
    lsp-treemacs))

(with-eval-after-load 'lsp-ui
  ;; (require 'lsp-ui)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-flycheck-list-position 'right)
  (setq lsp-ui-doc-position 'top)
  (setq lsp-ui-doc-alignment 'frame)
  (setq lsp-ui-peek-fontify 'always)
  (set-face-attribute 'lsp-ui-sideline-code-action nil :foreground "dark cyan")
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

(with-eval-after-load 'lsp-mode
  (setq lsp-restart 'auto-restart)
  (setq lsp-modeline-code-actions-enable nil)

  (setq lsp-auto-guess-root t)
  (setq lsp-enable-indentation nil)
  (dolist (lsp-buffer '("::stderr\\*"
                        "\\*lsp-log\\*"
                        "\\*clangd\\*"
                        "-ls\\*"))
    (add-to-list 'ivy-ignore-buffers lsp-buffer))
  (add-to-list 'lsp-language-id-configuration '(js-jsx-mode . "javascriptreact"))
  (add-hook 'lsp-on-idle-hook #'creature/company-add-yas))

(with-eval-after-load 'company
  ;; sort candidates
  (add-to-list 'company-transformers #'company-sort-prefer-same-case-prefix))

(defvar creature/lsp-setup-modes
  '(c-mode
    c++-mode
    html-mode
    css-mode
    scss-mode
    js-mode
    js-jsx-mode
    web-mode
    typescript-mode)
  "Major mode setup with `lsp-mode' enabled.")

(defun lsp-setup ()
  "Setup lsp in which `major-mode' in `creature/lsp-setup-modes'."
  (when (and
         (buffer-file-name)
         (member major-mode creature/lsp-setup-modes)
         (if (featurep 'tramp)
             (not (tramp-tramp-file-p (buffer-file-name)))
           t))
    (lsp-deferred)
    (lsp-diagnostics-mode))
  (when (derived-mode-p 'css-mode 'scss-mode 'less-css-mode)
    (setq-local lsp-overlay-document-color-char "")))

(defun creature/lsp-eslint-checker-init ()
  (make-local-variable 'flycheck-checkers)
  (when (and (flycheck-valid-checker-p 'lsp)
             (flycheck-valid-checker-p 'javascript-eslint))
    (flycheck-add-next-checker 'lsp 'javascript-eslint)))

(add-hook 'lsp-diagnostics-mode-hook #'creature/lsp-eslint-checker-init)
(add-hook 'prog-mode-hook #'lsp-setup)

(provide 'init-lsp)
