;; -*- lexical-binding: t -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                 Yasnippet                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(creature/require-package 'yasnippet)
(creature/require-package 'yasnippet-snippets)

(yas-global-mode)

(defvar creature-company-with-yasnippet nil
  "Make every `company-backend' with `company-yasnippet'.")

(defun creature-add-snippet (backend)
  "Add `company-yasnippet' to echo backend in `company-backends'."
  (if (and (listp backend) (member 'company-yasnippet backend))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(defun creature-handle-company-backends ()
  "Handle `company-yasnippet' in `company-backends'."
  (set (make-local-variable 'company-backends)
       (mapcar #'creature-add-snippet company-backends)))

(defun creature-yasnippet-setup ()
  "Setup yasnippet."
  (when (and (bound-and-true-p company-mode) creature-company-with-yasnippet)
    (with-current-buffer (buffer-name)
      (run-with-timer 0.5 nil #'creature-handle-company-backends))))

(with-eval-after-load 'yasnippet
  (setq yas-indent-line 'nothing)       ;don't indent for snippet
  (add-hook 'yas-minor-mode-hook #'creature-yasnippet-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               Auto yasnippet                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(creature/require-package 'auto-yasnippet)

(global-set-key (kbd "s-w") #'aya-create)
(global-set-key (kbd "s-y") #'aya-expand)
(global-set-key (kbd "C-o") #'aya-open-line)


(provide 'init-yasnippet)
