;; -*- coding: utf-8; lexical-binding: t; -*-

(defun creature/setup-company ()
  (global-company-mode)
  (remove-hook 'prog-mode-hook #'creature/setup-company))

(add-hook 'prog-mode-hook #'creature/setup-company)
;; (run-with-idle-timer 2 nil #'creature/setup-company)

(with-eval-after-load 'company
  (setq company-idle-delay 0)
  (setq company-show-numbers t)
  (setq company-require-match nil)
  (setq company-minimum-prefix-length 2)
  (setq company-clang-insert-arguments t)
  (setq company-dabbrev-char-regexp "[\\.0-9a-z-'/]")
  (setq company-dabbrev-code-other-buffers 'all)
  (setq company-dabbrev-downcase nil)

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

;; (yas-global-mode)
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
      (run-with-idle-timer 1 nil #'creature/company-add-yas))))

(add-hook 'yas-minor-mode-hook #'creature/setup-yasnippet)

(global-set-key (kbd "s-w") #'aya-create)
(global-set-key (kbd "s-y") #'aya-expand)
(global-set-key (kbd "C-o") #'aya-open-line)

(provide 'init-company)
