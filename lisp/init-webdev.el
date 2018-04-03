;;; init-webdev.el --- web development

;;; COmmentary:

;; web frontend development config

;;; Code:

;; web-mode
(use-package web-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.tpl\\'"  . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode)))

;; js2-mode
(use-package js2-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . js2-mode))
  (add-to-list 'interpreter-mode-alist '("node"   . js2-mode))
  (add-to-list 'interpreter-mode-alist '("nodejs" . js2-mode))
  (if sys/win32p
      (setq js2-basic-offset 4)
    (setq js2-basic-offset 2)
    (setq js-switch-indent-offset js2-basic-offset)))

(use-package json-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.cfg\\'"    . json-mode))
  (add-to-list 'auto-mode-alist '("\\.widget\\'" . json-mode)))

;; emmet mode
(use-package emmet-mode
  :init
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook 'emmet-mode)
  (add-hook 'js2-jsx-mode-hook 'emmet-mode)

  (defun creature/emmet-expand ()
    "Expand at right way."
    (interactive)
    (if (bound-and-true-p yas-minor-mode)
        (call-interactively 'emmet-expand-yas)
      (call-interactively 'emmet-expand-line)))

  (evil-define-key 'insert emmet-mode-keymap
    (kbd "Tab") 'creature/emmet-expand)
  (evil-define-key 'insert emmet-mode-keymap
    (kbd "<tab>") 'creature/emmet-expand)
  (evil-define-key 'emacs emmet-mode-keymap
    (kbd "Tab") 'creature/emmet-expand)
  (evil-define-key 'emacs emmet-mode-keymap
    (kbd "<tab>") 'creature/emmet-expand))

;; company-web
(use-package company-web
  :init
  (defun add-company-web-backend ()
    "Add company-web to company backends."
    (set (make-local-variable 'company-backends)
         (push 'company-web-html company-backends)))
  (add-hook 'web-mode-hook 'add-company-web-backend)
  (add-hook 'js2-jsx-mode-hook 'add-company-web-backend))

;; tern config
(use-package tern
  :init
  (add-hook 'js2-mode-hook 'tern-mode)
  :config
  (add-to-list 'tern-command "--no-port-file" 'append))

(use-package company-tern
  :init
  ;; company tern
  (defun add-tern ()
    "Add tern to company backends."
    (set (make-local-variable 'company-backends)
         (push 'company-tern company-backends)))
  (add-hook 'js2-mode-hook 'add-tern))

;; yasnippet
(use-package yasnippet
  :init
  (defun add-yas ()
    "Add yasnippet to company popup menu."
    (let ((backends company-backends))
      (set (make-local-variable 'company-backends) nil)
      (dolist (backend backends)
        (add-to-list 'company-backends
                     (cons backend
                           '(:with company-yasnippet))
                     'append))))
  (add-hook 'company-mode-hook 'yas-minor-mode)
  (add-hook 'yas-minor-mode-hook 'add-yas))

(use-package yasnippet-snippets)

(provide 'init-webdev)
;;; init-webdev.el ends here
