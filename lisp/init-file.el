;; -*- coding: utf-8; lexical-binding: t; -*-

(prefer-coding-system 'utf-8)

;;; indentation
;; indent style
(setq c-default-style "linux"
      c-basic-offset 4)
(setq-default tab-width 4
              indent-tabs-mode nil)

(add-to-list 'auto-mode-alist '("package\\.env\\'"             . conf-mode))
(add-to-list 'auto-mode-alist '("package\\.use\\'"             . conf-mode))
(add-to-list 'auto-mode-alist '("package\\.mask\\'"            . conf-mode))
(add-to-list 'auto-mode-alist '("package\\.license\\'"         . conf-mode))
(add-to-list 'auto-mode-alist '("package\\.keywords\\'"        . conf-mode))
(add-to-list 'auto-mode-alist '("package\\.accept_keywords\\'" . conf-mode))

;;; recentf mode - record recently edit file
(run-with-idle-timer 2 nil #'recentf-mode)

(with-eval-after-load 'recentf
  (setq recentf-max-saved-items 1000)
  (add-to-list 'recentf-exclude "bookmarks")
  (add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")
  (add-to-list 'recentf-exclude "node_modules")

  (with-eval-after-load 'package
    (add-to-list 'recentf-exclude (expand-file-name package-user-dir))))

;;; minibuffer history
(setq history-length 1000
      enable-recursive-minibuffers t)

(run-with-idle-timer 2 nil #'savehist-mode)
(with-eval-after-load 'savehist
  (setq savehist-autosave-interval 60
        savehist-additional-variables '(mark-ring
                                        global-mark-ring
                                        search-ring
                                        regexp-search-ring
                                        extended-command-history)))

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
(defun creature/show-trailing-whitespace ()
  (set (make-local-variable 'show-trailing-whitespace) t))

(add-hook 'find-file-hook #'creature/show-trailing-whitespace)

;; delete file directly
(setq delete-by-moving-to-trash t)

;; don't backup file
(setq make-backup-files nil)

;; auto save file
(setq auto-save-default t)
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; don't create lockfiles named ".#file-name" in Windows OS
(if creature/sys-win32p
    (setq create-lockfiles nil)
  (setq create-lockfiles t))

(editorconfig-mode)

(defun creature/lua-company-setup ()
  (set (make-local-variable 'company-backends)
       (push 'company-lua company-backends)))
(add-hook 'lua-mode-hook #'creature/lua-company-setup)


(with-eval-after-load 'so-long
  (setq so-long-action 'so-long-minor-mode)

  (defun creature/long-or-large-file-action ()
    (let* ((temp-file-name (buffer-file-name))
           (current-file-name (if temp-file-name temp-file-name ""))
           (current-major-mode (assoc-default current-file-name auto-mode-alist 'string-match))
           (parent-major-mode (get current-major-mode 'derived-mode-parent))
           (mode-enable-so-long (apply `(provided-mode-derived-p ,current-major-mode ,@so-long-target-modes))))

      (when (and current-file-name
                 mode-enable-so-long)

        (let ((size (buffer-size)))
          (if (so-long-detected-long-line-p)

              (cond
               ((> size 51200)
                (fundamental-mode)
                (so-long-minor-mode))
               ((> size 20480)
                (text-mode)
                (so-long-minor-mode)))

            (when (> size 2097152)      ;2MiB
              (text-mode)
              (read-only-mode)))))))

  (add-hook 'find-file-hook #'creature/long-or-large-file-action))

(when (fboundp 'global-so-long-mode)
  (run-with-idle-timer 2 nil #'global-so-long-mode))

(provide 'init-file)
