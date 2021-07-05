;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'init-elpa)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  lsp-mode                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(creature/require-package 'lsp-mode)
(creature/require-package 'lsp-ui)
(creature/require-package 'lsp-treemacs)
(creature/require-package 'lsp-tailwindcss)

(with-eval-after-load 'lsp-ui
  (setq lsp-ui-doc-enable nil
        lsp-ui-flycheck-list-position 'bottom
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

(with-eval-after-load 'lsp-css
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection #'lsp-css--server-command)
    :activation-fn (lsp-activate-on "scss")
    :priority -1
    :action-handlers (lsp-ht ("_css.applyCodeAction" #'lsp-css--apply-code-action))
    :server-id 'css-ls
    :download-server-fn (lambda (_client callback error-callback _update?)
                          (lsp-package-ensure 'css-languageserver callback error-callback)))))

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
        )

  (creature/tailwindcss-setup)

  (add-to-list 'lsp-language-id-configuration '(js-jsx-mode . "javascriptreact"))

  (define-key lsp-mode-map (kbd "C-c r") #'lsp-rename)
  (define-key lsp-mode-map (kbd "C-c o") #'lsp-execute-code-action))

(with-eval-after-load 'company
  ;; sort candidates
  (add-to-list 'company-transformers #'company-sort-prefer-same-case-prefix))

(defun creature/lsp-eslint-checker-init ()
  (when (and flycheck-mode
             (flycheck-valid-checker-p 'lsp)
             (flycheck-valid-checker-p 'javascript-eslint))
    (make-local-variable 'flycheck-checkers)
    (flycheck-add-next-checker 'lsp 'javascript-eslint)))

(add-hook 'lsp-diagnostics-mode-hook #'creature/lsp-eslint-checker-init)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                   eglot                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(creature/require-package 'eglot)

(defun eglot-disabled-mode-line ()
  (dolist (mode-line mode-line-misc-info)
    (let ((mode (car mode-line)))
      (when (eq mode 'eglot--managed-mode)
        (setq mode-line-misc-info (delete mode-line mode-line-misc-info))))))

(defun eglot-enable-mode-line ()
  (add-to-list 'mode-line-misc-info
               `(eglot--managed-mode (" [" eglot--mode-line-format "] "))))

(with-eval-after-load 'eglot
  (add-hook 'eglot-managed-mode-hook #'flymake-eslint-setup)
  (add-hook 'eglot-managed-mode-hook #'eglot-disabled-mode-line)

  (setq eglot-confirm-server-initiated-edits nil
        eglot-autoshutdown t)

  (add-to-list 'eglot-server-programs '((c++-mode c-mode) . ("clangd")))
  (add-to-list 'eglot-server-programs
               '((css-mode scss-mode less-css-mode) . ("css-languageserver" "--stdio")))

  (add-to-list 'eglot-server-programs
               '((js-mode typescript-mode web-mode) . ("typescript-language-server" "--stdio")))

  (define-key eglot-mode-map (kbd "M-.") #'xref-find-definitions)
  (define-key eglot-mode-map (kbd "M-?") #'xref-find-references)
  (define-key eglot-mode-map (kbd "C-c r") #'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c o") #'eglot-code-actions))


(provide 'init-lsp)
