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
  (put 'dired-find-alternate-file 'disabled nil)
  (define-key dired-mode-map (kbd "K") 'dired-narrow)
  (define-key dired-mode-map (kbd "q") 'kill-current-buffer))

(unless sys/win32p
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  (with-eval-after-load 'dired
    (define-key dired-mode-map
      (kbd "C-x C-q") 'creature/dired-toggle-read-only))
  (with-eval-after-load 'wdired
    (define-key wdired-mode-map
      (kbd "C-c ESC") 'creature/wdired-exit)
    (define-key wdired-mode-map
      (kbd "C-c C-k") 'creature/wdired-exit)
    (define-key wdired-mode-map
      (kbd "C-c C-c") 'creature/wdired-finish-edit)))

(provide 'init-dired)
