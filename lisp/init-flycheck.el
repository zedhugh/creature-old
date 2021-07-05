;; -*- coding: utf-8; lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Flycheck and Flymake                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'init-elpa)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                   Packages                                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(creature/require-package 'flycheck)
(creature/require-package 'flycheck-posframe)

(creature/require-package 'flymake)
(creature/require-package 'flymake-eslint)
(creature/require-package 'flymake-diagnostic-at-point)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                 flycheck                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun flycheck-posframe-setup ()
  (unless (bound-and-true-p lsp-ui-mode)
    (flycheck-posframe-mode)))

(defun creature/toggle-flycheck-error-list ()
  "Toggle flycheck's error list window.
If the error list is visible, hide it.  Otherwise, show and focus on it."
  (interactive)
  (-if-let (window (flycheck-get-error-list-window))
      (quit-window nil window)
    (flycheck-list-errors)
    (switch-to-buffer-other-window flycheck-error-list-buffer)))

(with-eval-after-load 'flycheck
  ;; (setq flycheck-emacs-lisp-load-path load-path)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (add-hook 'flycheck-mode-hook #'flycheck-posframe-setup)
  (define-key flycheck-mode-map (kbd "C-c C-n") #'flycheck-next-error)
  (define-key flycheck-mode-map (kbd "C-c C-p") #'flycheck-previous-error)

  (creature/set-keys creature-map
                     "el" 'creature/toggle-flycheck-error-list
                     "ex" 'flycheck-display-error-at-point))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  flymake                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(with-eval-after-load 'flymake
  (setq flymake-mode-line-format
        '(" " flymake-mode-line-exception flymake-mode-line-counters))

  (creature/set-keys creature-map
                     "ex" #'flymake-show-diagnostic
                     "el" #'flymake-show-diagnostics-buffer-and-jump)

  (require 'flymake-diagnostic-at-point)
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode)

  (define-key flymake-mode-map (kbd "C-c C-n") #'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "C-c C-p") #'flymake-goto-prev-error)
  (define-key flymake-diagnostics-buffer-mode-map
    [remap quit-window]
    (lambda () (interactive) (quit-window t))))

(defun flymake-eslint-setup ()
  (flymake-eslint-enable)
  (flymake-mode-on)
  (setq-local flymake-eslint-project-root
              (locate-dominating-file buffer-file-name ".eslintrc.js")))

;; (dolist (hook '(web-mode-hook typescript-mode-hook js-mode-hook))
;;   (add-hook hook #'flymake-eslint-setup 90))


(provide 'init-flycheck)
