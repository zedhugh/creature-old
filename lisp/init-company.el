(global-company-mode)
(setq company-idle-delay 0)
(setq company-show-numbers t)
(setq company-require-match nil)
(setq company-minimum-prefix-length 1)
(setq company-clang-insert-arguments nil)
(define-key company-active-map (kbd "C-n")
  #'company-complete-common-or-cycle)
(define-key company-active-map (kbd "C-p")
  (defun creature/company-select-prev ()
    (interactive)
    (company-complete-common-or-cycle -1)))

(add-hook 'text-mode-hook 'enable-ispell)

(setq company-dabbrev-char-regexp "[\\.0-9a-z-'/]")
(setq company-dabbrev-code-other-buffers 'all)
(setq company-dabbrev-downcase nil)

(add-hook 'company-mode-hook 'yas-minor-mode)
(add-hook 'yas-minor-mode-hook 'add-yas)

(provide 'init-company)
