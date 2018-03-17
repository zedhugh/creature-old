;;; init-org.el --- config about org mode

;;; Commentary:

;; all configuration for org mode.

;;; Code:

(require 'org)
(require 'init-env)
(setq org-preview-latex-default-process 'dvisvgm)
(setq org-preview-latex-image-directory
      (expand-file-name "ltximg/" creature-cache))

(provide 'init-org)
;;; init-org.el ends here
