;; init.el --- entry

;;; Commentary:

;; Entry of Emacs config.
;; add load path for this way beacuse I don't want
;; make it's too long pre line.
;; core thought for this config:
;;   1. use evil keybindings.
;;   2. use "which-key" to prompt command.
;;   3. do not use "use-package", but origin elisp.
;;   4. organize config with function.

;;; Code:

(package-initialize)

(setq-local a (current-time))

(defconst sys/win32p
  (eq system-type 'windows-nt)
  "Is the system is Windows?")

(defconst sys/graphicp
  (display-graphic-p)
  "Is Emacs run with graphic?")

(defconst creature-dir
  (file-name-directory (or load-file-name buffer-file-name))
  "Root directory of creature.")

(defconst creature-cache
  (expand-file-name ".cache" creature-dir)
  "Cache directory.")

(defconst best-gc-cons-threshold 4000000
  "Best default gc threshold value. Should't be to big.")

(setq gc-cons-threshold most-positive-fixnum)

(add-to-list 'load-path
             (expand-file-name "lisp" creature-dir))

(require 'init-elpa)
(require 'init-defuns)
(require 'init-evil)
(require 'init-utils)
(require 'init-company)
(require 'init-ivy)
(require 'init-javascript)
(require 'init-web-mode)
(require 'init-keybindings)
(require 'init-misc)
(require 'init-ui)
(require 'init-git)

;; idle load
(idle-require 'init-org)
(setq idle-require-idle-delay 5)
(idle-require-mode)

;; load custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file 'noerror))

(setq-local b (current-time))

(setq-local c (float-time (time-subtract b a)))

(setq initial-scratch-message
      (concat ";; load init file: `" (number-to-string c) "'"
              ", emacs init time: `" (emacs-init-time) "'\n"
              initial-scratch-message))

(setq gc-cons-threshold best-gc-cons-threshold)

;; (provide 'init)
;;; init.el ends here
