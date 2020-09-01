;;; web-mode
(add-to-list 'auto-mode-alist '("\\.html\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'"     . web-mode))

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

(defun creature/vue-indent ()
  (when (string-suffix-p ".vue" (buffer-name) t)
    (setq-local web-mode-style-padding 0
                web-mode-script-padding 0
                web-mode-block-padding 0)))

(defun creature/tsx-quote ()
  (when (string-suffix-p ".tsx" (buffer-name) t)
    (setq web-mode-enable-auto-quoting nil)
    (setq web-mode-auto-quote-style 2)))

(defun web-mode-setup ()
  (emmet-mode)
  (dolist (check '(jsx-tide tsx-tide typescript-tide))
    (setq-local flycheck-checkers (delete check flycheck-checkers)))
  (make-local-variable 'company-backends)
  (add-to-list 'company-backends '(company-web-html company-css))
  (creature/vue-indent)
  (creature/tsx-quote)
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
(advice-add 'js-jsx-enable :after 'jsx-setup)

(add-hook 'js-mode-hook
          #'(lambda ()
              (unless (derived-mode-p 'json-mode)
                (define-key js-mode-map (kbd "M-.") nil))))

(provide 'init-webdev)
