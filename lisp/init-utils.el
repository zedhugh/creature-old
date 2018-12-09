(setq default-input-method 'pyim)
(setq pyim-page-style 'one-line)
(setq pyim-page-tooltip 'popup)
(setq pyim-english-input-switch-functions
      '(pyim-probe-program-mode))
(setq pyim-punctuation-half-width-functions
      '(pyim-probe-punctuation-line-beginning
        pyim-probe-punctuation-after-punctuation))
(when (featurep 'pyim-basedict)
  (pyim-basedict-enable))
;; Enable a big dict for pyim.
;; (let ((greatdict
;;        (concat creature-dir
;;                "pyim-dicts/pyim-greatdict.pyim.gz")))
;;   (when (featurep 'pyim)
;;     (pyim-extra-dicts-add-dict
;;      `(:name "Greatdict-elpa"
;;              :file ,greatdict
;;              :coding utf-8-lang
;;              :dict-type pinyin-dict))))

(smooth-scrolling-mode)

(add-hook 'special-mode-hook
          (lambda ()
            (setq-local smooth-scroll-margin 0)))

;;; magit
(setq magit-revision-show-gravatars
      '("^Author:     " . "^Commit:     "))

(unless sys/win32p
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize))

(projectile-mode)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(rg-enable-default-bindings)

;; symbol-overlay-map
;; "i" -> symbol-overlay-put
;; "n" -> symbol-overlay-jump-next
;; "p" -> symbol-overlay-jump-prev
;; "w" -> symbol-overlay-save-symbol
;; "t" -> symbol-overlay-toggle-in-scope
;; "e" -> symbol-overlay-echo-mark
;; "d" -> symbol-overlay-jump-to-definition
;; "s" -> symbol-overlay-isearch-literally
;; "q" -> symbol-overlay-query-replace
;; "r" -> symbol-overlay-rename
(global-set-key (kbd "s-i") 'symbol-overlay-put)
(global-set-key (kbd "M-p") 'symbol-overlay-jump-prev)
(global-set-key (kbd "M-n") 'symbol-overlay-jump-next)

(provide 'init-utils)
