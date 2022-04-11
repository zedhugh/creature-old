;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'init-elpa)

(creature/require-package 'company)

(global-company-mode)

(defun creature-company-hide-then-show-snippet ()
  "Hide current completions and show snippets."
  (interactive)
  (company-cancel)
  (call-interactively #'company-yasnippet))

(with-eval-after-load 'company
  (setq company-idle-delay 0
        company-show-numbers t
        company-require-match nil
        company-minimum-prefix-length 2
        company-clang-insert-arguments t
        company-dabbrev-char-regexp "[\\.0-9a-z-'/]"
        company-dabbrev-code-other-buffers 'all
        company-dabbrev-downcase nil
        company-tooltip-align-annotations t)

  (define-key company-active-map (kbd "C-c c")
              #'creature-company-hide-then-show-snippet)
  (define-key company-active-map (kbd "C-n")
              #'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "C-p")
              (defun creature/company-select-prev ()
                (interactive)
                (company-complete-common-or-cycle -1)))
  (define-key company-mode-map (kbd "C-;") #'company-yasnippet)
  (define-key company-mode-map (kbd "C-'") #'company-files))

;; (with-eval-after-load 'company-quickhelp
;;   (setq company-quickhelp-delay 0.4))

(defun creature-enable-ispell ()
  "Turn on spell prompt local buffer."
  (set (make-local-variable 'company-backends)
       '(company-capf
         company-files
         (company-dabbrev company-dabbrev-code company-ispell))))
(add-hook 'text-mode-hook 'creature-enable-ispell)


(provide 'init-company)
