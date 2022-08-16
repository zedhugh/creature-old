;; -*- lexical-binding: t -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               CSS/LESS/SASS                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'init-elpa)
(require 'init-utils)
(require 'init-lsp)
(require 'init-flymake)
(require 'init-javascript)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  Packages                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(creature/require-package 'emmet-mode)

(defun creature-css-setup ()
  (run-with-timer 0.2 nil
                  (lambda ()
                    (let ((so-long-p (creature-so-long-p))
                          (remote-p (creature-remote-file-p)))
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
(add-hook 'css-mode-hook #'creature-css-setup)


(provide 'init-css)
