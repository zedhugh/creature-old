(global-company-mode)
(setq company-idle-delay 0)
(setq company-show-numbers t)
(setq company-require-match nil)
(setq company-minimum-prefix-length 2)
(setq company-clang-insert-arguments t)

(add-hook 'text-mode-hook 'enable-ispell)

(setq company-dabbrev-char-regexp "[\\.0-9a-z-'/]")
(setq company-dabbrev-code-other-buffers 'all)
(setq company-dabbrev-downcase nil)

(yas-global-mode)
(add-hook 'yas-minor-mode-hook 'add-yas)

(company-posframe-mode)
(setq company-posframe-show-indicator nil)
(setq company-posframe-show-metadata nil)
(require 'desktop)
(push '(company-posframe-mode . nil)
      desktop-minor-mode-table)
(provide 'init-company)
