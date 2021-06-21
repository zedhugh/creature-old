;; -*- coding: utf-8; lexical-binding: t; -*-

(setq package-selected-packages nil
      package-native-compile t
      ;; package-enable-at-startup nil

      ;; change this options need call `package-initialize', but `package-initialize' too slow
      package-user-dir (concat creature/config-dir "elpa-" emacs-version)
      package-gnupghome-dir (concat creature/config-dir "elpa-" emacs-version "/gnupg")

      package-quickstart t
      package-quickstart-file (concat creature/config-dir "package-quickstart-" emacs-version ".el")

      package-archives
      '(
        ("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")

        ;; ("gnu-cn"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ;; ("nongnu-cn" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
        ;; ("melpa-cn"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ))

(with-eval-after-load 'package
  ;; don't save `package-selected-packages' to config file
  (defun package--save-selected-packages (&optional value)
    "Only set `package-selected-packages' to VALUE."
    (when value
      (setq package-selected-packages value))))

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
  (if (listp packages)
      (dolist (pkg packages)
        (creature/require-package pkg))
    (creature/require-package packages)))

(defvar creature/packages
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
    typescript-mode
    prettier

    lsp-mode
    lsp-ui
    lsp-treemacs
    lsp-tailwindcss

    modus-themes
    rainbow-delimiters
    rainbow-delimiters
    rainbow-identifiers
    page-break-lines

    htmlize
    org-pomodoro
    org-contrib
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

    emms

    mwim
    evil
    evil-matchit
    evil-surround
    evil-nerd-commenter

    which-key

    cmake-mode

    nginx-mode
    company-nginx

    pdf-tools
    saveplace-pdf-view
    ))

(unless (featurep 'package)
  (package-initialize))
(creature/install-packages creature/packages)

(provide 'init-elpa)
