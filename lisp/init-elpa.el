(defun install-packages (packages)
  "Install packages.
if `PACKAGES' is a list, install every package in `PACKAGES',
otherwise, install `PACKAGES'."
  (defun require-package (package &optional min-version no-refresh)
    "Ask elpa to install given PACKAGE."
    (if (package-installed-p package min-version)
        (unless (member package package-selected-packages)
          (push package package-selected-packages))
      (if (or (assoc package package-archive-contents) no-refresh)
          (progn
            (package-install package t)
            (add-to-list 'package-selected-packages package))
        (progn
          (package-refresh-contents)
          (require-package package min-version t)))))

  (if (listp packages)
      (dolist (pkg packages)
        (require-package pkg))
    (require-package packages)))

(setq package-selected-packages nil)

(setq package-archives
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

(install-packages '(;; paredit
                    ;; paredit-everywhere

                    company
                    yasnippet
                    yasnippet-snippets

                    ;; monokai-theme
                    molokai-theme
                    rainbow-delimiters
                    rainbow-identifiers
                    page-break-lines

                    hydra
                    which-key
                    window-numbering

                    flycheck

                    youdao-dictionary

                    expand-region

                    exec-path-from-shell

                    pyim

                    web-mode
                    emmet-mode
                    company-web

                    json-mode
                    typescript-mode

                    counsel
                    ivy
                    swiper
                    smex
                    pinyinlib

                    ;; magit
                    forge
                    gitattributes-mode
                    gitconfig-mode
                    gitignore-mode

                    htmlize
                    org-pomodoro
                    org-plus-contrib

                    lua-mode
                    company-lua

                    rg
                    symbol-overlay

                    mwim
                    evil
                    evil-escape
                    ;; evil-leader
                    evil-matchit
                    evil-surround
                    evil-nerd-commenter

                    editorconfig
                    undo-tree

                    vimrc-mode

                    ;; lsp
                    lsp-ui
                    lsp-mode
                    projectile

                    ;; gnupg pinentry for magit
                    pinentry
                    ))

(provide 'init-elpa)
