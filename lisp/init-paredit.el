;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'init-elpa)

(creature/require-package 'smartparens)

(delete-selection-mode)

(electric-pair-mode)

(with-eval-after-load 'awesome-pair
  ;; (define-key awesome-pair-mode-map (kbd "(") 'awesome-pair-open-round)
  ;; (define-key awesome-pair-mode-map (kbd "[") 'awesome-pair-open-bracket)
  ;; (define-key awesome-pair-mode-map (kbd "{") 'awesome-pair-open-curly)
  (define-key awesome-pair-mode-map (kbd ")") 'awesome-pair-close-round)
  (define-key awesome-pair-mode-map (kbd "]") 'awesome-pair-close-bracket)
  (define-key awesome-pair-mode-map (kbd "}") 'awesome-pair-close-curly)
  ;; (define-key awesome-pair-mode-map (kbd "=") 'awesome-pair-equal)

  (define-key awesome-pair-mode-map (kbd "%") 'awesome-pair-match-paren)
  ;; (define-key awesome-pair-mode-map (kbd "\"") 'awesome-pair-double-quote)
  (define-key awesome-pair-mode-map (kbd "SPC") 'awesome-pair-space)
  (define-key awesome-pair-mode-map (kbd "M-o") 'awesome-pair-backward-delete)
  (define-key awesome-pair-mode-map (kbd "C-d") 'awesome-pair-forward-delete)
  (define-key awesome-pair-mode-map (kbd "C-k") 'creature/awesome-pair-kill)

  (define-key awesome-pair-mode-map (kbd "M-\"") 'awesome-pair-wrap-double-quote)
  (define-key awesome-pair-mode-map (kbd "M-[") 'awesome-pair-wrap-bracket)
  (define-key awesome-pair-mode-map (kbd "M-{") 'awesome-pair-wrap-curly)
  (define-key awesome-pair-mode-map (kbd "M-(") 'awesome-pair-wrap-round)
  (define-key awesome-pair-mode-map (kbd "M-)") 'awesome-pair-unwrap)

  (define-key awesome-pair-mode-map (kbd "M-N") 'awesome-pair-jump-right)
  (define-key awesome-pair-mode-map (kbd "M-P") 'awesome-pair-jump-left)
  (define-key awesome-pair-mode-map (kbd "M-RET") 'awesome-pair-jump-out-pair-and-newline))

(defun creature/awesome-pair-in-template-string-p ()
  (and (awesome-pair-in-string-p)
       (consp (awesome-pair-string-start+end-points))

       (let* ((pos_cons (awesome-pair-string-start+end-points))
              (start (car pos_cons))
              (end (cdr pos_cons)))
         (and (char-equal ?` (char-after start))
              (char-equal ?` (char-after end))))))

(defun creature/awesome-pair-kill ()
  (interactive)
  (cond ((and (derived-mode-p 'js-mode 'typescript-mode 'web-mode)
              (creature/awesome-pair-in-template-string-p)
              (awesome-pair-in-curly-p))
         (call-interactively #'sp-kill-hybrid-sexp))
        ((derived-mode-p 'web-mode)
         (call-interactively #'sp-kill-hybrid-sexp))
        (t
         (awesome-pair-kill))))

(defun creature/awesome-pair-setup ()
  (add-hook 'prog-mode-hook #'awesome-pair-mode)
  (add-hook 'conf-unix-mode-hook #'awesome-pair-mode)
  (add-hook 'conf-windows-mode-hook #'awesome-pair-mode)
  (add-hook 'web-mode-hook #'turn-on-smartparens-mode)
  (add-hook 'yaml-mode-hook #'awesome-pair-mode)
  nil)

(defun creature/smartparens-setup ()
  (with-eval-after-load 'smartparens
    (define-key smartparens-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)
    (define-key smartparens-mode-map (kbd "C-d") 'sp-delete-char)
    (define-key smartparens-mode-map (kbd "M-D") 'sp-delete-word)
    (define-key smartparens-mode-map (kbd "M-{") 'sp-wrap-curly)
    (define-key smartparens-mode-map (kbd "M-[") 'sp-wrap-square)
    (define-key smartparens-mode-map (kbd "M-(") 'sp-wrap-round)
    (define-key smartparens-mode-map (kbd "M-)") 'sp-unwrap-sexp))

  (smartparens-global-mode))

(with-eval-after-load 'smartparens
  (require 'smartparens-config))

;; (creature/smartparens-setup)
(creature/awesome-pair-setup)

(provide 'init-paredit)
