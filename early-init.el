;; (org-babel-load-file (expand-file-name "~/.emacs.d/creature.org"))

;; disable menu, toolbar and scroll bar.
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(add-to-list 'default-frame-alist '(alpha . 90))
