;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'init-elpa)

(creature/require-package 'marginalia)
(creature/require-package 'orderless)
(creature/require-package 'vertico)
(creature/require-package 'consult)
(creature/require-package 'embark)
(creature/require-package 'corfu)
(creature/require-package 'cape)
(creature/require-package 'corfu-doc)

(marginalia-mode 1)

(vertico-mode 1)
(vertico-indexed-mode 1)

(global-corfu-mode 1)
(add-hook 'corfu-mode-hook #'corfu-doc-mode)
(with-eval-after-load 'corfu
  (setq corfu-auto t
        corfu-auto-delay 0.05
        corfu-auto-prefix 2
        corfu-quit-no-match t)
  (creature/set-keys corfu-map
                     "SPC" #'corfu-insert-separator
                     "M-SPC" #'corfu-quick-complete)
  (global-set-key (kbd "C-'") #'cape-file))

(setq completion-styles '(orderless basic partial-completion flex)
      completion-category-overrides '((file (styles basic partial-completion))))

(creature/set-keys creature-map "fr" #'consult-recent-file)
(creature/set-keys minibuffer-local-map "C-s" #'consult-ripgrep)


(provide 'init-vertico)
