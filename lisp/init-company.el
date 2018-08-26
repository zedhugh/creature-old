;; complete
(global-company-mode)
(company-posframe-mode)
(setq company-idle-delay 0)
(setq company-show-numbers t)
(setq company-require-match nil)
(setq company-minimum-prefix-length 1)
(define-key company-active-map (kbd "C-n")
  #'company-complete-common-or-cycle)
(define-key company-active-map (kbd "C-p")
  (defun creature/company-select-prev ()
    (interactive)
    (company-complete-common-or-cycle -1)))

(defun enable-ispell ()
  "Turn on spell prompt."
  (set (make-local-variable 'company-backends)
       (add-to-list 'company-backends 'company-ispell 'append)))
(add-hook 'text-mode-hook 'enable-ispell)

;; yasnippet
(defun creature/show-snippets-in-company (backend)
  (if (and (listp backend) (member 'company-yasnippet backend))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(defun add-yas ()
  "Add yasnippet to company popup menu."
  (set (make-local-variable 'company-backends)
       (mapcar 'creature/show-snippets-in-company company-backends)))

(setq company-dabbrev-char-regexp "[\\.0-9a-z-'/]")
(setq company-dabbrev-code-other-buffers 'all)
(setq company-dabbrev-downcase nil)

(add-hook 'company-mode-hook 'yas-minor-mode)
(add-hook 'yas-minor-mode-hook 'add-yas)

(provide 'init-company)
