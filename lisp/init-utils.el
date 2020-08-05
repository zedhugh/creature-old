;; rime
(install-packages 'rime)
(setq rime-emacs-module-header-root "/usr/include/emacs-28-vcs")
(setq default-input-method "rime")
(with-eval-after-load 'rime
  (setq rime-show-candidate 'minibuffer)
  (setq rime-show-candidate 'posframe)
  (setq rime-posframe-style 'simple)
  (setq rime-posframe-fixed-position t)
  (setq rime-disable-predicates
        (if (featurep 'evil)
            '(rime-predicate-prog-in-code-p
              rime-predicate-evil-mode-p
              rime-predicate-hydra-p)
          '(rime-predicate-prog-in-code-p
            rime-predicate-hydra-p)))

  (define-key rime-mode-map (kbd "M-i") 'rime-force-enable)
  (define-key rime-active-mode-map (kbd "M-i") 'rime-inline-ascii))

;;; magit
;; (with-eval-after-load 'magit
;;   (require 'forge))
(setq magit-revision-show-gravatars
      '("^Author:     " . "^Commit:     "))

(global-undo-tree-mode)

(rg-enable-default-bindings)

(editorconfig-mode)

(provide 'init-utils)
