;; web-mode
(setq standard-indent 2)
(add-to-list 'auto-mode-alist '("\\.tpl\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(with-eval-after-load 'web-mode
  (setq web-mode-style-padding standard-indent)
  (setq web-mode-script-padding standard-indent)
  (setq web-mode-block-padding standard-indent)
  (setq web-mode-comment-style 1)

  ;; disable arguments|concatenation|calls lineup
  (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil)))

;; emmet mode
(defun creature/emmet-expand ()
  "Expand at right way."
  (interactive)
  (if (bound-and-true-p yas-minor-mode)
      (call-interactively 'emmet-expand-yas)
    (call-interactively 'emmet-expand-line)))

(evil-define-key 'insert emmet-mode-keymap
  (kbd "<tab>") 'creature/emmet-expand)
(evil-define-key 'emacs emmet-mode-keymap
  (kbd "<tab>") 'creature/emmet-expand)

(defun web-mode-setup ()
  (emmet-mode)
  (tern-mode)
  (set (make-local-variable 'company-backends)
       (push '(company-web-html company-css company-tern)
             company-backends)))

(add-hook 'web-mode-hook 'web-mode-setup)

(defun css-setup ()
  (emmet-mode 1)
  (setq css-indent-offset 2))
(add-hook 'css-mode-hook 'css-setup)

(provide 'init-web-mode)
