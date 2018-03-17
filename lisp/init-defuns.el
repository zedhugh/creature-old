;;; init-defuns.el --- functions

;;; Commentary:
;; all functions defined by myself.

;;; Code:

(require 'which-key)
(require 'evil-leader)
(defun creature/which-key-declare-prefixes (key doc &rest bind)
  "Define KEY's DOC with the same way of `evil-leader/set-key'.
BIND is rest sets of KEY and DOC."
  (while key
    (let ((key1 (concat evil-leader/leader key))
          (key2 (concat evil-leader/non-normal-prefix
                        evil-leader/leader " " key)))
      (which-key-add-key-based-replacements key1 doc)
      (which-key-add-key-based-replacements key2 doc))
    (setq key (pop bind)
          doc (pop bind))))

(require 'init-env)
(defun creature/indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (unless (member major-mode creature/indent-sensitive-modes)
    (save-excursion
      (if (region-active-p)
          (progn
            (indent-region (region-beginning) (region-end))
            (message "Indented selected region."))
        (progn
          (evil-indent (point-min) (point-max))
          (message "Indented buffer.")))
      (whitespace-cleanup))))

(unless (fboundp 'kill-current-buffer)
  (defun kill-current-buffer ()
    "Define this function for version before 26."
    (interactive)
    (kill-buffer (buffer-name))))

(require 'smartparens)
(defun creature/backward-kill-word-or-region (&optional arg)
  "Call `kill-region' when a region is active.
and `backward-kill-word' otherwise.  ARG is passed to
`backward-kill-word' if no region is active."
  (interactive "p")
  (if (featurep 'smartparens)
      (if (region-active-p)
          (call-interactively #'sp-kill-region)
        (sp-backward-kill-word arg))
    (if (region-active-p)
        (call-interactively #'kill-region)
      (backward-kill-word arg))))

(defun creature/open-init-file ()
  "Open init file."
  (interactive)
  (find-file (expand-file-name "init.el" user-emacs-directory)))

(provide 'init-defuns)
;;; init-defuns.el ends here
