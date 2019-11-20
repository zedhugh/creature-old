(with-eval-after-load 'lsp-ui
  ;; (require 'lsp-ui)
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-flycheck-enable t)
  (setq lsp-ui-flycheck-list-position 'right)
  (setq lsp-ui-doc-position 'top)
  (setq lsp-ui-doc-alignment 'frame)
  (setq lsp-ui-peek-fontify 'always)
  (set-face-attribute 'lsp-ui-sideline-code-action nil :foreground "dark cyan")
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

(with-eval-after-load 'lsp-mode
  (setq lsp-prefer-flymake nil)
  (setq lsp-auto-guess-root t)
  (setq lsp-enable-indentation nil)
  (dolist (lsp-buffer '("::stderr\\*"
                        "\\*lsp-log\\*"
                        "\\*clangd\\*"
                        "-ls\\*"))
    (add-to-list 'ivy-ignore-buffers lsp-buffer))
  (add-to-list 'lsp-language-id-configuration '(js-jsx-mode . "javascriptreact"))
  (add-hook 'lsp-mode-hook #'lsp-ui-mode))

(with-eval-after-load 'company
  ;; sort candidates
  (add-to-list 'company-transformers #'company-sort-prefer-same-case-prefix))

(defvar creature/lsp-setup-modes
  '(c-mode
    c++-mode
    html-mode
    js-mode
    web-mode
    typescript-mode)
  "Major mode setup with `lsp-mode' enabled.")

(defun lsp-setup ()
  "Setup lsp in which `major-mode' in `creature/lsp-setup-modes'."
  (when (member major-mode creature/lsp-setup-modes)
    (lsp-deferred)))
(add-hook 'prog-mode-hook #'lsp-setup)

(defun eslint-checker ()
  "Use eslint as ts/js file syntax and code style checker."
  (when (and (derived-mode-p 'js-mode 'typescript-mode)
             (not (derived-mode-p 'json-mode)))
    (flycheck-select-checker 'javascript-eslint)))
(add-hook 'flycheck-mode-hook #'eslint-checker)

(projectile-mode)

(provide 'init-lsp)
