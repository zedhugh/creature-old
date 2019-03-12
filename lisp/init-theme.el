(load-theme 'molokai t)

(dolist (mode '(rainbow-delimiters-mode
                rainbow-identifiers-mode))
  (add-hook 'prog-mode-hook mode))

;; page break lines
(global-page-break-lines-mode)
(setq page-break-lines-char ?=)
(add-to-list 'page-break-lines-modes 'web-mode)

;; address style
(add-hook 'text-mode-hook 'goto-address-mode)
(add-hook 'prog-mode-hook 'goto-address-prog-mode)

;; cursor style
(setq-default cursor-type 'bar)

;; which key
(which-key-mode)
(setq which-key-idle-delay 0.4)

;; window number
(window-numbering-mode)

;; font config
(defconst creature/default-font
  ;; '("Operator Mono Book" . 16)
  '("Sarasa Mono SC" . 16)
  ;; '("Source Code Pro" . 16)
  "Default font for single-byte code.")

(defconst creature/chinese-font
  '("Sarasa Mono SC" . 16)
  ;; (if sys/win32p
  ;;     '("SimSun" . 18)
  ;;   '("Emacs SimSun" . 18))
  "Default font for multi-byte code.")

(defun creature/fontset (&optional frame)
  "Font sets for default and multi-byte code."
  ;; single-byte code
  (setq inhibit-compacting-font-caches t)
  (let ((family (car creature/default-font))
        (size (cdr creature/default-font)))
    (set-face-attribute 'default frame
                        :font (font-spec :family family :size size)))
  ;; multi-byte code
  (let ((family (car creature/chinese-font))
        (size (cdr creature/chinese-font)))
    (dolist (charset '(kana han cjk-misc bopomofo))
      (set-fontset-font t ;; (frame-parameter nil 'font)
                        charset
                        (font-spec :family family :size size) frame))))

(set-face-attribute font-lock-comment-face nil :slant 'italic)

(provide 'init-theme)
