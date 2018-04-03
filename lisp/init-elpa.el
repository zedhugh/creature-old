;;; Commentary:

;; initialize package config.

;;; Code:

(package-initialize)

(setq package-selected-packages nil)

(setq package-archives creature/elpa)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-defer t)
(setq use-package-always-ensure t)

(provide 'init-elpa)
