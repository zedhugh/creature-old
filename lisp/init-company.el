;; -*- coding: utf-8; lexical-binding: t; -*-

(creature/install-packages
  '(company
    yasnippet
    auto-yasnippet
    posframe
    company-posframe
    yasnippet-snippets))

;; (global-company-mode)
(setq company-idle-delay 0)
(setq company-show-numbers t)
(setq company-require-match nil)
(setq company-minimum-prefix-length 2)
(setq company-clang-insert-arguments t)
(setq company-dabbrev-char-regexp "[\\.0-9a-z-'/]")
(setq company-dabbrev-code-other-buffers 'all)
(setq company-dabbrev-downcase nil)

(add-hook 'prog-mode-hook #'company-mode)
(run-with-idle-timer 10 nil #'global-company-mode)

(with-eval-after-load 'company
  (company-posframe-mode)
  (yas-global-mode)

  (define-key company-active-map (kbd "C-n")
    #'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "C-p")
    (defun creature/company-select-prev ()
      (interactive)
      (company-complete-common-or-cycle -1)))
  (define-key company-mode-map (kbd "C-'") #'company-files)
  )

(setq company-posframe-show-indicator nil)
(setq company-posframe-show-metadata nil)
(with-eval-after-load 'company-posframe
  (require 'desktop)
  (push '(company-posframe-mode . nil)
        desktop-minor-mode-table))

(defun creature/enable-ispell ()
  "Turn on spell prompt local buffer."
  (set (make-local-variable 'company-backends)
       (add-to-list 'company-backends 'company-ispell 'append)))
;; (add-hook 'text-mode-hook 'creature/enable-ispell)

;; (yas-global-mode)

(defun creature/show-snippets-in-company (backend)
  (if (and (listp backend) (member 'company-yasnippet backend))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(defun creature/company-add-yas ()
  "Add yasnippet to company popup menu."
  (set (make-local-variable 'company-backends)
       (mapcar 'creature/show-snippets-in-company company-backends)))
(add-hook 'yas-minor-mode-hook 'creature/company-add-yas)

(global-set-key (kbd "s-w") #'aya-create)
(global-set-key (kbd "s-y") #'aya-expand)
(global-set-key (kbd "C-o") #'aya-open-line)

(provide 'init-company)
