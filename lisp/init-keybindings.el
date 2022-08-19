;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'init-elpa)

;;; mwim
(creature/require-package 'mwim)

(global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
(global-set-key (kbd "C-e") 'mwim-end-of-code-or-line)

(global-set-key (kbd "s-v") 'clipboard-yank)
(global-set-key (kbd "s-c") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-M-\\") 'creature/indent-region-or-buffer)
(global-set-key  (kbd "C-c '") (kbd "`"))

(setq backward-delete-char-untabify-method 'hungry)
(global-set-key (kbd "DEL") 'backward-delete-char-untabify)
(global-set-key (kbd "C-x k") #'kill-this-buffer)
(global-set-key (kbd "C-x K") #'kill-buffer)

(global-set-key (kbd creature/prefix-key) 'creature-map)
;; (define-key special-mode-map (kbd creature/prefix-key) 'creature-map)

(creature/set-keys creature-map
                   "bb" 'switch-to-buffer
                   "bd" 'kill-current-buffer
                   "be" 'eval-buffer

                   "fi" 'creature/open-init-file
                   "fe" 'creature/open-early-init-org-file
                   "fo" 'creature/open-file-or-directory-in-external-app
                   "fj" 'dired-jump
                   "ff" 'find-file
                   "fp" 'find-file-at-point
                   "fs" 'save-buffer

                   "hf" 'describe-function
                   "hF" 'describe-face
                   "hv" 'describe-variable
                   "hk" 'describe-key
                   "ho" 'describe-symbol
                   "hp" 'describe-package
                   "qk" 'save-buffers-kill-emacs
                   "qq" 'save-buffers-kill-terminal

                   "SPC" 'execute-extended-command)

;;; window operations
(creature/require-package 'transient)

(transient-define-prefix creature/transient-window ()
  "Show menu buffer for window operations."
  :transient-suffix 'transient--do-stay
  :transient-non-suffix 'transient--do-warn
  [["Jump"
    ("d" "Window down" windmove-down)
    ("u" "Window up" windmove-up)
    ("l" "Window left" windmove-left)
    ("r" "Window right" windmove-right)
    ("p" "Window Previous" (lambda ()
                             (interactive)
                             (other-window -1))
     )
    ("n" "Window next" other-window)]

   ["Size reset"
    ("{" "Height shrink" shrink-window)
    ("}" "Height enlarge" enlarge-window)
    ("[" "Width shrink" shrink-window-horizontally)
    ("]" "Width enlarge" enlarge-window-horizontally)
    ("=" "Banlance" balance-windows :transient nil)]

   ["Operation"
    ("-" "Split below" split-window-below)
    ("/" "Split right" split-window-right)
    ("m" "Delete Others" delete-other-windows :transient nil)
    ("k" "Delete window" delete-window)
    ]])

(creature/set-keys creature-map "w" 'creature/transient-window)

;; (when sys/win32p
;;   ;; (w32-register-hot-key [s-t])
;;   (setq-default w32-apps-modifier 'hyper)
;;   (setq-default w32-lwindow-modifier 'super))

(provide 'init-keybindings)
