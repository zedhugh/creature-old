;;; init-utils.el --- utils

;;; Commentary:

;;; Code:

(require 'init-elpa)
(require-package 'which-key)
(require-package 'window-numbering)
(require-package 'smooth-scrolling)
(require-package 'company)
(require-package 'flycheck)
(require-package 'aggressive-indent)
(require-package 'smartparens)
(require-package 'hungry-delete)
(require-package 'youdao-dictionary)
(require-package 'expand-region)
(require-package 'popwin)
(require-package 'rainbow-identifiers)
(require-package 'solarized-theme)

;; which-key
(require 'which-key)
(which-key-mode)
(setq which-key-idle-delay 0.4)

(window-numbering-mode)
(smooth-scrolling-mode)

;; complete
(require 'company)
(company-mode)
(global-company-mode)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)
(define-key company-active-map (kbd "C-n")
  #'company-complete-common-or-cycle)
(define-key company-active-map (kbd "C-p")
  (lambda ()
    (interactive)
    (company-complete-common-or-cycle -1)))

;; syntax check
(require 'flycheck)
(global-flycheck-mode)
(require 'init-defuns)
(setq flycheck-emacs-lisp-load-path load-path)
(evil-leader/set-key
  "el" 'flycheck-list-errors
  "ex" 'flycheck-display-error-at-point)

;; auto indent
(require 'aggressive-indent)
(require 'init-env)
(global-aggressive-indent-mode)
;; disable when open big file
(add-hook 'find-file-hook
          (lambda ()
            (when (> (buffer-size) (* 3000 80))
              (aggressive-indent-mode -1))))
;; disable if indent means special
(dolist (mode creature/indent-sensitive-modes)
  (push mode aggressive-indent-excluded-modes))

(require 'smartparens)
(smartparens-global-strict-mode)
(show-smartparens-global-mode)
(require 'smartparens-config)

;; delete multi space
(require 'hungry-delete)
(global-hungry-delete-mode)
(setq hungry-delete-chars-to-skip " \t\f\v")
(define-key hungry-delete-mode-map (kbd "DEL") 'hungry-delete-backward)

;; youdao dictionary
(evil-leader/set-key
  "ys" 'youdao-dictionary-search-at-point
  "yp" 'youdao-dictionary-play-voice-at-point)

;; expand region
(evil-leader/set-key "v" 'er/expand-region)

;; colorful GUI
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)

;; load theme
(require 'solarized)
(load-theme 'solarized-dark t)

;; popwin
(require 'popwin)
(popwin-mode)
(setq popwin:special-display-config
      '(;; Emacs
        ("*Help*" :dedicated t :position bottom :stick t :noselect nil)
        ("*compilation*" :dedicated t :position bottom :stick t :noselect t :height 0.4)
        ("*Compile-Log*" :dedicated t :position bottom :stick t :noselect t :height 0.4)
        ("*Warnings*" :dedicated t :position bottom :stick t :noselect t)
        ("*Completions*" :dedicated t :position bottom :stick t :noselect nil)
        ("*Shell Command Output*" :dedicated t :position bottom :stick t :noselect nil)
        ("\*Async Shell Command\*.+" :regexp t :position bottom :stick t :noselect nil)
        ("^*Man.+*$" :regexp t :position bottom :stick nil :noselect nil :height 0.4)
        ("^*WoMan.+*$" :regexp t :position bottom)
        ("^*Backtrace.+*$" :regexp t :dedicated t :position bottom :stick t :noselect nil)

        ;; Kill Ring
        ("*Kill Ring*" :dedicated t :position bottom)

        ;; Flycheck
        ("\*flycheck errors\*.+*$" :regexp t :position bottom :stick t :noselect nil)

        ;; Youdao dict
        ("*Youdao Dictionary*" :dedicated t :stick t :position bottom)

        ;; Paradox
        ("*Paradox Report*" :dedicated t :position bottom :noselect nil)

        ;; List
        ("*Colors*" :dedicated t :position bottom)
        ("*Process List*" :dedicated t :position bottom)
        ("*Process-Environment*" :dedicated t :position bottom)

        ;; undo-tree
        (" *undo-tree*" :dedicated t :position right :stick t :noselect nil :width 60)

        ;; Search
        ("*grep*" :dedicated t :position bottom :stick t :noselect nil)
        ("*ag search*" :dedicated t :position bottom :stick t :noselect nil :height 0.4)
        ("*rg*" :dedicated t :position bottom :stick t :noselect nil :height 0.4)
        ("*pt-search*" :dedicated t :position bottom :stick t :noselect nil :height 0.4)
        ("*Occur*" :dedicated t :position bottom :stick t :noselect nil)
        ("\*ivy-occur.+*$" :regexp t :position bottom :stick t :noselect nil)
        ("*xref*" :dedicated t :position bottom :stick nil :noselect nil)

        ;; VC
        ("*vc-diff*" :dedicated t :position bottom :stick t :noselect nil)
        ("*vc-change-log*" :dedicated t :position bottom :stick t :noselect nil)

        ;; Magit
        ;; (magit-status-mode :dedicated t :position bottom :stick t :height 0.5)
        ;; (magit-diff-mode :dedicated t :position bottom :stick t :noselect t :height 0.5)

        ;; Script
        ("*shell*" :dedicated t :position bottom :stick t :noselect nil)
        ("*Python*" :dedicated t :position bottom :stick t :noselect t)
        ("*Ruby*" :dedicated t :position bottom :stick t :noselect t)
        ("*quickrun*" :dedicated t :position bottom :stick t :noselect t)
        ))

(provide 'init-utils)
;;; init-utils.el ends here
