;;; init-webdev.el --- web development

;;; COmmentary:

;; web frontend development config

;;; Code:

(require 'init-elpa)
(require-package 'web-mode)
(require-package 'js2-mode)
(require-package 'json-mode)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tpl\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

;; js2-mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . js2-mode))

(require 'json-mode)
(add-to-list 'auto-mode-alist '("\\.cfg\\'"    . json-mode))
(add-to-list 'auto-mode-alist '("\\.widget\\'" . json-mode))

(provide 'init-webdev)
;;; init-webdev.el ends here
