;;; init-evil.el --- evil

;;; Commentary:

;; package for evil

;;; Code:

;; evil-leader should enable before enable evil,
;; otherwise it's will not be enabled.
(use-package evil-leader
  :init
  (setq evil-leader/in-all-states t)
  (setq evil-leader/non-normal-prefix "S-")
  (add-hook 'emacs-startup-hook 'global-evil-leader-mode)
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "bb"  'switch-to-buffer
    "bd"  'kill-current-buffer
    "be"  'eval-buffer
    "fj"  'dired-jump
    "ff"  'find-file
    "fr"  'recentf-open-files
    "fs"  'save-buffer
    "hdb" 'describe-bindings
    "hdf" 'describe-function
    "hdF" 'describe-face
    "hdv" 'describe-variable
    "hdk" 'describe-key
    "hdp" 'describe-package
    "qq"  'save-buffers-kill-terminal
    "wd"  'delete-window
    "w/"  'split-window-right
    "w-"  'split-window-below
    "w="  'balance-windows
    "wj"  'evil-window-down
    "wJ"  'evil-window-move-very-bottom
    "wk"  'evil-window-up
    "wK"  'evil-window-move-very-top
    "wh"  'evil-window-left
    "wH"  'evil-window-move-far-left
    "wl"  'evil-window-right
    "wL"  'evil-window-move-far-right
    "wm"  'delete-other-windows
    "wn"  'evil-window-next
    "wp"  'evil-window-prev
    "SPC" 'execute-extended-command))

(use-package evil
  :init
  ;; (add-hook 'evil-leader-mode-hook 'evil-mode)
  (add-hook 'global-evil-leader-mode-hook 'evil-mode)
  :config
  (setcdr evil-insert-state-map nil)
  (evil-global-set-key 'insert [escape] 'evil-normal-state)
  (evil-global-set-key 'motion (kbd "TAB") nil)
  (evil-global-set-key 'motion (kbd "<SPC>") nil)
  ;; inital state for modes
  (evil-set-initial-state 'dired-mode 'emacs)
  (evil-set-initial-state 'image-mode 'emacs)
  (evil-set-initial-state 'Custom-mode 'motion)
  (evil-set-initial-state 'package-menu-mode 'motion)
  (evil-set-initial-state 'messages-buffer-mode 'motion)
  (evil-set-initial-state 'youdao-dictionary-mode 'motion)
  (evil-set-initial-state 'flycheck-error-list-mode 'motion)
  (evil-change-to-initial-state "*Messages*")

  (define-advice about-emacs (:after nil)
    (with-current-buffer "*About GNU Emacs*"
      (evil-motion-state))))

;; mwim
(use-package mwim
  :init
  (global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
  (global-set-key (kbd "C-e") 'mwim-end-of-code-or-line))

;; evil-nerd-commenter
(use-package evil-nerd-commenter
  :init
  (evil-leader/set-key
    "cl" 'evilnc-comment-or-uncomment-lines
    "cp" 'evilnc-comment-or-uncomment-paragraphs))


;; evil-surround
(use-package evil-surround
  :init
  (add-hook 'emacs-startup-hook 'global-evil-surround-mode)
  (evil-define-key 'visual evil-surround-mode-map "cc" 'evil-surround-change)
  (evil-define-key 'visual evil-surround-mode-map "cd" 'evil-surround-delete)
  (evil-define-key 'visual evil-surround-mode-map "cs" 'evil-surround-region))

(provide 'init-evil)
;;; init-evil.el ends here
