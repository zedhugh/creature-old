;;; init-defuns.el --- functions

;;; Commentary:
;; all functions defined by myself.

;;; Code:



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





(defun creature/open-init-file ()
  "Open init file."
  (interactive)
  (find-file (expand-file-name "init.el" creature-dir)))











(provide 'init-defuns)
;;; init-defuns.el ends here
