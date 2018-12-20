(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-;") 'iedit-mode)
(global-set-key (kbd "s-v") 'clipboard-yank)
(global-set-key (kbd "s-c") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-M-\\") 'creature/indent-region-or-buffer)

;;; dired
(with-eval-after-load 'dired
  (creature/set-keys dired-mode-map
    "K" 'dired-narrow
    "SPC" 'creature-map
    "C-x C-q" 'creature/dired-toggle-read-only))
(with-eval-after-load 'wdired
  (creature/set-keys wdired-mode-map
    "C-c ESC" 'creature/wdired-exit
    "C-c C-k" 'creature/wdired-exit
    "C-c C-c" 'creature/wdired-finish-edit))

;;; company
(define-key company-active-map (kbd "C-n")
  #'company-complete-common-or-cycle)
(define-key company-active-map (kbd "C-p")
  (defun creature/company-select-prev ()
    (interactive)
    (company-complete-common-or-cycle -1)))

(with-eval-after-load 'paredit-everywhere
  ;; (define-key paredit-mode-map (kbd ";") nil)
  (define-key paredit-everywhere-mode-map (kbd "C-k") 'paredit-kill)
  (define-key paredit-everywhere-mode-map (kbd "C-d") 'paredit-forward-delete))

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

;;; projectile
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;;; mwim
(global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
(global-set-key (kbd "C-e") 'mwim-end-of-code-or-line)

;;; org mode
;; better behavior for "RET" key
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "RET") 'org-return-indent))

(define-prefix-command 'creature-map)
(global-set-key (kbd "S-<SPC>") 'creature-map)
(define-key special-mode-map (kbd "S-<SPC>") 'creature-map)

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

;;; kill buffer when quit-window.
(define-key special-mode-map
  [remap quit-window]
  'quit-window-and-kill-buffer)
(define-key global-map [remap list-buffers] 'ibuffer)
(define-key package-menu-mode-map
  [remap quit-window]
  'quit-window-and-kill-buffer)
(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map
    [remap quit-window]
    'quit-window-and-kill-buffer))
(with-eval-after-load 'magit-status
  (define-key magit-status-mode-map
    [remap magit-mode-bury-buffer]
    'quit-window-and-kill-buffer))
(with-eval-after-load 'magit-mode
  (define-key magit-mode-map
    [remap magit-mode-bury-buffer]
    'quit-window-and-kill-buffer))
(with-eval-after-load 'magit-log
  (define-key magit-log-mode-map
    [remap magit-log-bury-buffer]
    'quit-window-and-kill-buffer))

(with-eval-after-load 'emmet-mode
  (define-key emmet-mode-keymap (kbd "<tab>") 'creature/emmet-expand))

(when (featurep 'evil)
  (evil-global-set-key 'normal (kbd "<SPC>") 'creature-map)
  (evil-global-set-key 'motion (kbd "<SPC>") 'creature-map))

(provide 'init-keybindings)
