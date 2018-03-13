;;; init-basic.el --- basic config

;;; Commentary:
;; basic config for build-in package.

;;; Code:

;; files set
(setq delete-by-moving-to-trash t)
(setq make-backup-files nil)
(setq auto-save-default t)

;; indent
(require 'init-env)
(let ((offset (if sys/win32p 4 2)))
  (setq-default c-basic-offset offset)
  (setq-default tab-width offset))
(setq-default indent-tabs-mode nil)

;; dired mode
(setq-default dired-dwim-target t)
(setq-default dired-recursive-copies 'always)
(setq-default dired-recursive-deletes 'always)
(put 'dired-find-alternate-file 'disabled nil)
(require 'dired-x)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

;; key modifiers in windows
(when sys/win32p
  ;; (w32-register-hot-key [s-t])
  (setq-default w32-apps-modifier 'hyper)
  (setq-default w32-lwindow-modifier 'super))

;; enable server-mode
(require 'server)
(if (server-running-p)
    t
  (server-start))

;; remember last edit position for files
(save-place-mode)

;; remember recent opened files.
(require 'recentf)
(recentf-mode)
(setq-default recentf-max-saved-items 1000)
(add-to-list 'recentf-exclude (expand-file-name package-user-dir))
(add-to-list 'recentf-exclude "bookmarks")
(add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")

(savehist-mode)
(setq enable-recursive-minibuffers t)
(setq history-length 1000)
(setq-default savehist-additional-variables
              '(mark-ring
                global-mark-ring
                search-ring
                regexp-search-ring
                extended-command-history))
(setq-default savehist-autosave-interval 60)

(put 'erase-buffer 'disabled nil)

(provide 'init-basic)
;;; init-basic.el ends here
