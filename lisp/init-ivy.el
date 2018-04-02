;;; init-ivy.el --- ivy packages

;;; Commentary:

;; packages for ivy

;;; Code:

(use-package counsel
  :init
  (add-hook 'emacs-startup-hook 'counsel-mode)
  (evil-leader/set-key
    "fr" 'counsel-recentf))

(use-package ivy
  :init
  (add-hook 'emacs-startup-hook 'ivy-mode)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))

;; ivy-rich
(use-package ivy-rich
  :config
  (setq ivy-virtual-abbreviate 'full)
  (setq ivy-rich-switch-buffer-align-virtual-buffer t)
  (setq ivy-rich-path-style 'abbrev)
  (ivy-set-display-transformer
   'ivy-switch-buffer
   'ivy-rich-switch-buffer-transformer))

(use-package swiper
  :init
  (global-set-key (kbd "C-s") 'swiper))

;; smex
(use-package smex
  :init
  (unless (file-exists-p creature-cache)
    (make-directory creature-cache))
  (setq smex-save-file
        (expand-file-name ".smex-items" creature-cache)))

(provide 'init-ivy)
;;; init-ivy.el ends here
