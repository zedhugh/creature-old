;; -*- lexical-binding: t -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  JSX/TSX                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'init-elpa)
(require 'init-utils)
(require 'init-lsp)
(require 'init-flycheck)
(require 'init-javascript)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  Packages                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(creature/require-package 'web-mode)
(creature/require-package 'emmet-mode)
(creature/require-package 'company-web)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                 Functions                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun creature-vue-indent ()
  "Indentation config for VUE file."
  (when (string-suffix-p ".vue" buffer-file-name t)
    (setq-local web-mode-block-padding  0
                web-mode-style-padding  0
                web-mode-script-padding 0)))

(defun creature-tsx-quote ()
  "Quote configuration for TSX file."
  (when (string-suffix-p ".tsx" buffer-file-name t)
    (setq-local web-mode-auto-quote-style       2
                web-mode-enable-auto-quoting    nil)))

(defun creature-web-mode-setup ()
  "Configuration collections for `web-mode'."
  (creature-tsx-quote)
  (creature-vue-indent)

  (run-with-timer 0.2 nil
                  (lambda ()
                    (let ((so-long-p    (creature-so-long-p))
                          (remote-p     (creature-remote-file-p)))
                      (unless so-long-p
                        (emmet-mode)
                        (creature-prettier-setup))
                      (unless (or so-long-p remote-p)
                        (lsp-deferred)
                        (flycheck-mode))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               Configurations                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'"  . web-mode))

(with-eval-after-load 'web-mode
  ;; Indentation
  (setq web-mode-comment-style  1
        web-mode-block-padding  standard-indent
        web-mode-style-padding  standard-indent
        web-mode-script-padding standard-indent)

  ;; Disable arguments|concatenation|calls lineup
  (add-to-list 'web-mode-indentation-params '("lineup-args"    . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-calls"   . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil)))

(add-hook 'web-mode-hook #'creature-web-mode-setup)


(provide 'init-web-mode)
