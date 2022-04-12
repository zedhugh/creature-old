;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'init-elpa)

(creature/require-package 'tree-sitter)
(creature/require-package 'tree-sitter-langs)
(creature/require-package 'mmm-mode)

(define-derived-mode typescript-tsx-mode typescript-mode "tsx"
  (require 'mmm-mode)
  (require 'web-mode)

  (emmet-mode)
  (tree-sitter-mode)
  (tree-sitter-hl-mode)

  (mmm-add-classes
   '((mmm-jsx-mode
      ;; :front "\\(return\s\\|n\s\\|(\n\s*\\)<"
      :front "<"
      :front-offset 0
      :back ">\n?\s*)"
      :back-offset 1
      :submode web-mode)))
  (mmm-add-mode-ext-class 'typescript-tsx-mode nil 'mmm-jsx-mode)
  (mmm-mode))

(with-eval-after-load 'evil-nerd-commenter
  (add-to-list 'evilnc-html-comment-delimiters '("typescript-tsx-mode" "{* " " *}")))

(add-to-list 'auto-mode-alist '("\\.tsx\\'"  . typescript-tsx-mode))

(with-eval-after-load 'tree-sitter-langs
  (tree-sitter-require 'tsx)
  (add-to-list 'tree-sitter-major-mode-language-alist '(web-mode . tsx))
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-tsx-mode . tsx)))


(provide 'init-tree-sitter)
