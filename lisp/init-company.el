;; complete
(use-package company
  :init
  (global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-show-numbers t)
  (define-key company-active-map (kbd "C-n")
    #'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "C-p")
    (lambda ()
      (interactive)
      (company-complete-common-or-cycle -1)))
  (add-hook 'text-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   (add-to-list 'company-backends 'company-ispell)))))

;; yasnippet
(use-package yasnippet
  :init
  (defun add-yas ()
    "Add yasnippet to company popup menu."
    (let ((backends company-backends))
      (set (make-local-variable 'company-backends) nil)
      (dolist (backend backends)
        (add-to-list 'company-backends
                     (cons backend
                           '(:with company-yasnippet))
                     'append))))
  (add-hook 'company-mode-hook 'yas-minor-mode)
  (add-hook 'yas-minor-mode-hook 'add-yas))

(use-package yasnippet-snippets)

(provide 'init-company)
