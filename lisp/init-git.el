;;; init-git.el --- git

;;; Commentary:

;; git tools

;;; Code:

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
 "g"  "gits")

(setq magit-revision-show-gravatars
      '("^Author:     " . "^Commit:     "))

(provide 'init-git)
;;; init-git.el ends here
