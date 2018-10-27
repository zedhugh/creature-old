;; the config in this file work after frame created.

(when (< emacs-major-version 27)
  (load-file (expand-file-name
              "early-init.el"
              user-emacs-directory)))

(when (display-graphic-p)
  (creature/fontset))

(unless sys/win32p
  (require-package 'exec-path-from-shell)
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize))

;; load custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file 'noerror))

;; (provide 'init)
;;; init.el ends here
