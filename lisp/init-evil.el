;; -*- coding: utf-8; lexical-binding: t; -*-

(creature/install-packages
  '(mwim
    evil
    evil-matchit
    evil-surround
    evil-nerd-commenter))

(with-eval-after-load 'evil
  (setq evil-undo-system 'undo-redo)
  (setcdr evil-insert-state-map nil)
  (evil-global-set-key 'insert [escape] #'evil-normal-state)
  (evil-global-set-key 'visual [escape] #'evil-normal-state)
  (evil-global-set-key 'normal [escape] #'evil-normal-state)
  (evil-global-set-key 'replace [escape] #'evil-normal-state)
  (evil-global-set-key 'motion (kbd "TAB") nil)
  (evil-global-set-key 'motion (kbd "<SPC>") #'creature-map)
  (evil-global-set-key 'normal (kbd "<SPC>") #'creature-map)
  (evil-global-set-key 'visual (kbd "<SPC>") #'creature-map)
  (evil-global-set-key 'normal (kbd "C-u") #'evil-scroll-up)

  (dolist (mode '(Info-mode
                  dired-mode
                  image-mode
                  Custom-mode
                  special-mode
                  compilation-mode
                  package-menu-mode
                  flycheck-error-list-mode))
    (evil-set-initial-state mode 'emacs))

  (dolist (mode '(messages-buffer-mode
                  youdao-dictionary-mode))
    (evil-set-initial-state mode 'motion))
  (add-to-list 'evil-buffer-regexps '("^\\*About GNU Emacs\\*\\'" . motion))
  (add-to-list 'evil-buffer-regexps '("^COMMIT_EDITMSG\\'" . insert))
  (evil-change-to-initial-state "*Messages*"))

(evil-mode)

;; enable evil matchit mode
(global-evil-matchit-mode)

;; ;; evil surround
(global-evil-surround-mode)
(evil-define-key 'visual evil-surround-mode-map
  "cc" 'evil-surround-change
  "cd" 'evil-surround-delete
  "cs" 'evil-surround-region)

(global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
(global-set-key (kbd "C-e") 'mwim-end-of-code-or-line)

(provide 'init-evil)
