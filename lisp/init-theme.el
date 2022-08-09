;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'init-elpa)

(defconst creature/font-config
  ;; '(("Operator Mono Book" . 16))
  (if creature/sys-win32p
      (if (> (frame-pixel-width) 2560)
          '(("等距更纱黑体 SC" . 24))
        '(("等距更纱黑体 SC" . 16)))
    '(("Sarasa Mono SC" . 16)))
  ;; '(("Source Code Pro" . 16))
  "Font config.
It's a list of single-byte and multi-byte font.
Each font conf looks like (FAMILY . SIZE).")

(defun creature/fontset (&optional frame)
  "Config fonts for FRAME.
if FRAME is nil, setup for current frame."
  ;; single-byte code
  (setq inhibit-compacting-font-caches (if creature/sys-win32p t nil))

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

(add-hook 'emacs-startup-hook #'creature/fontset)
(add-hook 'server-after-make-frame-hook #'creature/fontset)

(creature/require-package 'circadian)
(creature/maybe-require-package 'modus-themes)

(when (and (fboundp 'circadian-setup)
           (custom-theme-name-valid-p 'modus-vivendi))
  (setq circadian-themes '(("08:00" . modus-operandi)
                           ("18:00" . modus-vivendi)))
  (circadian-setup))
;; (add-hook 'server-after-make-frame-hook #'circadian-setup)


(provide 'init-theme)
