;; (load-theme 'molokai t)

(dolist (mode '(rainbow-delimiters-mode
                rainbow-identifiers-mode))
  (add-hook 'prog-mode-hook mode))

;; page break lines
(global-page-break-lines-mode)
(setq page-break-lines-char ?=)
(add-to-list 'page-break-lines-modes 'web-mode)

;; address style
(add-hook 'text-mode-hook 'goto-address-mode)
(add-hook 'prog-mode-hook 'goto-address-prog-mode)

;; cursor style
(setq-default cursor-type 'bar)

;; which key
(which-key-mode)
(setq which-key-idle-delay 0.4)

;; window number
(window-numbering-mode)

(set-face-attribute font-lock-comment-face nil :slant 'italic)

(provide 'init-theme)
