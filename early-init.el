;; Package initialize automatically before `user-init-file' is
;; loaded but after `early-init-file'. We handle package manually,
;; so must prevent Emacs from doing it early.
(setq package-enable-at-startup nil)

;; initialize frame with alpha
(add-to-list 'default-frame-alist '(alpha . 90))

;; Fullscreen Emacs frame. But awesome-wm configure its own rules for Emacs,
;; so frame size configuration not need in awesome-wm.
(unless (string= (getenv "DESKTOP_SESSION") "awesome")
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))

;; disable menu bar
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

;; disable tool bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; disable scroll bar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
