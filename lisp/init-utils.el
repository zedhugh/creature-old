;;; init-utils.el --- utils

;;; Commentary:

;;; Code:

;; which-key
(use-package which-key
  :init
  (add-hook 'after-init-hook 'which-key-mode)
  (setq which-key-idle-delay 0.4)
  (defun creature/which-key-declare-prefixes (key doc &rest bind)
    "Define KEY's DOC with the same way of `evil-leader/set-key'.
BIND is rest sets of KEY and DOC."
    (while key
      (let ((key1 (concat evil-leader/leader " " key))
            (key2 (concat evil-leader/non-normal-prefix
                          evil-leader/leader " " key)))
        (which-key-add-key-based-replacements key1 doc)
        (which-key-add-key-based-replacements key2 doc))
      (setq key (pop bind)
            doc (pop bind)))))

(use-package window-numbering
  :init
  (add-hook 'after-init-hook 'window-numbering-mode))

(use-package smooth-scrolling
  :init
  (add-hook 'after-init-hook 'smooth-scrolling-mode))

;; syntax check
(use-package flycheck
  :init
  (defun enable-flycheck ()
    (flycheck-mode 1))
  (defun disable-flycheck ()
    (flycheck-mode -1))
  (add-hook 'prog-mode-hook 'enable-flycheck)
  (add-hook 'emacs-lisp-mode-hook 'disable-flycheck)
  (setq flycheck-emacs-lisp-load-path load-path)
  (evil-leader/set-key
    "el" 'flycheck-list-errors
    "ex" 'flycheck-display-error-at-point))

(use-package smartparens
  :init
  (add-hook 'after-init-hook 'smartparens-global-strict-mode)
  (add-hook 'smartparens-global-strict-mode-hook
            'show-smartparens-global-mode)
  (add-hook 'smartparens-global-strict-mode-hook
            (lambda () (require 'smartparens-config)))
  (defun creature/backward-kill-word-or-region (&optional arg)
    "Call `kill-region' when a region is active.
and `backward-kill-word' otherwise.  ARG is passed to
`backward-kill-word' if no region is active."
    (interactive "p")
    (if (featurep 'smartparens)
        (if (region-active-p)
            (call-interactively #'sp-kill-region)
          (sp-backward-kill-word arg))
      (if (region-active-p)
          (call-interactively #'kill-region)
        (backward-kill-word arg)))))

;; delete multi space
(use-package hungry-delete
  :init
  (add-hook 'after-init-hook 'global-hungry-delete-mode)
  :config
  (setq hungry-delete-chars-to-skip " \t\f\v")
  (define-key hungry-delete-mode-map (kbd "DEL") 'hungry-delete-backward))

;; youdao dictionary
(use-package youdao-dictionary
  :init
  (evil-leader/set-key
    "ys" 'youdao-dictionary-search-at-point
    "yp" 'youdao-dictionary-play-voice-at-point))

;; expand region
(use-package expand-region
  :init
  (evil-leader/set-key "v" 'er/expand-region))

;; colorful GUI
(use-package rainbow-identifiers
  :init
  (add-hook 'prog-mode-hook 'rainbow-identifiers-mode))

;; load theme
(use-package spacemacs-theme
  :init
  (load-theme 'spacemacs-dark t))

(use-package all-the-icons-dired
  :init
  (unless sys/win32p
    (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)))

;; pyim
(use-package pyim
  :init
  (require 'pyim)
  (setq default-input-method 'pyim)
  (setq pyim-page-style 'one-line)
  (if (< emacs-major-version 26)
      (setq pyim-page-tooltip 'popup)
    (setq pyim-page-tooltip 'child-frame))
  (setq pyim-english-input-switch-functions
        '(pyim-probe-program-mode))
  (setq pyim-punctuation-half-width-functions
        '(pyim-probe-punctuation-line-beginning
          pyim-probe-punctuation-after-punctuation))
  (when (featurep 'pyim-basedict)
    (pyim-basedict-enable))

  (defun creature/pyim-greatdict-enable ()
    "Enable a big dict for pyim."
    (let ((greatdict
           (concat creature-dir
                   "pyim-dicts/pyim-greatdict.pyim.gz")))
      (if (featurep 'pyim)
          (pyim-extra-dicts-add-dict
           `(:name "Greatdict-elpa"
                   :file ,greatdict
                   :coding utf-8-lang
                   :dict-type pinyin-dict))
        nil)))
  (creature/pyim-greatdict-enable))

;; popwin
(use-package popwin
  :init
  (require 'popwin)
  (add-hook 'after-init-hook 'popwin-mode)
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
          )))

(provide 'init-utils)
;;; init-utils.el ends here
