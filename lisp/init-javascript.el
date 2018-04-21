(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node"   . js2-mode))
(add-to-list 'interpreter-mode-alist '("nodejs" . js2-mode))
(add-to-list 'magic-mode-alist
             '("import\s+.*+\s+from\s+['\"]react['\"]" . js2-jsx-mode))

(add-to-list 'auto-mode-alist '("\\.cfg\\'"    . json-mode))
(add-to-list 'auto-mode-alist '("\\.widget\\'" . json-mode))

(setq js-indent-level 2)
(setq js-switch-indent-offset 2)

;; tern config
(with-eval-after-load 'tern
  (add-to-list 'tern-command "--no-port-file" 'append))

(add-hook 'js2-mode-hook 'tern-mode)

;; company tern
(defun add-tern ()
  "Add tern to company backends."
  (set (make-local-variable 'company-backends)
       (push 'company-tern company-backends)))
(add-hook 'js2-mode-hook 'add-tern)

;; enable emmet mode when edit jsx file
(defun emmet-setup-for-jsx ()
  "Emmet config for jsx."
  (emmet-mode)
  (set (make-local-variable 'emmet-expand-jsx-className?) t))
(add-hook 'js2-jsx-mode-hook 'emmet-setup-for-jsx)

(provide 'init-javascript)
