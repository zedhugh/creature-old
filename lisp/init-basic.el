;;; init-basic.el --- basic config

;;; Commentary:
;; basic config for build-in package.

;;; Code:

;; use utf-8 for default
(prefer-coding-system 'utf-8)

;; files set
(setq delete-by-moving-to-trash t)
(setq make-backup-files nil)
(setq auto-save-default t)
;; don't create lockfiles named ".#file-name"
(if sys/win32p
    (setq create-lockfiles nil)
  (setq create-lockfiles t))

;; indent
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
(recentf-mode)
(setq recentf-max-saved-items 1000)
(add-to-list 'recentf-exclude (expand-file-name package-user-dir))
(add-to-list 'recentf-exclude "bookmarks")
(add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")

(savehist-mode)
(setq enable-recursive-minibuffers t)
(setq history-length 1000)
(setq savehist-additional-variables
      '(mark-ring
        global-mark-ring
        search-ring
        regexp-search-ring
        extended-command-history))
(setq savehist-autosave-interval 60)

;; delete with key "C-w"
(delete-selection-mode)

;; automatically reload files which modified by external program
(global-auto-revert-mode)

(require 'paren)
(show-paren-mode)
(setq show-paren-when-point-in-periphery t)
(setq show-paren-when-point-inside-paren t)
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (advice-remove 'show-paren-function 'ad-Advice-show-paren-function)
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))

(auto-save-visited-mode)

(fset 'yes-or-no-p 'y-or-n-p)

(put 'erase-buffer 'disabled nil)

(provide 'init-basic)
;;; init-basic.el ends here
