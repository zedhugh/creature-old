;; -*- coding: utf-8; lexical-binding: t; -*-

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

;; Do not blink cursor
(blink-cursor-mode -1)

(with-eval-after-load 'erc
  (setq erc-server "irc.libera.chat"
        erc-nick "zedhugh"
        erc-prompt-for-password nil

        erc-prompt-for-nickserv-password nil
        erc-use-auth-source-for-nickserv-password t

        erc-kill-buffer-on-part t
        erc-kill-queries-on-quit t
        erc-kill-server-buffer-on-quit t

        erc-autojoin-channels-alist '(("libera.chat" "#linuxba"))))


(provide 'init-misc)
