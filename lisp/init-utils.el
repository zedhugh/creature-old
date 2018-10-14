;;; init-utils.el --- utils

;;; Commentary:

;;; Code:

;; C code indent style
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
;; (setq c-mode-hook c-mode-common-hook)

;; which-key
(which-key-mode)
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
          doc (pop bind))))

(window-numbering-mode)

;; syntax check
(defun disable-flycheck ()
  (flycheck-mode -1))
(add-hook 'prog-mode-hook 'flycheck-mode)
(add-hook 'emacs-lisp-mode-hook 'disable-flycheck)
(with-eval-after-load 'flycheck
  (setq flycheck-emacs-lisp-load-path load-path)
  (evil-leader/set-key
    "el" 'flycheck-list-errors
    "ex" 'flycheck-display-error-at-point))

;; (require 'smartparens)
;; (smartparens-global-strict-mode)
;; (show-smartparens-global-mode)
;; (require 'smartparens-config)
;; (remove-hook 'post-self-insert-hook 'sp--post-self-insert-hook-handler)
;; (define-key smartparens-strict-mode-map (kbd "C-d") 'sp-delete-char)
;; (define-key smartparens-strict-mode-map (kbd "C-M-a") 'sp-beginning-of-sexp)
;; (define-key smartparens-strict-mode-map (kbd "C-M-e") 'sp-end-of-sexp)
;; (defun creature/backward-kill-word-or-region (&optional arg)
;;   "Call `kill-region' when a region is active.
;; and `backward-kill-word' otherwise.  ARG is passed to
;; `backward-kill-word' if no region is active."
;;   (interactive "p")
;;   (if (featurep 'smartparens)
;;       (if (region-active-p)
;;           (call-interactively #'sp-kill-region)
;;         (sp-backward-kill-word arg))
;;     (if (region-active-p)
;;         (call-interactively #'kill-region)
;;       (backward-kill-word arg))))

(require 'paredit)
(electric-pair-mode)
(add-hook 'prog-mode-hook 'enable-paredit-mode)
(defun paredit/space-for-delimiter-p (endp delm)
  (or (member 'font-lock-keyword-face (text-properties-at (1- (point))))
      (not (derived-mode-p 'c-mode
                           'c++-mode
                           'js-mode
                           'lua-mode
                           'objc-mode
                           'pascal-mode
                           'python-mode
                           'java-mode
                           'csharp-mode
                           'dart-mode
                           'd-mode
                           'go-mode
                           'basic-mode
                           'r-mode
                           'ruby-mode
                           'rust-mode
                           'typescript-mode))))
(add-to-list 'paredit-space-for-delimiter-predicates
             'paredit/space-for-delimiter-p)

;; delete multi space
(global-hungry-delete-mode)
(setq hungry-delete-chars-to-skip " \t\f\v")
(define-key hungry-delete-mode-map (kbd "DEL") 'hungry-delete-backward)

;; youdao dictionary
(evil-leader/set-key
  "ys" 'youdao-dictionary-search-at-point
  "yp" 'youdao-dictionary-play-voice-at-point)

;; expand region
(evil-leader/set-key "v" 'er/expand-region)

;; smooth-scrolling
(smooth-scrolling-mode)
(add-hook 'special-mode-hook
          (lambda ()
            (setq-local smooth-scroll-margin 0)))

;; pyim
(require 'pyim)
(setq default-input-method 'pyim)
(setq pyim-page-style 'one-line)
(setq pyim-page-tooltip 'child-frame)
(setq pyim-english-input-switch-functions
      '(pyim-probe-program-mode))
(setq pyim-punctuation-half-width-functions
      '(pyim-probe-punctuation-line-beginning
        pyim-probe-punctuation-after-punctuation))
(when (featurep 'pyim-basedict)
  (pyim-basedict-enable))
;; Enable a big dict for pyim.
(let ((greatdict
       (concat creature-dir
               "pyim-dicts/pyim-greatdict.pyim.gz")))
  (if (featurep 'pyim)
      (pyim-extra-dicts-add-dict
       `(:name "Greatdict-elpa"
               :file ,greatdict
               :coding utf-8-lang
               :dict-type pinyin-dict))
    nil))

;; Ediff
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(provide 'init-utils)
;;; init-utils.el ends here
