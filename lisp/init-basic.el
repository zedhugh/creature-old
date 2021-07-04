;; -*- lexical-binding: t -*-

(defconst creature-scratch-message
  (concat ";; Happy hacking "
          (or (user-login-name) "user")
          " - Emacs loves you.\n\n")
  "Customized initial scratch buffer message.")
(setq-default initial-scratch-message creature-scratch-message)

;; Encoding
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)

;; Don't show prompt when call function
(fset 'yes-or-no-p 'y-or-n-p)
(put 'erase-buffer 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disable nil)
(put 'narrow-to-region 'disabled nil)

;; Show trailing whitespace
(defun creature-show-trailing-whitespace ()
  "Show trailing whitespace."
  (set (make-local-variable 'show-trailing-whitespace) t))

(add-hook 'find-file-hook #'creature-show-trailing-whitespace)

;; Save minibuffer history
(savehist-mode)
(setq history-length                1000
      savehist-autosave-interval    60
      enable-recursive-minibuffers  t
      savehist-additional-variables '(mark-ring
                                      global-mark-ring
                                      search-ring
                                      regexp-search-ring
                                      extended-command-history))

;; Delete file directly
(setq delete-by-moving-to-trash t)

;; No backup file
(setq make-backup-files nil)

;; Auto save file
(setq auto-save-default t)
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; No lockfiles in Windows OS
(if creature/sys-win32p
    (setq create-lockfiles nil)
  (setq create-lockfiles t))

;; Disable bell
(setq visible-bell          nil
      ring-bell-function    'ignore)

;; Keep cursor at end of lines when prev
;; position of cursor is at the end.
;; Require line-move-visual is nil.
(setq track-eol         t
      line-move-visual  nil)

;; Do not show startup screen
(setq inhibit-splash-screen     t       ; no startup screen
      x-gtk-use-system-tooltips nil)    ; no gtk tooltips

;; Start server for emacsclient
(unless (featurep 'server) (require 'server))
(unless (server-running-p) (server-start))

;; Record cursor position for file
(save-place-mode)

;; Always use space for indentation
(setq-default tab-width         4
              indent-tabs-mode  nil)

;; Abbrev
;; (abbrev-mode)

;; (define-abbrev-table 'global-abbrev-table
;;   '(("8ms" "Microsoft")
;;     ("8dm" "document")))

;; (define-abbrev-table 'js-mode-abbrev-table
;;   '(("pi" "prettier-ignore")
;;     ("ednl" "eslint-disable-next-line")))


(provide 'init-basic)
