;; -*- coding: utf-8; lexical-binding: t; -*-

(setq ibuffer-saved-filter-groups
      '(("Default"
         ("ERC" (mode . erc-mode))
         ("Org" (mode . org-mode))
         ("Elisp" (mode . emacs-lisp-mode))
         ("Magit" (name . "^magit[:-].*$"))
         ("TypeScript" (mode . typescript-mode))
         ("CSS" (or
                 (mode . css-mode)
                 (mode . scss-mode)
                 (mode . less-css-mode)))
         ("JavaScript" (or
                        (mode . js-mode)
                        (mode . js-jsx-mode)))
         ("TSX" (and (mode . web-mode)
                     (basename . "^.*\\.tsx$")))

         ("Lsp" (or
                 (name . "^\\*lsp-log\\*$")
                 (name . "^\\*clangd\\*$")
                 (name . "^\\*clangd::stderr\\*$")
                 (name . "^\\*.*-ls\\*$")
                 (name . "^\\*.*-ls::stderr\\*$"))))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode)
            (ibuffer-switch-to-saved-filter-groups "Default")
            ))

;; don't show filter groups if there are no buffers in that group
(setq ibuffer-show-empty-filter-groups nil)

;; don't ask for confirmation to delete marked buffers
(setq ibuffer-expert t)

;; kill custom buffer when quit
(setq custom-buffer-done-kill t)

;;; kill buffer when quit-window.
(define-key global-map [remap list-buffers] 'ibuffer)

(provide 'init-ibuffer)
