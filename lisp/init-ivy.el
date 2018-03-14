;;; init-ivy.el --- ivy packages

;;; Commentary:

;; packages for ivy

;;; Code:

(require 'init-elpa)
(require-package 'counsel)
(require-package 'swiper)
(require-package 'ivy)
(require-package 'ivy-rich)
(require-package 'smex)

(require 'counsel)
(counsel-mode)
(ivy-mode)
(evil-leader/set-key
  "fr" 'counsel-recentf)

(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; ivy-rich
(require 'ivy-rich)
(setq ivy-virtual-abbreviate 'full)
(setq ivy-rich-switch-buffer-align-virtual-buffer t)
(setq ivy-rich-path-style 'abbrev)
(add-hook 'ivy-mode-hook
	  (lambda ()
	    (ivy-set-display-transformer
             'ivy-switch-buffer
             'ivy-rich-switch-buffer-transformer)))

(global-set-key (kbd "C-s") 'swiper)

(provide 'init-ivy)
;;; init-ivy.el ends here
