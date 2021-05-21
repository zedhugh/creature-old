;; -*- coding: utf-8; lexical-binding: t; -*-

(defconst creature/font-config
  ;; '("Operator Mono Book" . 16)
  (if creature/sys-win32p
      (if (> (frame-pixel-width) 2560)
          '(("等距更纱黑体 SC" . 24))
        '(("等距更纱黑体 SC" . 16)))
    '(("Sarasa Mono SC" . 16)))
  ;; '("Source Code Pro" . 16)
  "Font config.
It's a list of single-byte and multi-byte font.
Each font conf looks like (FAMILY . SIZE).")

(defun creature/fontset (&optional frame)
  "Config fonts for FRAME.
if FRAME is nil, setup for current frame."
  ;; single-byte code
  (setq inhibit-compacting-font-caches t)

  (let ((single (car creature/font-config))
        (multi  (cdr creature/font-config)))
    (let ((family   (car single))
          (size     (cdr single)))
      (when (or family size)
        (condition-case nil
            (set-face-attribute 'default frame
                                :font (font-spec :family family :size size))
          (error nil))))
    (let ((family   (car multi))
          (size     (cdr multi)))
      (when (member family (font-family-list))
        (dolist (charset '(kana han cjk-misc bopomofo))
          (condition-case nil
              (set-fontset-font t charset
                                (font-spec :family family :size size) frame)
            (error nil)))))))

;; (add-hook 'emacs-startup-hook #'creature/fontset)
(add-hook 'server-after-make-frame-hook #'creature/fontset)

;; some beautifule theme built-in
;; dark: modus-vivendi/wombat/misterioso/tango-dark/wheatgrass
;; light: whiteboard
;; (if (member 'modus-vivendi (custom-available-themes))
;;     (load-theme 'modus-vivendi t)
;;   (load-theme 'whiteboard t))

(defvar creature/theme-cons
  (if (member 'modus-vivendi (custom-available-themes))
      '(modus-vivendi . modus-operandi)
    '(tango-dark . tango))
  "Theme cons with form (Dark . Light).")

(defvar creature/light-theme-time '("08:00" . "18:00")
  "Time interval of light theme in `creature/theme-cons")

(defun creature/theme-setup ()
  (let* ((dark (car creature/theme-cons))
         (light (cdr creature/theme-cons))

         (start-time-string (car creature/light-theme-time))
         (end-time-string (cdr creature/light-theme-time))

         (start-hhmm (diary-entry-time start-time-string))
         (end-hhmm (diary-entry-time end-time-string))

         (now (decode-time))
         (encoded-now (encode-time now))

         (day (decoded-time-day now))
         (month (decoded-time-month now))
         (year (decoded-time-year now))
         (zone (decoded-time-zone now))

         (start-time (encode-time 0 (% start-hhmm 100) (/ start-hhmm 100) day month year zone))
         (end-time (encode-time 0 (% end-hhmm 100) (/ end-hhmm 100) day month year zone))

         (after-start-time (> (float-time (time-subtract encoded-now start-time)) 0))
         (after-end-time (> (float-time (time-subtract encoded-now end-time)) 0)))

    (when light
      (when (and after-start-time
                 (not after-end-time))
        (load-theme light t))

      (run-at-time start-time-string nil
                   (lambda ()
                     (dolist (theme custom-enabled-themes)
                       (disable-theme theme))
                     (load-theme light t))))

    (when dark
      (when (or after-end-time
                (not after-start-time))
        (load-theme dark t))

      (run-at-time end-time-string nil
                   (lambda ()
                     (dolist (theme custom-enabled-themes)
                       (disable-theme theme))
                     (load-theme dark t))))))

(defvar creature/pulse-enable t
  "Whether enable pulse for scroll and switch window.")

(defun creature/pulse-line (&rest _)
  "Pulse the current line."
  (when creature/pulse-enable
    (pulse-momentary-highlight-one-line (point))))

(run-with-idle-timer
 2 nil
 (lambda ()
   (creature/fontset)
   (creature/theme-setup)

   ;; disable menu, toolbar and scroll bar.
   (when (fboundp 'menu-bar-mode)
     (menu-bar-mode -1))
   (when (fboundp 'tool-bar-mode)
     (tool-bar-mode -1))
   (when (fboundp 'scroll-bar-mode)
     (scroll-bar-mode -1))

   ;; pulse setup, like beacon
   (with-eval-after-load 'pulse
     (setq pulse-delay 0.04))

   (dolist (command '(scroll-up
                      scroll-down
                      recenter))
     (advice-add command :after #'creature/pulse-line))
   (add-to-list 'window-selection-change-functions #'creature/pulse-line)
   ))

(dolist (mode '(rainbow-delimiters-mode
                rainbow-identifiers-mode))
  (add-hook 'prog-mode-hook mode))

;; page break lines
(global-page-break-lines-mode)
(setq page-break-lines-char ?=)
(dolist (mode '(web-mode css-mode js-mode typescript-mode c-mode c++-mode))
  (add-to-list 'page-break-lines-modes mode))

(blink-cursor-mode -1)

;; maximized(but follow the rule in awesome-wm) window with alpha
(add-to-list 'default-frame-alist '(alpha . 90))
(unless (string= (getenv "DESKTOP_SESSION") "awesome")
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))

;; turn off startup screen
(setq inhibit-splash-screen t)

;; disable bell
(setq ring-bell-function 'ignore)
(setq visible-bell nil)

;; Keep cursor at end of lines when prev
;; position of cursor is at the end.
;; Require line-move-visual is nil.
(setq track-eol t)
(setq line-move-visual t)

;; disable gtk tooltips
(setq x-gtk-use-system-tooltips nil)

(provide 'init-theme)
