;; the config in this file work after frame created.

(when (< emacs-major-version 27)
  (load-file (expand-file-name
              "early-init.el"
              user-emacs-directory)))

(when sys/win32p
  (setq inhibit-splash-screen t))

(when (display-graphic-p)
  (creature/fontset)
  (blink-cursor-mode -1))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(setq gc-cons-threshold best-gc-cons-threshold)

;; load custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file 'noerror))

;; (provide 'init)
;;; init.el ends here
