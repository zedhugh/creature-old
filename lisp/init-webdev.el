;;; init-webdev.el --- web development

;;; COmmentary:

;; web frontend development config

;;; Code:

;; web-mode
(add-to-list 'auto-mode-alist '("\\.tpl\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node"   . js2-mode))
(add-to-list 'interpreter-mode-alist '("nodejs" . js2-mode))
(if sys/win32p
    (setq js2-basic-offset 4)
  (setq js2-basic-offset 2)
  (setq js-switch-indent-offset js2-basic-offset))

(add-to-list 'auto-mode-alist '("\\.cfg\\'"    . json-mode))
(add-to-list 'auto-mode-alist '("\\.widget\\'" . json-mode))

;; emmet mode
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
  (kbd "<tab>") 'creature/emmet-expand)

;; company-web
(defun add-company-web-backend ()
  "Add company-web to company backends."
  (set (make-local-variable 'company-backends)
       (push 'company-web-html company-backends)))
(add-hook 'web-mode-hook 'add-company-web-backend)
(add-hook 'js2-jsx-mode-hook 'add-company-web-backend)

;; tern config
(add-hook 'js2-mode-hook 'tern-mode)
(with-eval-after-load 'tern
  (add-to-list 'tern-command "--no-port-file" 'append)  )

;; company tern
(defun add-tern ()
  "Add tern to company backends."
  (set (make-local-variable 'company-backends)
       (push 'company-tern company-backends)))
(add-hook 'js2-mode-hook 'add-tern)
(add-hook 'web-mode-hook 'add-tern)

(provide 'init-webdev)
;;; init-webdev.el ends here
