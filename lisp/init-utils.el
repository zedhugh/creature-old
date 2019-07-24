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

;;; rime input method
(cond
 ((eq system-type 'gnu/linux)
  (add-to-list 'load-path (expand-file-name "libs" user-emacs-directory))
  (require 'liberime)
  (liberime-start (expand-file-name "/usr/share/rime-data")
                  (expand-file-name "pyim/rime" creature-dir))
  (liberime-select-schema "luna_pinyin_simp")
  (setq pyim-default-scheme 'rime))
 (t nil))

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

(unless sys/win32p
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize))

(rg-enable-default-bindings)

(editorconfig-mode)

(provide 'init-utils)
