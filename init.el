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

(defconst creature-dir
  (file-name-directory (or load-file-name buffer-file-name))
  "Directory creature in.")

(add-to-list 'load-path (expand-file-name "lisp" creature-dir))

(require 'init-env)
(require 'init-elpa)
(require 'init-basic)
(require 'init-utils)
(require 'init-evil)
(require 'init-defuns)
(require 'init-ivy)
(require 'init-git)
(require 'init-keybindings)

;; load custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; (provide 'init)
;;; init.el ends here
