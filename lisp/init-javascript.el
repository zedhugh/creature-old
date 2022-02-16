;; -*- lexical-binding: t -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         JavaScript and TypeScript                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'init-elpa)
(require 'init-utils)
(require 'init-lsp)
(require 'init-flycheck)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  Packages                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(creature/require-package 'emmet-mode)
(creature/require-package 'json-mode)
(creature/require-package 'typescript-mode)
(creature/require-package 'prettier)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                 Functions                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun creature-jsx-setup ()
  "Enable `emmet-mode' in JSX file."
  (unless (creature-so-long-p)
    (emmet-mode))

  (setq-local js-indent-level 2
              emmet-expand-jsx-className? t))

(defun creature-emmet-expand-dwim ()
  "Expand use `emmet-mode' with right way."
  (interactive)
  (if (bound-and-true-p yas-minor-mode)
      (call-interactively 'emmet-expand-yas)
    (call-interactively 'emmet-expand-line)))

(defun creature-prettier-prettify ()
  "Call `prettier-prettify' without cursor moving."
  (save-excursion (prettier-prettify)))

(defun creature-prettier-hook-fn ()
  "Change prettier functions in `before-save-hook'."
  (remove-hook 'before-save-hook #'prettier-prettify 'local)
  (remove-hook 'before-save-hook #'creature-prettier-prettify 'local)

  (when (and prettier-mode prettier-version)
    (add-hook 'before-save-hook #'creature-prettier-prettify nil 'local))
  (when (string-suffix-p ".tsx" buffer-file-name t)
    (setq-local prettier-parsers '(typescript))))

(defun creature-prettier-setup ()
  "Enable `prettier-mode' selectively."

  (require 'prettier)

  (when (and buffer-file-name
             (not (prettier--in-node-modules-p))
             (not (string-suffix-p ".html" buffer-file-name t)))
    (prettier-mode)))

(defun creature-js/ts-setup ()
  "Config JavaScript and TypeScript but exclude JSON."
  (run-with-timer 0.2 nil
                  (lambda ()
                    (let ((so-long-p    (creature-so-long-p))
                          (remote-p     (creature-remote-file-p))
                          (json-p       (derived-mode-p 'json-mode)))
                      (unless so-long-p
                        (creature-prettier-setup))
                      (unless (or so-long-p remote-p json-p)
                        ;; (lsp-deferred)
                        ;; (flycheck-mode)
                        (eglot-ensure)
                        (flymake-mode-on)
                        )))))

(defun auto-switch-to-text-mode ()
  (when (> (line-number-at-pos (point-max)) 2000)
    (text-mode)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Connfigurations                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.[cm]?js\\'"  . js-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'"      . js-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.cfg\\'"      . json-mode))
(add-to-list 'auto-mode-alist '("\\.widget\\'"   . json-mode))
(add-to-list 'auto-mode-alist '("\\.eslintrc\\'" . json-mode))
(add-to-list 'interpreter-mode-alist '("node"    . js-mode))
(add-to-list 'interpreter-mode-alist '("nodejs"  . js-mode))

(add-hook 'json-mode-hook #'auto-switch-to-text-mode)

(with-eval-after-load 'emmet-mode
  (setq emmet-preview-default           nil
        emmet-self-closing-tag-style    " /")

  (define-key emmet-mode-keymap (kbd "TAB") #'creature-emmet-expand-dwim))

(with-eval-after-load 'js
  (setq js-chain-indent nil)
  ;; Use advice to avoid `creature-jsx-setup' be called more than once
  (advice-add 'js-jsx-enable :after #'creature-jsx-setup))

(add-hook 'js-mode-hook #'creature-js/ts-setup)
;; (add-hook 'js-mode-hook
;;           #'(lambda ()
;;               (unless (derived-mode-p 'json-mode)
;;                 (define-key js-mode-map (kbd "M-.") nil))))

(with-eval-after-load 'prettier
  (add-hook 'prettier-mode-hook #'creature-prettier-hook-fn))

(with-eval-after-load 'typescript-mode
  (setq typescript-indent-level 2))

(add-hook 'typescript-mode-hook #'creature-js/ts-setup)


(provide 'init-javascript)
