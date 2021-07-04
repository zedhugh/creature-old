;; -*- lexical-binding: t -*-

;; Folding
(add-hook 'prog-mode-hook #'hs-minor-mode)

;; Line number
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; Addition highlight keywords
(defun creature-addition-highlight-keyword ()
  "Add serveral keywords in program comment."
  (font-lock-add-keywords
   nil '(("\\<\\(FIXME\\|DEBUG\\|TODO\\):"
          1 font-lock-warning-face prepend))))

(add-hook 'prog-mode-hook #'creature-addition-highlight-keyword)

(provide 'init-program)
