;;; init-keybindings.el --- keybindings

;;; Commentary:

;; keybindings for defuns

;;; Code:

(global-set-key (kbd "C-M-\\") 'creature/indent-region-or-buffer)
(global-set-key (kbd "C-w") 'creature/backward-kill-word-or-region)
(evil-leader/set-key "fi" 'creature/open-init-file)
(evil-leader/set-key "fo" 'creature/open-file-or-directory-in-external-app)
(global-set-key (kbd "s-v") 'clipboard-yank)
(global-set-key (kbd "s-c") 'clipboard-kill-ring-save)

(provide 'init-keybindings)
;;; init-keybindings.el ends here
