;;; evil mode keybindings

;; evil-leader should enable before evil,
;; otherwise evil-leader will not work.
;; (global-evil-leader-mode)
;; (setq evil-leader/in-all-states t)
;; (setq evil-leader/non-normal-prefix "S-")
;; (evil-leader/set-leader "<SPC>")

(evil-escape-mode)
(setq-default evil-escape-delay 0.2)
(setq-default evil-escape-key-sequence "jk")

(evil-mode)
(setcdr evil-insert-state-map nil)
;; (evil-global-set-key 'insert (kbd "<ESC>") 'evil-normal-state)
(evil-global-set-key 'motion (kbd "TAB") nil)
(evil-global-set-key 'motion (kbd "<SPC>") #'creature-map)
(evil-global-set-key 'normal (kbd "<SPC>") #'creature-map)
(evil-global-set-key 'visual (kbd "<SPC>") #'creature-map)
(evil-global-set-key 'normal (kbd "C-u") 'evil-scroll-up)

;; initial state for modes
(evil-set-initial-state 'dired-mode 'emacs)
(evil-set-initial-state 'image-mode 'emacs)
(evil-set-initial-state 'Custom-mode 'emacs)
(evil-set-initial-state 'special-mode 'emacs)
(evil-set-initial-state 'compilation-mode 'emacs)
(evil-set-initial-state 'package-menu-mode 'emacs)
(evil-set-initial-state 'messages-buffer-mode 'motion)
(evil-set-initial-state 'youdao-dictionary-mode 'motion)
(evil-set-initial-state 'flycheck-error-list-mode 'emacs)
(evil-change-to-initial-state "*Messages*")

(defun creature/magit-commit-buffer-state ()
  (run-with-idle-timer 0.01 nil
                       (lambda ()
                         (ignore-errors
                           (with-current-buffer "COMMIT_EDITMSG"
                             (evil-insert-state))))))
(add-hook 'text-mode-hook #'creature/magit-commit-buffer-state)

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

;; ;; evil surround
(global-evil-surround-mode)
(evil-define-key 'visual evil-surround-mode-map
  "cc" 'evil-surround-change
  "cd" 'evil-surround-delete
  "cs" 'evil-surround-region)

(provide 'init-evil)
