;; evil mode keybindings
(require 'evil)
(add-hook 'find-file-hook 'evil-local-mode)
(evil-local-mode)

;; (evil-mode)
(setcdr evil-insert-state-map nil)
(evil-global-set-key 'insert [escape] 'evil-normal-state)
;; (evil-global-set-key 'insert (kbd "<ESC>") 'evil-normal-state)
(evil-global-set-key 'motion (kbd "<tab>") nil)
(evil-global-set-key 'motion (kbd "<SPC>") nil)
(evil-global-set-key 'normal (kbd "C-u") 'evil-scroll-up)

;; initial state for modes
(evil-set-initial-state 'dired-mode 'emacs)
(evil-set-initial-state 'image-mode 'emacs)
(evil-set-initial-state 'Custom-mode 'emacs)
(evil-set-initial-state 'special-mode 'motion)
(evil-set-initial-state 'package-menu-mode 'emacs)
(evil-set-initial-state 'messages-buffer-mode 'motion)
(evil-set-initial-state 'youdao-dictionary-mode 'motion)
(evil-set-initial-state 'flycheck-error-list-mode 'emacs)
(evil-change-to-initial-state "*Messages*")

(define-advice about-emacs (:after nil)
  (with-current-buffer "*About GNU Emacs*"
    (evil-motion-state)))

;;; evil cursor style
(defun emacs-state-cursor-bar ()
  "Change cursor for emacs state to bar."
  (set (make-local-variable 'evil-emacs-state-cursor)
       'bar))

(add-hook 'text-mode-hook 'emacs-state-cursor-bar)
(add-hook 'prog-mode-hook 'emacs-state-cursor-bar)

;; enable evil matchit mode
(global-evil-matchit-mode)

;; evil surround
(global-evil-surround-mode)
(evil-define-key 'visual evil-surround-mode-map
  "cc" 'evil-surround-change
  "cd" 'evil-surround-delete
  "cs" 'evil-surround-region)

(provide 'init-evil)
