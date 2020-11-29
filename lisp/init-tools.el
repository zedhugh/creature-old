;; -*- coding: utf-8; lexical-binding: t; -*-

;;; ediff
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; gpg config
(defun creature/kill-gpg-agent ()
  "Kill `gpg-agent' for security when Emacs be killed."
  (when (and (bound-and-true-p epg-gpgconf-program)
             (executable-find epg-gpgconf-program))
    (start-process "" nil epg-gpgconf-program "--kill" "gpg-agent")))
(add-hook 'kill-emacs-hook #'creature/kill-gpg-agent)

(creature/install-packages 'pinentry)
(defun creature/start-pinentry ()
  (condition-case nil
      (pinentry-start)
    (error nil)))
(add-hook 'emacs-startup-hook #'creature/start-pinentry)

(creature/install-packages 'keyfreq)
(keyfreq-mode)
(keyfreq-autosave-mode)
(setq keyfreq-file
      (expand-file-name ".keyfreq" creature/cache-dir))
(setq keyfreq-excluded-commands
      '(self-insert-command
        forward-char
        backward-char
        previous-line
        next-line))

;; rime
(creature/install-packages 'rime)
(setq rime-emacs-module-header-root "/usr/include/emacs-28-vcs")
(setq default-input-method "rime")
(with-eval-after-load 'rime
  (setq rime-show-candidate 'minibuffer)
  (setq rime-show-candidate 'posframe)
  (setq rime-posframe-style 'simple)
  (setq rime-posframe-fixed-position t)
  (setq rime-disable-predicates
        (if (featurep 'evil)
            '(rime-predicate-prog-in-code-p
              rime-predicate-evil-mode-p
              rime-predicate-hydra-p)
          '(rime-predicate-prog-in-code-p
            rime-predicate-hydra-p)))

  (define-key rime-mode-map (kbd "M-i") 'rime-force-enable)
  (define-key rime-active-mode-map (kbd "M-i") 'rime-inline-ascii))

;;; magit
(creature/install-packages '(forge
                             gitattributes-mode
                             gitconfig-mode
                             gitignore-mode))
;; (with-eval-after-load 'magit
;;   (require 'forge))
(setq magit-revision-show-gravatars
      '("^Author:     " . "^Commit:     "))

(creature/install-packages '(rg
                             symbol-overlay))

(creature/install-packages 'rg)
(rg-enable-default-bindings)

;;; symbol-overlay-map
;; "i" -> symbol-overlay-put
;; "n" -> symbol-overlay-jump-next
;; "p" -> symbol-overlay-jump-prev
;; "w" -> symbol-overlay-save-symbol
;; "t" -> symbol-overlay-toggle-in-scope
;; "e" -> symbol-overlay-echo-mark
;; "d" -> symbol-overlay-jump-to-definition
;; "s" -> symbol-overlay-isearch-literally
;; "q" -> symbol-overlay-query-replace
;; "r" -> symbol-overlay-rename
(global-set-key (kbd "s-i") 'symbol-overlay-put)
(global-set-key (kbd "M-p") 'symbol-overlay-jump-prev)
(global-set-key (kbd "M-n") 'symbol-overlay-jump-next)

;; window number
(creature/install-packages 'winum)
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

(creature/install-packages
  '(projectile
    counsel-projectile))
(with-eval-after-load 'projectile
  (global-set-key (kbd "C-c p") #'projectile-command-map))

(creature/install-packages 'avy)
(define-key global-map (kbd "M-g w") #'avy-goto-word-1)
(define-key global-map (kbd "M-g M-w") #'avy-goto-word-1)

(creature/install-packages '(undo-tree
                             expand-region
                             youdao-dictionary))

(provide 'init-tools)
