(with-eval-after-load 'dired
  (require 'dired-x)
  (setq dired-dwim-target t)
  (setq dired-listing-switches "-alh")
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (put 'dired-find-alternate-file 'disabled nil)
  (define-key dired-mode-map (kbd "K") 'dired-narrow)
  (define-key dired-mode-map (kbd "q") 'kill-current-buffer)

  (unless sys/win32p
    (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
  )

(provide 'init-dired)
