;; -*- coding: utf-8; lexical-binding: t; -*-

(creature/install-packages
  '(web-mode
    emmet-mode
    company-web
    json-mode
    typescript-mode
    prettier))

(with-eval-after-load 'emmet-mode
  (setq emmet-preview-default t)
  (setq emmet-self-closing-tag-style " /")

  (add-hook 'css-mode-hook 'emmet-mode)

  (defun creature/emmet-expand ()
    "Expand at right way."
    (interactive)
    (if (bound-and-true-p yas-minor-mode)
        (call-interactively 'emmet-expand-yas)
      (call-interactively 'emmet-expand-line)))

  (define-key emmet-mode-keymap (kbd "TAB") 'creature/emmet-expand))

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
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))

  (defun creature/vue-indent ()
    (when (string-suffix-p ".vue" (buffer-name) t)
      (setq-local web-mode-style-padding 0
                  web-mode-script-padding 0
                  web-mode-block-padding 0)))

  (defun creature/tsx-quote ()
    (when (string-suffix-p ".tsx" (buffer-file-name) t)
      (set (make-local-variable 'emmet-expand-jsx-className?) t)
      (setq web-mode-enable-auto-quoting nil)
      (setq web-mode-auto-quote-style 2)))

  (defun web-mode-setup ()
    (emmet-mode)
    (dolist (check '(jsx-tide tsx-tide typescript-tide))
      (setq-local flycheck-checkers (delete check flycheck-checkers)))
    (make-local-variable 'company-backends)
    (add-to-list 'company-backends '(company-web-html company-css))
    (when (member web-mode-content-type '("typescript" "jsx" "javascript"))
      (flycheck-add-mode 'javascript-eslint 'web-mode))
    (creature/vue-indent)
    (creature/tsx-quote)
    (creature/company-add-yas))

  (add-hook 'web-mode-hook 'web-mode-setup)


  (when (featurep 'smartparens)
    (creature/set-keys web-mode-map
      "C-M-b" #'sp-backward-sexp
      "C-M-f" #'sp-forward-sexp)))

;;; javascript
(with-eval-after-load 'js
  (setq js-chain-indent nil))

;; enable emmet mode when edit jsx file
(defun creature/jsx-setup ()
  "Config for jsx."
  (emmet-mode)
  (set (make-local-variable 'js-indent-level) 2)
  (set (make-local-variable 'emmet-expand-jsx-className?) t))
(add-hook 'js-jsx-mode-hook 'creature/jsx-setup)
(advice-add 'js-jsx-enable :after 'creature/jsx-setup)

(add-hook 'js-mode-hook
          #'(lambda ()
              (unless (derived-mode-p 'json-mode)
                (define-key js-mode-map (kbd "M-.") nil))))

(add-to-list 'auto-mode-alist '("\\.js\\'"          . js-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'"         . js-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.cfg\\'"         . json-mode))
(add-to-list 'auto-mode-alist '("\\.widget\\'"      . json-mode))
(add-to-list 'auto-mode-alist '("\\.eslintrc\\'"    . json-mode))
(add-to-list 'interpreter-mode-alist '("node"       . js-mode))
(add-to-list 'interpreter-mode-alist '("nodejs"     . js-mode))

;; prettier-mode
(dolist (hook '(typescript-mode-hook
                js-mode-hook
                web-mode-hook
                css-mode-hook
                scss-mode-hook
                less-css-mode-hook))
  (add-hook hook 'prettier-mode))
(with-eval-after-load 'prettier
  (setq prettier-web-mode-content-type-parsers
        '((nil html)
          ("javascript" . prettier--guess-js-ish)
          ("jsx" typescript)
          ("typescript" typescript)
          ("css" css)
          ("json" json json5)
          ("markdown" markdown)
          ("ruby" ruby)
          ("sql" postgresql))))

(provide 'init-webdev)
