(global-set-key (kbd "C-s") 'swiper-isearch-thing-at-point)
(global-set-key (kbd "s-v") 'clipboard-yank)
(global-set-key (kbd "s-c") 'clipboard-kill-ring-save)
(global-set-key (kbd "DEL") 'backward-delete-char-untabify)
(global-set-key (kbd "C-M-\\") 'creature/indent-region-or-buffer)

(defun creature/escape-insert-backquote ()
  "Escape key in Emacs is useless.
Replace by `backquote' is a better way with my mini keyboard."
  (global-set-key (kbd "<escape>") (kbd "`")))
(creature/escape-insert-backquote)

;;; company
(define-key company-active-map (kbd "C-n")
  #'company-complete-common-or-cycle)
(define-key company-active-map (kbd "C-p")
  (defun creature/company-select-prev ()
    (interactive)
    (company-complete-common-or-cycle -1)))
(define-key company-mode-map (kbd "C-'") #'company-files)

;; (with-eval-after-load 'paredit-everywhere
;;   ;; (define-key paredit-mode-map (kbd ";") nil)
;;   (define-key paredit-everywhere-mode-map (kbd "C-k") 'paredit-kill)
;;   (define-key paredit-everywhere-mode-map (kbd "C-d") 'paredit-forward-delete)
;;   (define-key paredit-everywhere-mode-map (kbd "DEL") 'paredit-backward-delete))

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

;;; mwim
(global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
(global-set-key (kbd "C-e") 'mwim-end-of-code-or-line)

;;; org mode
;; better behavior for "RET" key
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "RET") 'org-return-indent))

(define-prefix-command 'creature-map)
(global-set-key (kbd creature/prefix-key) 'creature-map)
;; (define-key special-mode-map (kbd creature/prefix-key) 'creature-map)

(creature/set-keys creature-map
  ;; evil-leader/set-key
  "bb" 'switch-to-buffer
  "bd" 'kill-current-buffer
  "be" 'eval-buffer

  "cl" 'evilnc-comment-or-uncomment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs

  "el" 'creature/toggle-flycheck-error-list
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

(creature/which-key-declare-prefixes creature/prefix-key
  "b"  "buffer"
  "c"  "comments"
  "e"  "errors"
  "el" "lines"
  "ex" "error message"
  "f"  "files"
  "g"  "magit"
  "gf" "magit files"
  "h"  "help"
  "q"  "quit option"
  "s"  "evil surround"
  "y"  "youdao"
  "yp" "pronunciation"
  "ys" "translate")

;;; kill buffer when quit-window.
(define-key global-map [remap list-buffers] 'ibuffer)

(with-eval-after-load 'emmet-mode
  (define-key emmet-mode-keymap (kbd "TAB") 'creature/emmet-expand))

(with-eval-after-load 'projectile
  (global-set-key (kbd "C-c p") #'projectile-command-map))

(provide 'init-keybindings)
