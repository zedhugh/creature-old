(defconst creature/default-font
  '("Operator Mono Book" . 16)
  ;; '("Source Code Pro" . 16)
  "Default font for single-byte code.")

(defconst creature/chinese-font
  (if sys/win32p
      '("SimSun" . 18)
    '("Emacs SimSun" . 18))
  "Default font for multi-byte code.")

(defconst creature/theme 'molokai
  "Theme for this config.")

;; hightlight line
;; (if sys/graphicp
;;     (global-hl-line-mode 1)
;;   (global-hl-line-mode -1))

;; disable menu bar, tool bar and scroll bar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; disable bell
(setq ring-bell-function 'ignore)

;; maximized frame except in tiled window manager.
;; there is "awesome".
(unless (string-equal "awesome" (getenv "DESKTOP_SESSION"))
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))

;; click(C-c RET) to browse URL
(goto-address-mode)
(goto-address-prog-mode)

(if sys/graphicp
    nil
  (require 'time)
  (setq display-time-24hr-format t)
  (setq display-time-day-and-date t)
  (display-time-mode))

;; disable startup screen
(setq inhibit-splash-screen t)

(setq visible-bell nil)
(size-indication-mode)
(blink-cursor-mode -1)

;; Keep cursor at end of lines when prev
;; position of cursor is at the end.
;; Require line-move-visual is nil.
(setq track-eol t)
(setq line-move-visual t)

(setq x-gtk-use-system-tooltips nil)

;; fontset only for graphic
(when window-system
  (creature/fontset))

;; colorful GUI
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; load theme
(when sys/graphicp
  (load-theme creature/theme t))


;; add fontset work after emacs initialized
(set-face-attribute 'italic nil :slant 'italic :underline 'unspecified)
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)

;; page break line
(global-page-break-lines-mode)
(setq page-break-lines-char ?-)
(add-to-list 'page-break-lines-modes 'web-mode)

(provide 'init-ui)
