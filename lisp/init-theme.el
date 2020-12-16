;; -*- coding: utf-8; lexical-binding: t; -*-

(creature/install-packages
  '(rainbow-delimiters
    rainbow-delimiters
    rainbow-identifiers
    page-break-lines))

(defconst creature/font-config
  ;; '("Operator Mono Book" . 16)
  (if creature/sys-win32p
      '(("等距更纱黑体 SC" . 16))
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
;; (add-hook 'server-after-make-frame-hook #'creature/fontset)

;; some beautifule theme built-in
;; dark: modus-vivendi/wombat/misterioso/tango-dark/wheatgrass
;; light: whiteboard
;; (if (member 'modus-vivendi (custom-available-themes))
;;     (load-theme 'modus-vivendi t)
;;   (load-theme 'whiteboard t))

(defun creature/load-font-and-theme-idle ()
  (run-with-idle-timer 2 nil
                       (lambda ()
                         (creature/fontset)
                         (if (member 'modus-vivendi (custom-available-themes))
                             (load-theme 'modus-vivendi t)
                           (load-theme 'whiteboard t)))))

(creature/load-font-and-theme-idle)
(add-hook 'server-after-make-frame-hook #'creature/load-font-and-theme-idle)

(dolist (mode '(rainbow-delimiters-mode
                rainbow-identifiers-mode))
  (add-hook 'prog-mode-hook mode))

;; page break lines
(global-page-break-lines-mode)
(setq page-break-lines-char ?=)
(dolist (mode '(web-mode css-mode js-mode))
  (add-to-list 'page-break-lines-modes mode))

(blink-cursor-mode -1)

(provide 'init-theme)
