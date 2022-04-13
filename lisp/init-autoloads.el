;; -*- coding: utf-8; lexical-binding: t; -*-

(autoload 'sp-backward-sexp "smartparens" "" t)
(autoload 'sp-forward-sexp "smartparens" "" t)
(autoload 'sp-kill-hybrid-sexp "smartparens" "" t)
(autoload 'sp-delete-char "smartparens" "" t)
(autoload 'sp-delete-word "smartparens" "" t)
(autoload 'sp-wrap-curly "smartparens" "" t)
(autoload 'sp-wrap-square "smartparens" "" t)
(autoload 'sp-wrap-round "smartparens" "" t)
(autoload 'sp-unwrap-sexp "smartparens" "" t)
(autoload 'turn-on-smartparens-mode "smartparens" "" t)

(autoload 'awesome-pair-mode "../site-lisp/awesome-pair/awesome-pair" "" t)
(autoload 'tsi-typescript-mode "../site-lisp/tsi/tsi-typescript" "" t)

(autoload 'server-running-p "server" "" nil)
(autoload 'server-start "server" "" nil)

(autoload 'diary-entry-time "diary-lib" "" nil)

(autoload 'pinyinlib-build-regexp-string "pinyinlib" "" nil)

(autoload 'magit-find-git-config-file "magit-files" "" nil)

(provide 'init-autoloads)
