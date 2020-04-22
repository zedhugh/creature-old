(load-theme 'molokai t)

(dolist (mode '(rainbow-delimiters-mode
                rainbow-identifiers-mode))
  (add-hook 'prog-mode-hook mode))

(global-display-line-numbers-mode)

;; page break lines
(global-page-break-lines-mode)
(setq page-break-lines-char ?=)
(add-to-list 'page-break-lines-modes 'web-mode)

;; address style
(add-hook 'erc-mode-hook 'goto-address-mode)
(add-hook 'text-mode-hook 'goto-address-mode)
(add-hook 'prog-mode-hook 'goto-address-prog-mode)

;; cursor style - box for readonly buffer, bar for others
(dolist (hook '(prog-mode-hook
                text-mode-hook
                conf-unix-mode-hook
                conf-windows-mode-hook))
  (add-hook hook #'creature/cursor-style))

;; which key
(which-key-mode)
(setq which-key-idle-delay 0.4)

;; window number
(window-numbering-mode)

(set-face-attribute font-lock-comment-face nil :slant 'italic)
(global-hl-line-mode)

(provide 'init-theme)
