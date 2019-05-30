;; window numbering
(defvar creature/mode-line-window-number
  '(:eval (window-numbering-get-number-string))
  "Get window number by window-numbering.")
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

;; evil state
(defvar creature/mode-line-evil-state
  '(:eval
    (when (or (member 'evil-mode minor-mode-list)
              (member 'evil-local-mode minor-mode-list))
      (cond
       ((eq evil-state 'emacs) " [E]")
       ((eq evil-state 'insert) " [I]")
       ((eq evil-state 'motion) " [M]")
       ((eq evil-state 'normal) " [N]")
       ((eq evil-state 'visual) " [V]")
       ((eq evil-state 'replace) " [R]")
       ((eq evil-state 'operator) " [O]"))))
  "Evil state indicator.")
(put 'creature/mode-line-evil-state 'risky-local-variable t)

;; buffer name
(defvar creature/mode-line-buffer-name
  '(:eval (propertize
           "%b"
           'face 'mode-line-buffer-id))
  "Buffer name with face.")
(set-face-attribute 'mode-line-buffer-id nil :weight 'normal)
(put 'creature/mode-line-buffer-name 'risky-local-variable t)

;; marker region info
(defvar creature/mode-line-region-info
  '(:eval
    (when (region-active-p)
      (let ((length (- (region-end) (region-beginning)))
            (line (- (line-number-at-pos (region-end))
                     (line-number-at-pos (region-beginning))
                     -1)))
        (format " [%d|%d]" length line))))
  "Length of marked string.")
(put 'creature/mode-line-region-info 'risky-local-variable t)

;; combin mode line fromat
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
    creature/mode-line-evil-state
    " ("
    mode-name ; major mode
    mode-line-process
    company-lighter
    ")"
    creature/mode-line-region-info
    (vc-mode vc-mode)
    ;; (flycheck-mode flycheck-mode-line)
    creature/flycheck-errors
    mode-line-misc-info
    mode-line-end-spaces
    )
  "Customized mode line format.")
(setq-default mode-line-format creature/mode-line-format)

;; 1. define a variable to keep origin mode-line
;; 2. make customized mode-line worked for exist buffers.
(defvar creature/origin-mode-line-format
  mode-line-format
  "Keep origin `mode-line-format'")

(creature/set-mode-line-format-for-exist-buffers)

(provide 'init-modeline)
