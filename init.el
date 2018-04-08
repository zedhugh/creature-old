;; init.el --- entry

;;; Commentary:

;; Entry of Emacs config.
;; add load path for this way beacuse I don't want
;; make it's too long pre line.
;; core thought for this config:
;;   1. use evil keybindings.
;;   2. use "which-key" to prompt command.
;;   3. do not use "use-package", but origin elisp.
;;   4. organize config with function.

;;; Code:

;; (package-initialize)

(defconst creature-dir
  (file-name-directory (or load-file-name buffer-file-name))
  "Root directory of creature.")

(add-to-list 'load-path
             (expand-file-name "lisp" creature-dir))

(add-hook 'after-init-hook
          (lambda ()
            (require 'init-env)
            (require 'init-elpa)
            (require 'init-basic)
            (require 'init-defuns)
            (require 'init-evil)
            (require 'init-utils)
            (require 'init-company)
            (require 'init-ivy)
            (require 'init-git)
            (require 'init-webdev)
            (require 'init-org)
            (require 'init-keybindings)

            ;; load custom file
            (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
            (when (file-exists-p custom-file)
              (load custom-file))))

;; (provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company-tern tern youdao-dictionary yasnippet-snippets window-numbering which-key web-mode use-package unicode-fonts spacemacs-theme smooth-scrolling smex smartparens s rainbow-identifiers pyim popwin page-break-lines org-pomodoro mwim json-mode js2-mode ivy-rich hungry-delete gitignore-mode gitconfig-mode gitattributes-mode flycheck fill-column-indicator expand-region evil-surround evil-nerd-commenter evil-matchit evil-magit evil-leader emmet-mode dash-functional counsel company-web all-the-icons-dired)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
