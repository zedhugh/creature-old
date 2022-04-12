;; -*- lexical-binding: t -*-

(let* ((min-version "27.1"))
  (when (version< emacs-version min-version)
    (error "Emacs v%s or higher is required." min-version)))

(let ((benchmark nil))
  (when benchmark
    (profiler-start 'cpu+mem)
    (add-hook 'emacs-startup-hook
              (lambda ()
                (when benchmark (profiler-stop))))))

(defvar creature-gc-cons-threshold
  (if (display-graphic-p) (* 64 1024 1024) (* 16 1024 1024))
  "The default value to use for `gc-cons-threshold'.
If freezing sometimes, decrease it. If stuttering, increase it.")

(defvar creature-gc-cons-upper-limit
  (if (display-graphic-p) (* 512 1024 1024) (* 128 1024 1024))
  "The temporary value for `gc-cons-threshold' to defer it.")

(defvar creature-gc-timer (run-with-idle-timer 10 t #'garbage-collect)
  "Run garbage collection when idle 10s.")

(defvar default-file-name-handler-alist file-name-handler-alist
  "Temporary `file-name-handler-alist' for restore after startup.")

;; Speed up startup
(defun creature-enlarge-gc-cons-threshold ()
  "Enlarge garbage collection threshold."
  (setq gc-cons-percentage  0.6
        gc-cons-threshold   creature-gc-cons-upper-limit))

(defun creature-normalize-gc-cons-threshold ()
  "Normalize garbage collection threshold."
  (setq gc-cons-percentage  0.1
        gc-cons-threshold   creature-gc-cons-threshold))

(creature-enlarge-gc-cons-threshold)
(setq file-name-handler-alist   nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            (creature-normalize-gc-cons-threshold)
            (setq file-name-handler-alist default-file-name-handler-alist)

            (setq read-process-output-max (* 1024 1024))

            ;; GC automatically when unfocused
            (if (boundp 'after-focus-change-function)
                (add-function :after after-focus-change-function
                              (lambda ()
                                (unless (frame-focus-state) (garbage-collect))))
              (add-hook 'focus-out-hook #'garbage-collect))

            ;; Avoid GC while minibuffer active.
            (add-hook 'minibuffer-setup-hook
                      #'creature-enlarge-gc-cons-threshold)
            (add-hook 'minibuffer-exit-hook
                      #'creature-normalize-gc-cons-threshold)))

(defconst creature/config-dir
  (file-name-directory
   (or load-file-name buffer-file-name))
  "Root directory of Creature.")

(defconst creature/cache-dir
  (expand-file-name ".cache" creature/config-dir)
  "Cache directory of Creature.")

(defun upload-load-path (&rest _)
  "Upload `load-path'."
  (dolist (dir '("site-lisp" "lisp"))
    (push (expand-file-name dir creature/config-dir) load-path)))

(defun add-subdirs-to-load-path (&rest _)
  "Add subdirectories to `load-path'."
  (let ((default-directory (expand-file-name "site-lisp" creature/config-dir)))
    (normal-top-level-add-subdirs-to-load-path)))

(advice-add #'package-initialize :after #'upload-load-path)
(advice-add #'package-initialize :after #'add-subdirs-to-load-path)

(upload-load-path)

(defconst creature/prefix-key "M-m"
  "Prefix key for `creature-map'.")

(define-prefix-command 'creature-map)

(add-to-list 'load-path (expand-file-name "lisp" creature/config-dir))

(unless (boundp 'creature-init-time)
  (load (expand-file-name "early-init.el" creature/config-dir)))

(defconst creature/sys-win32p
  (eq system-type 'windows-nt)
  "If system is Windows return t, therwise return nil.")


(require 'init-autoloads)
(require 'init-paredit)
(require 'init-modeline)
(require 'init-basic)
(require 'init-misc)
(require 'init-utils)
(require 'init-dired)
(require 'init-program)
(require 'init-ibuffer)
(require 'init-keybindings)
(require 'init-which-key)

(require 'init-highlight)
(require 'init-theme)
(require 'init-file)
(require 'init-yasnippet)
(require 'init-swiper)
(require 'init-org)
(require 'init-hydra)
(require 'init-tools)
(require 'init-media)
(require 'init-evil)
(require 'init-company)
(require 'init-javascript)
(require 'init-tree-sitter)
(require 'init-web-mode)
(require 'init-css)

(with-eval-after-load 'gnus
  (require 'init-mail))

;; (org-babel-load-file (expand-file-name "creature.org" user-emacs-directory))

;; load custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file 'noerror))
