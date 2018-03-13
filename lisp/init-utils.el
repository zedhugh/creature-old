;;; init-utils.el --- utils

;;; Commentary:

;;; Code:

(require 'init-elpa)
(require-package 'which-key)
(require-package 'window-numbering)
(require-package 'smooth-scrolling)

(which-key-mode)
(window-numbering-mode)
(smooth-scrolling-mode)

(provide 'init-utils)
;;; init-utils.el ends here
