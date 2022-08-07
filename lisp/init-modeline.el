;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'init-elpa)

(creature/require-package 'winum)

;; window number
(setq winum-auto-setup-mode-line nil)
(winum-mode)
(define-key winum-keymap (kbd "M-0") 'winum-select-window-0-or-10)
(define-key winum-keymap (kbd "M-1") 'winum-select-window-1)
(define-key winum-keymap (kbd "M-2") 'winum-select-window-2)
(define-key winum-keymap (kbd "M-3") 'winum-select-window-3)
(define-key winum-keymap (kbd "M-4") 'winum-select-window-4)
(define-key winum-keymap (kbd "M-5") 'winum-select-window-5)
(define-key winum-keymap (kbd "M-6") 'winum-select-window-6)
(define-key winum-keymap (kbd "M-7") 'winum-select-window-7)
(define-key winum-keymap (kbd "M-8") 'winum-select-window-8)
(define-key winum-keymap (kbd "M-9") 'winum-select-window-9)

(defun creature/set-mode-line-format-for-exist-buffers ()
  "Make customized mode line works in exist buffers."
  (mapc (lambda (buffer)
          (with-current-buffer buffer
            (setq mode-line-format creature/mode-line-format)))
        (buffer-list)))

(defvar creature/mode-line-window-number
  '(:eval (when (and winum-mode
                     (fboundp #'winum-get-number-string))
            (winum-get-number-string)))
  "Get window number by winum.")
(put 'creature/mode-line-window-number 'risky-local-variable t)

;; flycheck
(defvar creature/flycheck-errors
  '(:eval
    (when (bound-and-true-p flycheck-mode)
      (let ((text (pcase flycheck-last-status-change
                    (`not-checked "")
                    (`no-checker "-")
                    (`running "*")
                    (`errored "!")
                    (`finished
                     (let-alist (flycheck-count-errors flycheck-current-errors)
                       (if (or .error .warning .info)
                           (concat (propertize (format "•%s" (or .error 0))
                                               'face `(:foreground "#ff0000"))
                                   (propertize (format " •%s" (+ (or .warning 0) (or .info 0)))
                                               'face `(:foreground "#00ff00")))
                         ;; (format "•%s •%s" (or .error 0) (or .warning 0))
                         "")))
                    (`interrupted ".")
                    (`suspicious "?"))))
        ;; (concat " " flycheck-mode-line-prefix text)
        (concat " " text)))))
(put 'creature/flycheck-errors 'risky-local-variable t)

;; buffer name
(defvar creature/mode-line-buffer-name
  '(:eval (propertize
           "%b"
           'face 'mode-line-buffer-id))
  "Buffer name with face.")
(set-face-attribute 'mode-line-buffer-id nil :weight 'normal)
(put 'creature/mode-line-buffer-name 'risky-local-variable t)

;; marker region info
(defvar creature/focus-window nil
  "Current focus window.")

(defun creature/save-current-window ()
  "Save current window."
  (setq creature/focus-window (selected-window)))

(add-hook 'post-command-hook
          #'creature/save-current-window)

(defvar creature/mode-line-region-info
  '(:eval
    (when (and (region-active-p) (eq creature/focus-window (selected-window)))
      (let ((length (- (region-end) (region-beginning)))
            (line (- (line-number-at-pos (region-end))
                     (line-number-at-pos (region-beginning))
                     -1)))
        (format " [%d|%d]" length line))))
  "Length of marked string.")
(put 'creature/mode-line-region-info 'risky-local-variable t)

(defvar creature/mode-line-company-info
  '(:eval
    (when (and (not buffer-read-only)
               (or (bound-and-true-p company-mode)
                   (bound-and-true-p global-company-mode)))
      company-lighter))
  "Customize company lighter.")
(put 'creature/mode-line-company-info 'risky-local-variable t)

;; combin mode line fromat
(defvar creature/mode-line-format
  '("%e"
    creature/mode-line-window-number
    " "
    current-input-method-title
    "%Z" ; coding system and eol type
    "%*" ; read only buffer?
    "%+" ; buffer modified?
    "%@" ; buffer is in remote?
    " "
    creature/mode-line-buffer-name
    " {"
    "%p" ; percent of point in buffer
    ","
    "%I" ; buffer size
    "}("
    "%l,%c" ; line and column
    ")"
    " ("
    mode-name ; major mode
    mode-line-process
    creature/mode-line-company-info
    ")"
    creature/mode-line-region-info
    (vc-mode vc-mode)
    ;; (flycheck-mode flycheck-mode-line)
    creature/flycheck-errors
    (flymake-mode flymake-mode-line-format)
    mode-line-misc-info
    mode-line-end-spaces
    )
  "Customized mode line format.")

;; 1. define a variable to keep origin mode-line
;; 2. make customized mode-line worked for exist buffers.
(defvar creature/origin-mode-line-format
  mode-line-format
  "Keep origin `mode-line-format'")

(setq-default mode-line-format creature/mode-line-format)

(creature/set-mode-line-format-for-exist-buffers)

(defun creature/toggle-mode-line ()
  "Switch `mode-line-format' between customized and the origin.
Customized is save in `creature/mode-line-format',
orgiin is in `creature/origin-mode-line-format'."

  (let ((tmp-mode-line
         (if (eq mode-line-format creature/mode-line-format)
             creature/origin-mode-line-format
           creature/mode-line-format)))
    (mapc (lambda (buffer)
            (with-current-buffer buffer
              (setq mode-line-format tmp-mode-line)))
          (buffer-list))
    (setq-default mode-line-format tmp-mode-line)
    nil))

;; (setq display-time-interval 1)
(setq display-time-format " %R %a %F")
(setq display-time-load-average nil)
(setq display-time-default-load-average nil)
(display-time-mode)

(provide 'init-modeline)
