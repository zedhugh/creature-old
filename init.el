;; -*- coding: utf-8; lexical-binding: t; -*-

(let* ((min-version "27.1"))
  (when (version< emacs-version min-version)
    (error "Emacs v%s or higher is required." min-version)))

(defvar creature/init-time nil)

(let ((benchmark nil))
  (when benchmark (profiler-start 'cpu+mem))
  (add-hook 'emacs-startup-hook
            (lambda ()
              (when benchmark (profiler-stop))
              (setq creature/init-time
                    (float-time
                     (time-subtract (current-time) start-time)))
              (makunbound 'start-time))))

(defconst creature/sys-win32p
  (eq system-type 'windows-nt)
  "If system is Windows return t, therwise return nil.")

(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

(defconst creature/config-dir
  (file-name-directory
   (or load-file-name buffer-file-name))
  "Root directory of Creature.")

(defconst creature/cache-dir
  (expand-file-name ".cache" creature/config-dir)
  "Cache directory of Creature.")

(defconst creature/prefix-key "M-m"
  "Prefix key for `creature-map'.")

(define-prefix-command 'creature-map)

(add-to-list 'load-path (expand-file-name "lisp" creature/config-dir))

(require 'init-autoloads)
(require 'init-theme)
(require 'init-modeline)
(require 'init-utils)
(require 'init-file)
(require 'init-company)
;; (require 'init-flycheck)
(require 'init-swiper)
(require 'init-paredit)
(require 'init-webdev)
;; (require 'init-lsp)
(require 'init-eglot)
(require 'init-misc)
(require 'init-org)
(require 'init-dired)
(require 'init-ibuffer)
(require 'init-hydra)
(require 'init-tools)
(require 'init-media)
(require 'init-evil)
(require 'init-keybindings)
(require 'init-which-key)

(with-eval-after-load 'gnus
  (require 'init-mail))

(let* ((file-name-handler-alist nil))

  (run-with-idle-timer 2 nil
                       (lambda ()
                         (unless (server-running-p)
                           (server-start))))

  ;; (org-babel-load-file (expand-file-name "creature.org" user-emacs-directory))

  ;; load custom file
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
  (when (file-exists-p custom-file)
    (load custom-file 'noerror))
  )
