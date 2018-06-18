(with-eval-after-load 'dired
  (setq dired-dwim-target t)
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (put 'dired-find-alternate-file 'disabled nil)
  (require 'dired-x)
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

  (unless sys/win32p
    (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
  )

(provide 'init-dired)
