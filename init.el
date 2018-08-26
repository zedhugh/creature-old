;; the config in this file work after frame created.

(when (< emacs-major-version 27)
  (load-file (expand-file-name
              "early-init.el"
              user-emacs-directory)))

(when (display-graphic-p)
  (creature/fontset)
  (blink-cursor-mode -1))

(setq gc-cons-threshold best-gc-cons-threshold)

;; load custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file 'noerror))

(when (< (time-to-seconds (current-time))
         (time-to-seconds after-init-time))
  (setq-local b (current-time))
  (setq-local c (float-time (time-subtract b a)))
  (setq initial-scratch-message
        (concat ";; load init file: `" (number-to-string c) "'"
                ", emacs init time: " (emacs-init-time) "\n"
                initial-scratch-message)))


;; (provide 'init)
;;; init.el ends here
