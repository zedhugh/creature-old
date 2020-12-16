;; -*- coding: utf-8; lexical-binding: t; -*-

(defconst creature/scratch-message
  (concat ";; Happy hacking "
          (or (user-login-name) "user")
          " - Emacs loves you.\n\n")
  "Customized initial scratch buffer message.")
(setq-default initial-scratch-message creature/scratch-message)

(setq initial-major-mode 'text-mode)
(run-with-idle-timer 3 nil
                     (lambda ()
                       (with-current-buffer "*scratch*"
                         (lisp-interaction-mode))))

(global-display-line-numbers-mode)

;;; folding
(add-hook 'prog-mode-hook 'hs-minor-mode)

;; address style
(add-hook 'erc-mode-hook 'goto-address-mode)
(add-hook 'text-mode-hook 'goto-address-mode)
(add-hook 'prog-mode-hook 'goto-address-prog-mode)

;; cursor style - box for readonly buffer, bar for others
(defun creature/cursor-style ()
  "Set `cursor-type' to `bar' with buffer local."
  (set (make-local-variable 'cursor-type)
       (if buffer-read-only t 'bar))
  (setq-local read-only-mode-hook
              (add-hook 'read-only-mode-hook
                        #'(lambda ()
                            (setq-local cursor-type
                                        (if buffer-read-only
                                            t
                                          'bar))))))

(dolist (hook '(prog-mode-hook
                text-mode-hook
                conf-unix-mode-hook
                conf-windows-mode-hook))
  (add-hook hook #'creature/cursor-style))

(add-hook 'prog-mode-hook
          (lambda ()
            (font-lock-add-keywords
             nil '(("\\<\\(FIXME\\|DEBUG\\|TODO\\):"
                    1 font-lock-warning-face prepend)))))

(global-hl-line-mode)

(provide 'init-misc)
