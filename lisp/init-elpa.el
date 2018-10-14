;;; Commentary:

;; initialize package config.

;;; Code:

(unless (fboundp 'package-installed-p)
  (package-initialize))

(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE."
  (if (package-installed-p package min-version)
      (unless (member package package-selected-packages)
        (push package package-selected-packages))
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package t)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

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

;; evil
(require-package 'mwim)
(require-package 'evil)
(require-package 'evil-leader)
(require-package 'evil-matchit)
(require-package 'evil-surround)
(require-package 'evil-nerd-commenter)

;; utils
(require-package 'which-key)
(require-package 'window-numbering)
(require-package 'flycheck)
(require-package 'smartparens)
(require-package 'hungry-delete)
(require-package 'smooth-scrolling)
(require-package 'youdao-dictionary)
(require-package 'expand-region)
(require-package 'posframe)
(require-package 'pyim)

;; company
(require-package 'company)
(require-package 'yasnippet)
(require-package 'yasnippet-snippets)
(require-package 'company-posframe)

;; ivy
(require-package 'counsel)
(require-package 'ivy)
(require-package 'ivy-rich)
(require-package 'swiper)
(require-package 'smex)
(require-package 'pinyinlib)

;; git
(require-package 'magit)
(require-package 'gitattributes-mode)
(require-package 'gitconfig-mode)
(require-package 'gitignore-mode)

;; webdev
(require-package 'web-mode)
(require-package 'js2-mode)
(require-package 'json-mode)
(require-package 'rjsx-mode)
(require-package 'emmet-mode)
(require-package 'company-web)
(require-package 'tern)
(require-package 'company-tern)
(require-package 'typescript-mode)
(require-package 'tide)

;; program language
(require-package 'lua-mode)

;; org
(require-package 'org-pomodoro)
(require-package 'org-plus-contrib)

;; ui
(require-package 'rainbow-delimiters)
(require-package 'rainbow-identifiers)
(require-package 'molokai-theme)
(require-package 'monokai-theme)
(require-package 'page-break-lines)

;; dired
(require-package 'dired-narrow)
(require-package 'all-the-icons-dired)

;; C
(require-package 'google-c-style)

;; env
(require-package 'exec-path-from-shell)

;; hydra
(require-package 'hydra)

(provide 'init-elpa)
