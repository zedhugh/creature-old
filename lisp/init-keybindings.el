(global-set-key (kbd "C-;") 'iedit-mode)
(global-set-key (kbd "s-v") 'clipboard-yank)
(global-set-key (kbd "s-c") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-M-\\") 'creature/indent-region-or-buffer)

;;; mwim
(global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
(global-set-key (kbd "C-e") 'mwim-end-of-code-or-line)

;;; org mode
;; better behavior for "RET" key
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "RET") 'org-return-indent))

(define-prefix-command 'creature-map)
(global-set-key (kbd "S-<SPC>") 'creature-map)

(creature/set-keys creature-map
  "ac" 'avy-goto-char
  "aw" 'avy-goto-word-1
  "al" 'avy-goto-line

  "bb" 'switch-to-buffer
  "bd" 'kill-current-buffer
  "be" 'eval-buffer

  "cl" 'evilnc-comment-or-uncomment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs

  "el" 'flycheck-list-errors
  "ex" 'flycheck-display-error-at-point

  "fi" 'creature/open-init-file
  "fe" 'creature/open-early-init-org-file
  "fo" 'creature/open-file-or-directory-in-external-app
  "fj" 'dired-jump
  "ff" 'find-file
  "fp" 'find-file-at-point
  "fr" 'counsel-recentf
  "fs" 'save-buffer

  "gc"  'magit-clone
  "gff" 'magit-find-file
  "gfc" 'magit-find-git-config-file
  "gfs" 'magit-stage-file
  "gi"  'magit-init
  "gl"  'magit-list-repositories
  "gs"  'magit-status

  "hf" 'describe-function
  "hF" 'describe-face
  "hv" 'describe-variable
  "hk" 'describe-key
  "hp" 'describe-package
  "qq" 'save-buffers-kill-emacs

  "sc" 'evil-surround-change
  "sd" 'evil-surround-delete
  "ss" 'evil-surround-region

  "v" 'er/expand-region
  "w" 'hydra-window/body

  "ys" 'youdao-dictionary-search-at-point
  "yp" 'youdao-dictionary-play-voice-at-point

  "SPC" 'execute-extended-command)

(when (featurep 'evil)
  (evil-global-set-key 'normal (kbd "<SPC>") 'creature-map)
  (evil-global-set-key 'motion (kbd "<SPC>") 'creature-map))

(provide 'init-keybindings)
