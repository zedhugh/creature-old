;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'init-elpa)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                   eglot                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(creature/require-package 'eglot)

(defun eglot-disabled-mode-line ()
  (dolist (mode-line mode-line-misc-info)
    (let ((mode (car mode-line)))
      (when (eq mode 'eglot--managed-mode)
        (setq mode-line-misc-info (delete mode-line mode-line-misc-info))))))

(defun eglot-enable-mode-line ()
  (add-to-list 'mode-line-misc-info
               `(eglot--managed-mode (" [" eglot--mode-line-format "] "))))

(with-eval-after-load 'eglot
  (setq eglot-events-buffer-size 0)
  (add-hook 'eglot-managed-mode-hook #'flymake-eslint-setup)
  (add-hook 'eglot-managed-mode-hook #'eglot-disabled-mode-line)
  ;; (add-hook 'eglot-managed-mode-hook #'creature/toggle-eglot-completion)

  (setq eglot-confirm-server-initiated-edits nil
        eglot-autoshutdown t)

  (define-key eglot-mode-map (kbd "M-.") #'xref-find-definitions)
  (define-key eglot-mode-map (kbd "M-?") #'xref-find-references)
  (define-key eglot-mode-map (kbd "C-c r") #'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c o") #'eglot-code-actions))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                 lsp-bridge                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'lsp-bridge)
;; (global-lsp-bridge-mode)
;; (when (> (frame-pixel-width) 3000) (custom-set-faces '(corfu-default ((t (:height 1.3))))))
;; (setq lsp-bridge-diagnostic-tooltip-border-width 1)

;; (defun creature/eglot-completion-advice (&rest p)
;;   nil)
;; (defun creature/toggle-eglot-completion ()
;;   (when (fboundp #'corfu-mode)
;;     (if (bound-and-true-p lsp-bridge-mode)
;;         (corfu-mode -1)
;;       (corfu-mode 1)))
;;   (when (fboundp #'eglot-completion-at-point)
;;     (if (bound-and-true-p lsp-bridge-mode)
;;         (advice-add #'eglot-completion-at-point :around #'creature/eglot-completion-advice)
;;       (advice-remove #'eglot-completion-at-point #'creature/eglot-completion-advice))))

;; (add-hook 'lsp-bridge-mode-hook #'creature/toggle-eglot-completion)

;; (creature/set-keys lsp-bridge-mode-map
;;                    "M-." #'lsp-bridge-find-define
;;                    "M-?" #'lsp-bridge-find-references)


(provide 'init-lsp)
