;; codeing system
(prefer-coding-system 'utf-8)

;; turn off startup screen
(setq inhibit-splash-screen t)

;; disable bell
(setq ring-bell-function 'ignore)
(setq visible-bell nil)

;; maximized frame when startup
(unless (string-equal (getenv "DESKTOP_SESSION") "awesome")
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))

;; Keep cursor at end of lines when prev
;; position of cursor is at the end.
;; Require line-move-visual is nil.
(setq track-eol t)
(setq line-move-visual t)

;; disable gtk tooltips
(setq x-gtk-use-system-tooltips nil)

(setq gc-cons-threshold most-positive-fixnum)

(setq-default initial-scratch-message creature/scratch-message)

(add-hook 'after-make-frame-functions #'creature/fontset)
(add-hook 'emacs-startup-hook
          (lambda ()
            (creature/fontset)
            (setq gc-cons-threshold creature/best-gc-cons-threshold)))

;; (desktop-read creature-dir)

;; (run-with-idle-timer 5 nil '(lambda ()
;;                               (desktop-save-mode)
;;                               (setq desktop-save t)))

(provide 'init-startup)
