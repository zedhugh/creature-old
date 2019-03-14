(require 'pyim)
(setq default-input-method 'pyim)
(setq pyim-page-style 'one-line)
(setq pyim-page-tooltip 'popup)
(setq pyim-english-input-switch-functions
      '(pyim-probe-program-mode))
(setq pyim-punctuation-half-width-functions
      '(pyim-probe-punctuation-line-beginning
        pyim-probe-punctuation-after-punctuation))
(when (featurep 'pyim)
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
(with-eval-after-load 'magit
  (require 'forge))
(setq magit-revision-show-gravatars
      '("^Author:     " . "^Commit:     "))

(unless sys/win32p
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize))

(projectile-mode)
(rg-enable-default-bindings)

(provide 'init-utils)
