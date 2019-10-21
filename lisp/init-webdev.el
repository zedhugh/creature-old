;;; web-mode
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(with-eval-after-load 'web-mode
  ;; indent
  (setq web-mode-style-padding standard-indent)
  (setq web-mode-script-padding standard-indent)
  (setq web-mode-block-padding standard-indent)
  (setq web-mode-comment-style 1)

  ;; disable arguments|concatenation|calls lineup
  (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil)))

(setq emmet-preview-default t)
(setq emmet-self-closing-tag-style " /")

(add-hook 'css-mode-hook 'emmet-mode)

(defun web-mode-setup ()
  (emmet-mode)
  (dolist (check '(jsx-tide tsx-tide typescript-tide))
    (setq-local flycheck-checkers (delete check flycheck-checkers)))
  (make-local-variable 'company-backends)
  (add-to-list 'company-backends '(company-web-html company-css company-lsp))
  (add-yas))

(add-hook 'web-mode-hook 'web-mode-setup)

;;; javascript
(add-to-list 'auto-mode-alist '("\\.js\\'"      . js-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'"     . js-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.cfg\\'"     . json-mode))
(add-to-list 'auto-mode-alist '("\\.eslint"     . json-mode))
(add-to-list 'auto-mode-alist '("\\.widget\\'"  . json-mode))
(add-to-list 'interpreter-mode-alist '("node"   . js-mode))
(add-to-list 'interpreter-mode-alist '("nodejs" . js-mode))
(add-to-list 'magic-mode-alist
             '("import\s+.*+\s+from\s+['\"]react['\"]"  . js-jsx-mode))

;; indentation
(with-eval-after-load 'js
  (setq js-chain-indent nil))

;; enable emmet mode when edit jsx file
(defun jsx-setup ()
  "Config for jsx."
  (emmet-mode)
  (set (make-local-variable 'js-indent-level) 2)
  (set (make-local-variable 'emmet-expand-jsx-className?) t))
(add-hook 'js-jsx-mode-hook 'jsx-setup)

(add-hook 'js-mode-hook
          #'(lambda ()
              (unless (derived-mode-p 'json-mode)
                (define-key js-mode-map (kbd "M-.") nil))))

(provide 'init-webdev)
