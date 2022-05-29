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
  (setq lsp-headerline-breadcrumb-enable nil)

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

(with-eval-after-load 'lsp-diagnostics
  (add-hook 'lsp-diagnostics-mode-hook #'creature/lsp-eslint-checker-init))
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
  (setq eglot-events-buffer-size 0)
  (add-hook 'eglot-managed-mode-hook #'flymake-eslint-setup)
  (add-hook 'eglot-managed-mode-hook #'eglot-disabled-mode-line)
  (add-hook 'eglot-managed-mode-hook #'creature/toggle-eglot-completion)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                 lsp-bridge                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'lsp-bridge)
(require 'lsp-bridge-orderless)
(corfu-history-mode t)
(global-lsp-bridge-mode)
(when (> (frame-pixel-width) 3000) (custom-set-faces '(corfu-default ((t (:height 1.3))))))
(setq lsp-bridge-diagnostic-tooltip-border-width 1)

(defun creature/eglot-completion-advice (&rest p)
  nil)
(defun creature/toggle-eglot-completion ()
  (when (fboundp #'eglot-completion-at-point)
    (if (bound-and-true-p lsp-bridge-mode)
        (advice-add #'eglot-completion-at-point :around #'creature/eglot-completion-advice)
      (advice-remove #'eglot-completion-at-point #'creature/eglot-completion-advice))))

(add-hook 'lsp-bridge-mode-hook #'creature/toggle-eglot-completion)

(creature/set-keys lsp-bridge-mode-map
                   "M-." #'lsp-bridge-find-define
                   "M-?" #'lsp-bridge-find-references)


(provide 'init-lsp)
