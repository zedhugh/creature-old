;;; init-webdev.el --- web development

;;; COmmentary:

;; web frontend development config

;;; Code:

(require 'init-elpa)
(require-package 'web-mode)
(require-package 'js2-mode)
(require-package 'json-mode)
(require-package 'emmet-mode)
(require-package 'company-web)
(require-package 'tern)
(require-package 'company-tern)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tpl\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

;; js2-mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node"   . js2-mode))
(add-to-list 'interpreter-mode-alist '("nodejs" . js2-mode))
(require 'init-env)
(if sys/win32p
    (setq js2-basic-offset 4)
  (setq js2-basic-offset 2))

(require 'json-mode)
(add-to-list 'auto-mode-alist '("\\.cfg\\'"    . json-mode))
(add-to-list 'auto-mode-alist '("\\.widget\\'" . json-mode))

;; emmet mode
(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'js2-jsx-mode-hook 'emmet-mode)
(require 'evil)
(evil-define-key 'insert emmet-mode-keymap
  (kbd "Tab") 'emmet-expand-line)
(evil-define-key 'insert emmet-mode-keymap
  (kbd "<tab>") 'emmet-expand-line)
(evil-define-key 'emacs emmet-mode-keymap
  (kbd "Tab") 'emmet-expand-line)
(evil-define-key 'emacs emmet-mode-keymap
  (kbd "<tab>") 'emmet-expand-line)

;; company-web
(require 'init-defuns)
(add-hook 'web-mode-hook 'add-company-web-backend)
(add-hook 'js2-jsx-mode-hook 'add-company-web-backend)

;; tern config
(require 'tern)
(add-to-list 'tern-command "-no-port-file" 'append)

;; company tern
(add-hook 'js2-mode-hook 'tern-mode)
(add-hook 'js2-mode-hook 'add-tern)


(provide 'init-webdev)
;;; init-webdev.el ends here
