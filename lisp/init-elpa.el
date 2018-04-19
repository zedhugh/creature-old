;;; Commentary:

;; initialize package config.

;;; Code:

(if (< emacs-major-version 27)
    (package-initialize)
  (unless (file-exists-p
           (expand-file-name "elpa" user-emacs-directory))
    (package-initialize)))

(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(setq package-selected-packages nil)

(setq package-archives creature/elpa-cn)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-defer t)
(setq use-package-always-ensure t)

(provide 'init-elpa)
