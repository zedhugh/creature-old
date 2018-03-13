;;; init-elpa.el --- packages

;;; Commentary:

;; initialize package config.
;; defun function `require-package' to install package.

;;; Code:

(require 'package)
(package-initialize)

(setq package-selected-packages nil)

(setq package-archives
      '(("gnu-cn"   . "https://elpa.emacs-china.org/gnu/")
        ("org-cn"   . "https://elpa.emacs-china.org/org/")
        ("melpa-cn" . "https://elpa.emacs-china.org/melpa/")))

(defun require-package (package &optional min-version no-refresh)
  "Install if PACKAGE is not installed with NO-REFRESH.
MIN-VERSION is same as`package-installed-p'."
  (if (package-installed-p package min-version)
      nil
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(provide 'init-elpa)
;;; init-elpa.el ends here
