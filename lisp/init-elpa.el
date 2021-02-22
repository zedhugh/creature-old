;; -*- coding: utf-8; lexical-binding: t; -*-

(setq package-quickstart t
      package-enable-at-startup nil
      package-selected-packages nil
      package-archives
      '(
        ;; ("gnu"   . "https://elpa.gnu.org/packages/")
        ;; ("org"   . "https://orgmode.org/elpa/")
        ;; ("melpa" . "https://melpa.org/packages/")

        ("gnu-cn"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("org-cn"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
        ("melpa-cn" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")

        ;; ("gnu-cn"   . "https://elpa.emacs-china.org/gnu/")
        ;; ("org-cn"   . "https://elpa.emacs-china.org/org/")
        ;; ("melpa-cn" . "https://elpa.emacs-china.org/melpa/")
        ))

(with-eval-after-load 'package
  ;; don't save `package-selected-packages' to config file
  (defun package--save-selected-packages (&optional value)
    "Only set `package-selected-packages' to VALUE."
    (when value
      (setq package-selected-packages value)))

  (add-hook 'package-menu-mode-hook
            (lambda ()
              (setq-local package-quickstart nil))))

(defun creature/require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE."
  (cond
   ((package-installed-p package min-version)
    (add-to-list 'package-selected-packages package))
   ((or (assoc package package-archive-contents) no-refresh)
    (package-install package)
    (add-to-list 'package-selected-packages package))
   (t
    (package-refresh-contents)
    (creature/require-package package min-version t))))

(defun creature/install-packages (packages)
  "Install packages.
if `PACKAGES' is a list, install every package in `PACKAGES',
otherwise, install `PACKAGES'."
  (let ((package-quickstart nil))
    (if (listp packages)
        (dolist (pkg packages)
          (creature/require-package pkg))
      (creature/require-package packages))))

(unless (file-exists-p (concat creature/config-dir "elpa"))
  (package-initialize)
  (creature/install-packages
   '(editorconfig
     lua-mode
     company-lua
     vimrc-mode

     company
     yasnippet
     auto-yasnippet
     posframe
     company-posframe
     yasnippet-snippets

     flycheck

     counsel
     ivy
     swiper
     amx
     pinyinlib

     smartparens

     web-mode
     emmet-mode
     company-web
     json-mode
     tide
     typescript-mode
     prettier

     lsp-mode
     lsp-ui
     lsp-treemacs

     rainbow-delimiters
     rainbow-delimiters
     rainbow-identifiers
     page-break-lines

     htmlize
     org-pomodoro
     org-plus-contrib
     ox-hugo

     hydra

     pinentry
     keyfreq
     rime
     forge
     gitattributes-mode
     gitconfig-mode
     gitignore-mode
     rg
     symbol-overlay
     winum
     projectile
     counsel-projectile
     avy
     undo-tree
     expand-region
     youdao-dictionary

     mingus

     mwim
     evil
     evil-matchit
     evil-surround
     evil-nerd-commenter

     which-key
     )))

(provide 'init-elpa)
