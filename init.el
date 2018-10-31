;; the config in this file work after frame created.

;; turn off startup screen
(setq inhibit-splash-screen t)

(when (< emacs-major-version 27)
  (load-file (expand-file-name
              "early-init.el"
              user-emacs-directory)))

;; (when (display-graphic-p)
;;   (creature/fontset))

;; load custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file 'noerror))

;; (provide 'init)
;;; init.el ends here
