;; -*- coding: utf-8; lexical-binding: t; -*-

(let* ((min-version "27.1"))
  (when (version< emacs-version min-version)
    (error "Emacs v%s or higher is required." min-version)))

(defvar creature/init-time nil)

(let ((benchmark nil)
      (start-time (current-time)))
  (when benchmark (profiler-start 'cpu+mem))
  (add-hook 'emacs-startup-hook
            #'(lambda ()
                (when benchmark (profiler-stop))
                (setq creature/init-time
                      (float-time
                       (time-subtract (current-time) start-time))))))

(defconst creature/sys-win32p
  (eq system-type 'windows-nt)
  "If system is Windows return t, therwise return nil.")

(defconst creature/best-gc-cons-threshold
  (if creature/sys-win32p
      536870912                         ; 512MiB
    67108864)                           ; 64Mib
  "Best default gc threshold value.
Make gc threshold to a big value to reduce initialize time,
and when Emacs session startup, make gc threshold to be a best value.
Should't be to big.")

(defun creature/turn-off-gc ()
  "Improve the threshold of garbage collect."
  (setq gc-cons-percentage 0.6
        gc-cons-threshold most-positive-fixnum))

(defun creature/turn-on-gc ()
  "Modify the threshold of garbage collect to a normal value."
  (setq gc-cons-percentage 0.1
        gc-cons-threshold creature/best-gc-cons-threshold)
  (garbage-collect))

(creature/turn-off-gc)

(run-with-idle-timer
 3 nil
 #'(lambda ()
     (add-hook 'minibuffer-exit-hook #'creature/turn-on-gc)
     (add-hook 'minibuffer-setup-hook #'creature/turn-off-gc)
     (creature/turn-on-gc)))

(defconst creature/config-dir
  (file-name-directory
   (or load-file-name buffer-file-name))
  "Root directory of Creature.")

(defconst creature/cache-dir
  (expand-file-name ".cache" creature/config-dir)
  "Cache directory of Creature.")

(defconst creature/prefix-key "M-m"
  "Prefix key for `creature-map'.")

(add-to-list 'load-path (expand-file-name "lisp" creature/config-dir))

(let* ((file-name-handler-alist nil))
  (require 'server)
  (if (server-running-p)
      t
    (server-start))

  (require 'init-utils)
  (require 'init-modeline)
  (require 'init-elpa)
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
  )
