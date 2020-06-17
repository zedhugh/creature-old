(require 'pyim)
(setq default-input-method 'pyim)
(setq pyim-page-style 'one-line)
(setq pyim-page-tooltip 'posframe)
;; (setq-default pyim-english-input-switch-functions
;;               '(pyim-probe-auto-english
;;                 pyim-probe-program-mode
;;                 pyim-probe-org-structure-template))
(setq-default pyim-punctuation-half-width-functions
              '(pyim-probe-punctuation-line-beginning
                pyim-probe-punctuation-after-punctuation))
(when (featurep 'pyim)
  (pyim-basedict-enable))

;;; rime input method
(advice-add 'toggle-input-method
            :before 'creature/enable-rime)

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

;;; magit
;; (with-eval-after-load 'magit
;;   (require 'forge))
(setq magit-revision-show-gravatars
      '("^Author:     " . "^Commit:     "))

(global-undo-tree-mode)

(rg-enable-default-bindings)

(editorconfig-mode)

(provide 'init-utils)
