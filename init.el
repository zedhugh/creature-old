(unless (featurep 'package)
  (package-initialize))

(dolist (dir '("lisp" "site-lisp/awesome-pair" "site-lisp/liberime"))
  (add-to-list 'load-path (expand-file-name dir user-emacs-directory)))

(require 'init-options)

(when (< emacs-major-version 27)
  (load-file (expand-file-name "early-init.el" creature-dir)))

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
(require 'init-lsp)
;; (require 'init-evil)
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
