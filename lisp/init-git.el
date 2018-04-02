;;; init-git.el --- git

;;; Commentary:

;; git tools

;;; Code:

(use-package fill-column-indicator
  :init
  (add-hook 'git-commit-mode-hook 'fci-mode))

(use-package magit
  :init
  (evil-leader/set-key
    "gc"  'magit-clone
    "gff" 'magit-find-file
    "gfc" 'magit-find-git-config-file
    "gfs" 'magit-stage-file
    "gi"  'magit-init
    "gl"  'magit-list-repositories
    "gs"  'magit-status)
  (creature/which-key-declare-prefixes
   "gf" "git files"
   "g"  "gits"))

(use-package gitattributes-mode)
(use-package gitconfig-mode)
(use-package gitignore-mode)

;; (evil-magit-init)
(use-package evil-magic
  :init
  (add-hook 'magit-mode-hook 'evil-magit-init))

(provide 'init-git)
;;; init-git.el ends here
