;; -*- coding: utf-8; lexical-binding: t; -*-

(creature/require-package 'eglot)
(creature/require-package 'flymake)
(creature/require-package 'flymake-eslint)

(dolist (hook '(c-mode-common-hook
                css-mode-hook
                js-mode-hook
                typescript-mode-hook
                web-mode-hook))
  (add-hook hook #'eglot-ensure))

(with-eval-after-load 'eglot
  (setq eglot-confirm-server-initiated-edits nil
        eglot-autoshutdown t)
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) . ("clangd")))
  (add-to-list 'eglot-server-programs
               '((css-mode scss-mode less-css-mode) . ("css-languageserver" "--stdio")))
  ;; (add-to-list 'eglot-server-programs
  ;;           '((html-mode) . ("html-languageserver" "--stdio")))
  (add-to-list 'eglot-server-programs
               '((js-mode typescript-mode web-mode) . ("typescript-language-server" "--stdio")))

  (define-key eglot-mode-map (kbd "M-.") #'xref-find-definitions)
  (define-key eglot-mode-map (kbd "M-?") #'xref-find-references)
  (define-key eglot-mode-map (kbd "C-c r") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c o") 'eglot-code-actions))

(with-eval-after-load 'flymake
  (creature/set-keys creature-map
                     "ex" #'flymake-show-diagnostic
                     "el" #'flymake-show-diagnostics-buffer-and-jump)

  (define-key flymake-diagnostics-buffer-mode-map
    [remap quit-window]
    (lambda () (interactive) (quit-window t))))

(defun flymake-eslint-setup ()
  (flymake-eslint-enable)
  (flymake-mode-on)
  (setq-local flymake-eslint-project-root
              (locate-dominating-file buffer-file-name ".eslintrc.js")))

(add-hook 'eglot-managed-mode-hook #'flymake-eslint-setup)

(dolist (hook '(web-mode-hook typescript-mode-hook js-mode-hook))
  (add-hook hook #'flymake-eslint-setup 90))

(provide 'init-eglot)
