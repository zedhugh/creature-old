;;; init-ivy.el --- ivy packages

;;; Commentary:

;; packages for ivy

;;; Code:

(counsel-mode)
(evil-leader/set-key
  "fr" 'counsel-recentf)


(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq ivy-use-selectable-prompt t)
(setq enable-recursive-minibuffers t)

;; ivy-rich
(setq ivy-virtual-abbreviate 'full)
(setq ivy-rich-switch-buffer-align-virtual-buffer t)
(setq ivy-rich-path-style 'abbrev)
(ivy-set-display-transformer
 'ivy-switch-buffer
 'ivy-rich-switch-buffer-transformer)

(global-set-key (kbd "C-s") 'swiper)

;; smex: record freq for command

(unless (file-exists-p creature-cache)
  (make-directory creature-cache))
(setq smex-save-file
      (expand-file-name ".smex-items" creature-cache))

(provide 'init-ivy)
;;; init-ivy.el ends here
