;; -*- coding: utf-8; lexical-binding: t; -*-

(defconst creature/start-time
  (current-time)
  "Start time of current emacs initialize.")

(defvar creature/init-time nil)

;; (profiler-start 'cpu+mem)
(add-hook 'emacs-startup-hook
          #'(lambda ()
              (defconst creature/finish-time
                (current-time)
                "Finish time of current emacs initialize.")
              ;; (profiler-stop)
              (setq creature/init-time
                    (float-time
                     (time-subtract creature/finish-time creature/start-time)))))

(require 'server)
(if (server-running-p)
    t
  (server-start))

(unless (featurep 'package)
  (package-initialize))

(defconst creature/sys-win32p
  (eq system-type 'windows-nt)
  "If system is Windows return t, therwise return nil.")

(defconst creature/config-dir
  (file-name-directory
   (or load-file-name buffer-file-name))
  "Root directory of Creature.")

(defconst creature/cache-dir
  (expand-file-name ".cache" creature/config-dir)
  "Cache directory of Creature.")

(defconst creature/best-gc-cons-threshold
  (if creature/sys-win32p
      (* 512 1024 1024)
    4000000)
  "Best default gc threshold value.
Make gc threshold to a big value to reduce initialize time,
and when Emacs session startup, make gc threshold to be a best value.
Should't be to big.")

(defconst creature/prefix-key "M-m"
  "Prefix key for `creature-map'.")

(setq gc-cons-threshold most-positive-fixnum)

(add-to-list 'load-path (expand-file-name "lisp" creature/config-dir))

(when (< emacs-major-version 27)
  (load-file (expand-file-name "early-init.el" creature/config-dir)))

(require 'init-utils)
(require 'init-modeline)
(require 'init-file)
(require 'init-company)
(require 'init-flycheck)
(require 'init-swiper)
(require 'init-paredit)
(require 'init-webdev)
(require 'init-lsp)
(require 'init-theme)
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

;; (org-babel-load-file (expand-file-name "creature.org" user-emacs-directory))

;; load custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file 'noerror))

(setq gc-cons-threshold creature/best-gc-cons-threshold)
