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
                web-mode-enable-auto-quoting    nil
                js-indent-level                 2)))

(defun creature-tsx-emmet ()
  "Deal .tsx file as jsx."
  (when (string-suffix-p ".tsx" buffer-file-name t)
    (make-local-variable 'emmet-jsx-major-modes)
    (push major-mode emmet-jsx-major-modes)))

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
                        (eglot-ensure)
                        (flymake-mode-on)
                        )))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               Configurations                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'"  . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.tsx\\'"  . web-mode))

(with-eval-after-load 'web-mode
  ;; disable indentation when yanking
  (setq web-mode-enable-auto-indentation nil)

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
(add-hook 'emmet-mode-hook #'creature-tsx-emmet)


(provide 'init-web-mode)
