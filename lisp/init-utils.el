;;; init-utils.el --- utils

;;; Commentary:

;;; Code:

(require 'init-elpa)
(require-package 'which-key)
(require-package 'window-numbering)
(require-package 'smooth-scrolling)

;; which-key
(which-key-mode)
(setq which-key-idle-delay 0.4)

(window-numbering-mode)
(smooth-scrolling-mode)

(provide 'init-utils)
;;; init-utils.el ends here
