;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'init-elpa)

(creature/require-package 'cmake-mode)
(creature/require-package 'vimrc-mode)
(creature/require-package 'yaml-mode)

;;; indentation
;; indent style
(setq c-default-style "linux"
      c-basic-offset 4)

(add-to-list 'auto-mode-alist '("package\\.env\\'"             . conf-mode))
(add-to-list 'auto-mode-alist '("package\\.use\\'"             . conf-mode))
(add-to-list 'auto-mode-alist '("package\\.mask\\'"            . conf-mode))
(add-to-list 'auto-mode-alist '("package\\.license\\'"         . conf-mode))
(add-to-list 'auto-mode-alist '("package\\.keywords\\'"        . conf-mode))
(add-to-list 'auto-mode-alist '("package\\.accept_keywords\\'" . conf-mode))

;;; recentf mode - record recently edit file
(with-eval-after-load 'recentf
  (setq recentf-max-saved-items 1000)
  ;; (add-to-list 'recentf-exclude "bookmarks")
  (add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")
  (add-to-list 'recentf-exclude "node_modules")

  (with-eval-after-load 'package
    (add-to-list 'recentf-exclude (expand-file-name package-user-dir))))


(creature/require-package 'lua-mode)

(defun creature/lua-company-setup ()
  (set (make-local-variable 'company-backends)
       (push 'company-lua company-backends)))
(add-hook 'lua-mode-hook #'creature/lua-company-setup)

(creature/require-package 'nginx-mode)

(defun creature/nginx-company-setup ()
  (set (make-local-variable 'company-backends)
       (add-to-list 'company-backends 'company-nginx)))

(with-eval-after-load 'nginx-mode
  (add-hook 'nginx-mode-hook #'creature/nginx-company-setup))

(defun creature/long-or-large-file-action ()
  (let* ((temp-file-name (buffer-file-name))
         (current-file-name (if temp-file-name temp-file-name ""))
         (current-major-mode (assoc-default current-file-name auto-mode-alist #'string-match))

         (major-mode-is-symbol (symbolp current-major-mode))

         (mode-enable-so-long (and major-mode-is-symbol
                                   (apply `(provided-mode-derived-p ,current-major-mode ,@so-long-target-modes)))))
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

(with-eval-after-load 'so-long
  (setq so-long-action 'so-long-minor-mode)

  (when buffer-file-name
    (creature/long-or-large-file-action))

  (add-hook 'find-file-hook #'creature/long-or-large-file-action))

(defvar modes-about-file-not-loaded t)
(defvar run-timer nil)

(creature/require-package 'editorconfig)

(defun creature/editorconfig-ignore-charset (props)
  "Ignore `charset' config of `editorconfig-mode' in new file buffer.
Charset config in editorconfig make buffer be modified
when create a new buffer, and it's not what I want."
  (let ((filename (buffer-file-name)))
    (when (and filename
               (not (file-exists-p filename)))
      (puthash 'charset nil props))))

(with-eval-after-load 'editorconfig
  (add-hook 'editorconfig-hack-properties-functions
            #'creature/editorconfig-ignore-charset))

(defun creature/load-modes-idle-or-find-file ()
  "Launch modes with idle timer or when open the first file."
  (when (bound-and-true-p modes-about-file-not-loaded)

    (editorconfig-mode)
    (global-so-long-mode)
    (recentf-mode)

    ;; automatically reload files which modified by external program
    (global-auto-revert-mode)

    (remove-hook 'find-file-hook #'creature/load-modes-idle-or-find-file)

    (makunbound 'modes-about-file-not-loaded)
    (when (and (bound-and-true-p run-timer)
               (timerp run-timer))
      (cancel-timer run-timer)
      (makunbound 'run-timer))))

;; (creature/load-modes-idle-or-find-file)
(add-hook 'find-file-hook #'creature/load-modes-idle-or-find-file)
(setq run-timer (run-with-idle-timer 1 nil #'creature/load-modes-idle-or-find-file))

;; pdf view
(creature/require-package 'saveplace-pdf-view)
(creature/require-package 'pdf-tools)

(with-eval-after-load 'pdf-loader
  (require 'saveplace-pdf-view))

(with-eval-after-load 'pdf-view
  (add-hook 'pdf-view-mode-hook #'pdf-view-themed-minor-mode))

(pdf-loader-install t t t)

(provide 'init-file)
