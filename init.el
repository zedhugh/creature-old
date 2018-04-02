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
;; (package-initialize)

(setq start-init-time (current-time))

(defconst creature-dir
  (file-name-directory (or load-file-name buffer-file-name))
  "Root directory of creature.")

(add-to-list 'load-path
             (expand-file-name "lisp" creature-dir))

(require 'init-env)
(require 'init-elpa)
(require 'init-basic)
(require 'init-defuns)
(require 'init-evil)
(require 'init-utils)
(require 'init-ivy)
(require 'init-git)
(require 'init-webdev)
(require 'init-org)
(require 'init-keybindings)

(setq end-init-time (current-time))

;; load custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(setq finial-init-time (current-time))

(float-time (time-subtract end-init-time start-init-time))
(float-time (time-subtract finial-init-time start-init-time))

;; (provide 'init)
;;; init.el ends here
