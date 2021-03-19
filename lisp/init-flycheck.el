;; -*- coding: utf-8; lexical-binding: t; -*-

(defun creature/setup-flycheck ()
  "Do not setup flycheck for every mode."
  (when (and (buffer-file-name)
             (not (derived-mode-p
                   'emacs-lisp-mode
                   'c-mode
                   'c++-mode
                   'js-mode
                   'typescript-mode
                   'web-mode)))

    (flycheck-mode)))

(defun creature/toggle-flycheck-error-list ()
  "Toggle flycheck's error list window.
If the error list is visible, hide it.  Otherwise, show and focus on it."
  (interactive)
  (-if-let (window (flycheck-get-error-list-window))
      (quit-window nil window)
    (flycheck-list-errors)
    (switch-to-buffer-other-window flycheck-error-list-buffer)))

(add-hook 'prog-mode-hook 'creature/setup-flycheck)
(with-eval-after-load 'flycheck
  ;; (setq flycheck-emacs-lisp-load-path load-path)
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(provide 'init-flycheck)
