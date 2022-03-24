;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  package                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package initialize automatically before `user-init-file' is
;; loaded but after `early-init-file'. We handle package manually,
;; so must prevent Emacs from doing it early.
(setq package-enable-at-startup nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              UI configuration                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Inhibit resizing frame
(setq frame-inhibit-implied-resize t)

;; Initialize frame with alpha
(add-to-list 'default-frame-alist '(alpha-background . 85))

;; Fullscreen Emacs frame. But awesome-wm configure its own rules for Emacs,
;; so frame size configuration not need in awesome-wm.
(unless (string= (getenv "DESKTOP_SESSION") "awesome")
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))

;; Disable menu bar
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

;; Disable tool bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Disable scroll bar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       Report time for initialization                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar creature-init-time nil
  "Time cost for initialization.")

(defun calc-init-time ()
  (setq creature-init-time
        (float-time (time-subtract (current-time) before-init-time)))

  (remove-hook 'emacs-startup-hook #'calc-init-time)
  (fmakunbound 'calc-init-time))

(add-hook 'emacs-startup-hook #'calc-init-time)

;; early-init.el ends hear
