;; show file size human readable
;; copy and delete directory recursive
;; don't show prompt when open file from dired buffer
;; customize keybindings
;; Windows OS don't show icons in dired buffer.
(with-eval-after-load 'dired
  (require 'dired-x)
  (setq dired-dwim-target t)
  (setq dired-listing-switches "-alh")
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  ;; don't make too many dired buffer
  (put 'dired-find-alternate-file 'disabled nil))

(unless sys/win32p
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(provide 'init-dired)
