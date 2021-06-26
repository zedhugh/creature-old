;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'init-elpa)

(creature/require-package 'company)
(creature/require-package 'posframe)
(creature/require-package 'company-posframe)

(defun creature/setup-company ()
  (global-company-mode)
  (remove-hook 'prog-mode-hook #'creature/setup-company))

(add-hook 'prog-mode-hook #'creature/setup-company)

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

  (company-posframe-mode)
  (yas-global-mode)

  (define-key company-active-map (kbd "C-n")
    #'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "C-p")
    (defun creature/company-select-prev ()
      (interactive)
      (company-complete-common-or-cycle -1)))
  (define-key company-mode-map (kbd "C-'") #'company-files))

(with-eval-after-load 'company-posframe
  (setq company-posframe-show-indicator nil)
  (setq company-posframe-show-metadata nil)

  (with-eval-after-load 'desktop
    (push '(company-posframe-mode . nil)
          desktop-minor-mode-table)))

(defun creature/enable-ispell ()
  "Turn on spell prompt local buffer."
  (set (make-local-variable 'company-backends)
       '(company-capf
         company-files
         (company-dabbrev company-dabbrev-code company-ispell))))
(add-hook 'text-mode-hook 'creature/enable-ispell)

(creature/require-package 'yasnippet)
(creature/require-package 'yasnippet-snippets)

(defvar creature/company-backends-with-yasnippet nil
  "Make every company backend with `company-yasnippet' when `company-mode' launched.")

(defun creature/show-snippets-in-company (backend)
  (if (and (listp backend) (member 'company-yasnippet backend))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(defun creature/company-add-yas ()
  "Add yasnippet to company popup menu."
  (set (make-local-variable 'company-backends)
       (mapcar #'creature/show-snippets-in-company company-backends)))

(defun creature/setup-yasnippet ()
  (when (and company-mode
             creature/company-backends-with-yasnippet)
    (with-current-buffer (buffer-name)
      (run-with-timer 0.5 nil #'creature/company-add-yas))))


(with-eval-after-load 'yasnippet
  (add-hook 'yas-minor-mode-hook #'creature/setup-yasnippet)
  (creature/setup-yasnippet))

(creature/require-package 'auto-yasnippet)

(global-set-key (kbd "s-w") #'aya-create)
(global-set-key (kbd "s-y") #'aya-expand)
(global-set-key (kbd "C-o") #'aya-open-line)

(provide 'init-company)
