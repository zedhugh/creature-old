(when sys/win32p
  ;; (w32-register-hot-key [s-t])
  (setq-default w32-apps-modifier 'hyper)
  (setq-default w32-lwindow-modifier 'super))

(require 'server)
(if (server-running-p)
    t
  (server-start))

(delete-selection-mode)

(setq backward-delete-char-untabify-method 'hungry)

;;; ediff
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;; recentf mode - record recently edit file
(recentf-mode)
(setq recentf-max-saved-items 1000)
(add-to-list 'recentf-exclude (expand-file-name package-user-dir))
(add-to-list 'recentf-exclude "bookmarks")
(add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")

;;; minibuffer history
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

;;; save cursor position
(save-place-mode)

;;; don't show prompt when call function
(fset 'yes-or-no-p 'y-or-n-p)
(put 'erase-buffer 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disable nil)
(put 'narrow-to-region 'disabled nil)

;; automatically reload files which modified by external program
(global-auto-revert-mode)

;; show trailing whitespace
(add-hook 'find-file-hook
          (defun show-trailing-whitespace ()
            (set (make-local-variable 'show-trailing-whitespace) t)))

;; delete file directly
(setq delete-by-moving-to-trash t)

;; don't backup file
(setq make-backup-files nil)

;; auto save file
(setq auto-save-default t)
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; don't create lockfiles named ".#file-name" in Windows OS
(if sys/win32p
    (setq create-lockfiles nil)
  (setq create-lockfiles t))

(provide 'init-misc)
