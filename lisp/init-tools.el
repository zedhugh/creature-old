;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'init-elpa)

;;; ediff
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(creature/require-package 'pinentry)

;; gpg config
(defun creature/kill-gpg-agent ()
  "Kill `gpg-agent' for security when Emacs be killed."
  (when (and (bound-and-true-p epg-gpgconf-program)
             (executable-find epg-gpgconf-program))
    (start-process "" nil epg-gpgconf-program "--kill" "gpg-agent")))
(add-hook 'kill-emacs-hook #'creature/kill-gpg-agent)

(setq epg-pinentry-mode 'loopback)

(creature/require-package 'keyfreq)

(keyfreq-mode)
(keyfreq-autosave-mode)
(setq keyfreq-file
      (expand-file-name ".keyfreq" creature/cache-dir))
(setq keyfreq-excluded-commands
      '(backward-char
        backward-sexp
        backward-delete-char-untabify
        backward-kill-word
        backward-word
        dired-next-line
        electric-pair-delete-pair
        end-of-buffer
        forward-char
        forward-word
        forward-sexp
        just-one-space
        keyboard-quit
        kill-current-buffer
        kill-word
        minibuffer-keyboard-quit
        next-line
        newline
        previous-line
        quit-window
        save-buffer
        self-insert-command
        set-mark-command
        toggle-input-method
        yank

        evil-append
        evil-backward-char
        evil-backward-word-begin
        evil-delete
        evil-forward-char
        evil-forward-word-begin
        evil-forward-word-end
        evil-insert
        evil-next-line
        evil-normal-state
        evil-open-below
        evil-previous-line
        evil-replace
        evil-scroll-down
        evil-scroll-page-down
        evil-visual-line
        mwim-beginning-of-code-or-line
        mwim-end-of-code-or-line

        awesome-pair-double-quote
        awesome-pair-equal
        awesome-pair-forward-delete
        awesome-pair-kill
        awesome-pair-open-bracket
        awesome-pair-open-curly
        awesome-pair-open-round
        awesome-pair-space

        winum-select-window-1
        winum-select-window-2

        symbol-overlay-jump-next
        symbol-overlay-jump-prev

        counsel-find-file
        counsel-recentf

        creature/awesome-pair-kill
        creature/emmet-expand
        creature/indent-region-or-buffer))

;;; rime
(creature/require-package 'rime)

(setq rime-emacs-module-header-root
      (if (= emacs-major-version 27)
          "/usr/include/emacs-27"
        "/usr/include/emacs-28-vcs"))
(setq default-input-method "rime")

(setq default-cursor-color "#ffffff")
(setq input-method-cursor-color "#ff0000")

(defun change-cursor-color-on-input-method ()
  "Set cursor color depending on whether an input method is used or not."
  (when (featurep 'rime)
    (set-cursor-color (if (and (rime--should-enable-p)
                               (not (rime--should-inline-ascii-p))
                               current-input-method)
                          input-method-cursor-color
                        default-cursor-color))))

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

  (add-hook 'post-command-hook #'change-cursor-color-on-input-method)

  (define-key rime-mode-map (kbd "M-i") 'rime-force-enable)
  (define-key rime-active-mode-map (kbd "M-i") 'rime-inline-ascii))

;;; magit
(creature/require-package 'forge)
(creature/require-package 'git-modes)

(with-eval-after-load 'magit
  ;; (require 'forge)

  ;; pinentry for prompting password of gpg when sign git commit
  (condition-case nil
      (pinentry-start)
    (error nil))

  (setq magit-revision-show-gravatars
        '("^Author:     " . "^Commit:     ")))

(creature/set-keys creature-map
                   "gc"  'magit-clone
                   "gff" 'magit-find-file
                   "gfc" 'magit-find-git-config-file
                   "gfs" 'magit-stage-file
                   "gi"  'magit-init
                   "gl"  'magit-list-repositories
                   "gs"  'magit-status)

(creature/require-package 'rg)
(add-hook 'emacs-startup-hook #'rg-enable-default-bindings)

(creature/require-package 'projectile)
(creature/require-package 'counsel-projectile)

(with-eval-after-load 'projectile
  (global-set-key (kbd "C-c p") #'projectile-command-map))

(projectile-mode)

(creature/require-package 'avy)

(define-key global-map (kbd "M-g w") #'avy-goto-word-1)
(define-key global-map (kbd "M-g M-w") #'avy-goto-word-1)

(creature/set-keys creature-map
                   "jl" 'avy-goto-line
                   "jw" 'avy-goto-word-1)

(creature/require-package 'undo-tree)

(global-undo-tree-mode)
(setq undo-tree-history-directory-alist
      `((".*\\'" . ,(file-name-concat creature/cache-dir "undo-tree"))))

(creature/require-package 'youdao-dictionary)

(creature/set-keys creature-map
                   "ys" 'youdao-dictionary-search-at-point
                   "yp" 'youdao-dictionary-play-voice-at-point)

(creature/require-package 'expand-region)

(creature/set-keys creature-map "v" 'er/expand-region)

(when (eq system-type 'darwin)
  (creature/require-package 'exec-path-from-shell)
  (exec-path-from-shell-initialize))


(provide 'init-tools)
