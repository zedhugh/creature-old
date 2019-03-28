;; codeing system
(prefer-coding-system 'utf-8)

;; turn off startup screen
(setq inhibit-splash-screen t)

;; disable menu, toolbar and scroll bar.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

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

;; make gc threshold to a big value to reduce initialize
;; time, and when emacs session startup, make gc threshold
;; to be a best value.
(defconst best-gc-cons-threshold
  (if sys/win32p
      (* 512 1024 1024)
    4000000)
  "Best default gc threshold value. Should't be to big.")

(setq gc-cons-threshold most-positive-fixnum)

(defconst creature/scratch-message
  (concat ";; Happy hacking "
          (or (user-login-name) "user")
          " - Emacs loves you.\n\n")
  "Customized initial scratch buffer message.")

(setq-default initial-scratch-message creature/scratch-message)

(add-hook 'emacs-startup-hook
          (lambda ()
            (creature/fontset)
            (setq gc-cons-threshold best-gc-cons-threshold)))

(provide 'init-startup)
