;; -*- coding: utf-8; lexical-binding: t; -*-

(add-hook 'css-mode-hook 'emmet-mode)

(with-eval-after-load 'emmet-mode
  (setq emmet-preview-default t)
  (setq emmet-self-closing-tag-style " /")

  (defun creature/emmet-expand ()
    "Expand at right way."
    (interactive)
    (if (bound-and-true-p yas-minor-mode)
        (call-interactively 'emmet-expand-yas)
      (call-interactively 'emmet-expand-line)))

  (define-key emmet-mode-keymap (kbd "TAB") 'creature/emmet-expand))

;; (add-to-list 'auto-mode-alist '("\\.html\\'"    . web-mode))
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
    (make-local-variable 'company-backends)
    (emmet-mode)
    (when (and (fboundp 'flycheck-add-mode)
               (member web-mode-content-type '("typescript" "jsx" "javascript")))
      (flycheck-add-mode 'javascript-eslint 'web-mode))
    (creature/vue-indent)
    (creature/tsx-quote))

  (add-hook 'web-mode-hook 'web-mode-setup)

  (creature/set-keys web-mode-map
                     "C-M-b" #'sp-backward-sexp
                     "C-M-f" #'sp-forward-sexp))

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

(add-to-list 'auto-mode-alist '("\\.m?js\\'"        . js-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'"         . js-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.cfg\\'"         . json-mode))
(add-to-list 'auto-mode-alist '("\\.widget\\'"      . json-mode))
(add-to-list 'auto-mode-alist '("\\.eslintrc\\'"    . json-mode))
(add-to-list 'interpreter-mode-alist '("node"       . js-mode))
(add-to-list 'interpreter-mode-alist '("nodejs"     . js-mode))

;; prettier-mode
(with-eval-after-load 'prettier
  (defun creature/prettier-prettify ()
    (save-excursion (prettier-prettify)))

  (defun creature/prettier-hook-fn ()
    (remove-hook 'before-save-hook #'prettier-prettify 'local)
    (remove-hook 'before-save-hook #'creature/prettier-prettify 'local)

    (when (and prettier-mode prettier-version)
      (add-hook 'before-save-hook #'creature/prettier-prettify nil 'local)))

  (add-hook 'prettier-mode-hook #'creature/prettier-hook-fn)

  (defun creature/prettier-ignore-mode-fn ()
    (let ((filename (buffer-file-name)))
      (or (not filename)
          (string-suffix-p ".html" filename t)
          (prettier--in-node-modules-p))))

  (setq prettier-mode-ignore-buffer-function #'creature/prettier-ignore-mode-fn
        prettier-web-mode-content-type-parsers
        '((nil html)
          ("javascript" . prettier--guess-js-ish)
          ("jsx" typescript)
          ("typescript" typescript)
          ("css" css)
          ("json" json json5)
          ("markdown" markdown)
          ("ruby" ruby)
          ("sql" postgresql))))

(defun creature/prettier-setup ()
  (let* ((file-name (buffer-file-name))
         (major-mode (assoc-default file-name auto-mode-alist #'string-match)))
    (when (provided-mode-derived-p major-mode 'web-mode 'css-mode 'js-mode 'typescript-mode)
      (global-prettier-mode)
      (remove-hook 'find-file-hook #'creature/prettier-setup))))

(add-hook 'find-file-hook #'creature/prettier-setup)
(run-with-idle-timer
 2 nil
 (lambda ()
   (unless global-prettier-mode
     (global-prettier-mode))))

(defun creature/setup-typescript ()
  (make-local-variable 'company-backends)
  (set 'company-backends
       '((company-capf company-dabbrev company-web-html company-css)
         (company-dabbrev-code company-gtags company-etags company-keywords))))

;; (add-hook 'typescript-mode-hook #'creature/setup-typescript)

(with-eval-after-load 'typescript-mode
  (setq typescript-indent-level 2))

(provide 'init-webdev)
