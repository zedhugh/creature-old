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
(require 'init-env)
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

;; hightlight line
;; (if sys/graphicp
;;     (global-hl-line-mode 1)
;;   (global-hl-line-mode -1))

;; disable menu bar, tool bar and scroll bar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; maximized frame except in tiled window manager.
;; there is "awesome".
(unless (string-equal "awesome" (getenv "DESKTOP_SESSION"))
  (setq initial-frame-alist '((fullscreen . maximized))))

;; click(C-c RET) to browse URL
(goto-address-mode)
(goto-address-prog-mode)

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

;; line and colum
(column-number-mode)
(if (fboundp 'display-line-numbers-mode)
    (progn
      (global-display-line-numbers-mode)
      (setq display-line-numbers-width-start t))
  (global-linum-mode))

(require 'time)
(if sys/graphicp
    nil
  (setq display-time-24hr-format t)
  (setq display-time-day-and-date t)
  (display-time-mode))

;; disable startup screen
(setq inhibit-splash-screen t)

(fset 'yes-or-no-p 'y-or-n-p)
(setq visible-bell nil)
(size-indication-mode)
(blink-cursor-mode -1)
;; Keep cursor at end of lines when prev
;; position of cursor is at the end.
;; Require line-move-visual is nil.
(setq track-eol t)
(setq line-move-visual t)

;; add fontset work after emacs initialized
(set-face-attribute 'italic nil :slant 'italic :underline 'unspecified)
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)

(setq x-gtk-use-system-tooltips nil)

;; fontset only for graphic
(when window-system
  ;; single-byte code
  (let ((family (car creature/default-font))
        (size (cdr creature/default-font)))
    (set-face-attribute 'default nil
                        :font (font-spec :family family :size size)))
  ;; multi-byte code
  (let ((family (car creature/chinese-font))
        (size (cdr creature/chinese-font)))
    (dolist (charset '(kana han cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font) charset
                        (font-spec :family family :size size)))))

(put 'erase-buffer 'disabled nil)

(provide 'init-basic)
;;; init-basic.el ends here
