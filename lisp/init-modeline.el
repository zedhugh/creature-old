(defvar creature/mode-line-window-number
  '(:eval (window-numbering-get-number-string))
  "Get window number by window-numbering.")
(put 'creature/mode-line-window-number 'risky-local-variable t)

(defvar creature/mode-line-evil-state
  '(:eval
    (cond
     ((eq evil-state 'emacs) "[E]")
     ((eq evil-state 'insert) "[I]")
     ((eq evil-state 'motion) "[M]")
     ((eq evil-state 'normal) "[N]")
     ((eq evil-state 'visual) "[V]")
     ((eq evil-state 'replace) "[R]")
     ((eq evil-state 'operator) "[O]")))
  "Evil state indicator.")
(put 'creature/mode-line-evil-state 'risky-local-variable t)

(defvar creature/mode-line-buffer-name
  '(:eval (propertize
           "%b"
           'face 'mode-line-buffer-id))
  "Buffer name with face.")
(set-face-attribute 'mode-line-buffer-id nil :weight 'normal)
(put 'creature/mode-line-buffer-name 'risky-local-variable t)

(defvar creature/origin-mode-line-format
  mode-line-format
  "Keep origin `mode-line-format'")

(defvar creature/mode-line-format
  '("%e"
    creature/mode-line-window-number
    ;; (:eval (window-numbering-get-number-string))
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
    " "
    creature/mode-line-evil-state
    " (%m" ; major mode
    mode-line-process
    ")"
    (vc-mode vc-mode)
    (flycheck-mode flycheck-mode-line)
    mode-line-misc-info
    mode-line-end-spaces
    )
  "Customized mode line format.")

(defun creature/set-mode-line-format-for-exist-buffers ()
  "Make customized mode line works in exist buffers."
  (mapc (lambda (buffer)
          (with-current-buffer buffer
            (setq mode-line-format creature/mode-line-format)))
        (buffer-list)))

(setq-default mode-line-format creature/mode-line-format)
(creature/set-mode-line-format-for-exist-buffers)

(provide 'init-modeline)
