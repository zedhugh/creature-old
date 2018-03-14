;;; init-keybindings.el --- keybindings

;;; Commentary:

;; keybindings for defuns

;;; Code:

(global-set-key (kbd "C-M-\\") 'creature/indent-region-or-buffer)
(global-set-key (kbd "C-w") 'creature/backward-kill-word-or-region)
(evil-leader/set-key "fi" 'creature/open-init-file)

(provide 'init-keybindings)
;;; init-keybindings.el ends here
