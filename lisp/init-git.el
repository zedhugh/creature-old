;;; init-git.el --- git

;;; Commentary:

;; git tools

;;; Code:

(require'init-elpa)
(require-package 'fill-column-indicator)
(require-package 'magit)
(require-package 'gitattributes-mode)
(require-package 'gitconfig-mode)
(require-package 'gitignore-mode)
(require-package 'evil-magit)

(add-hook 'git-commit-mode-hook 'fci-mode)

(evil-leader/set-key
  "gc"  'magit-clone
  "gff" 'magit-find-file
  "gfc" 'magit-find-git-config-file
  "gfs" 'magit-stage-file
  "gi"  'magit-init
  "gl"  'magit-list-repositories
  "gs"  'magit-status)

(require 'init-defuns)
(creature/which-key-declare-prefixes
 "gf" "git files"
 "g"  "gits")

;; (evil-magit-init)
(add-hook 'magit-mode-hook 'evil-magit-init)

(provide 'init-git)
;;; init-git.el ends here
