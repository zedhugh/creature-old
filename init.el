(unless (featurep 'package)
  (package-initialize))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; define variales to keep environment
(defconst sys/win32p
  (eq system-type 'windows-nt)
  "If system is Windows return t, therwise return nil.")
(defconst creature-dir
  (file-name-directory (or load-file-name buffer-file-name))
  "Root directory of creature.")

(defconst creature-cache
  (expand-file-name ".cache" creature-dir)
  "Cache directory.")

(require 'init-startup)
(require 'init-elpa)
(require 'init-funcs)
(require 'init-paredit)
(require 'init-company)
(require 'init-theme)
(require 'init-hydra)
(require 'init-utils)
(require 'init-webdev)
(require 'init-swiper)
(require 'init-misc)
(require 'init-org)
(require 'init-dired)
(require 'init-program)
(require 'init-evil)
(require 'init-modeline)
(require 'init-keybindings)
(with-eval-after-load 'gnus
  (require 'init-mail))

;; (org-babel-load-file (expand-file-name "creature.org" user-emacs-directory))

;; load custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file 'noerror))

;; (provide 'init)
;;; init.el ends here
