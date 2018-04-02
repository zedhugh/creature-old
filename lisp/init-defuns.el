;;; init-defuns.el --- functions

;;; Commentary:
;; all functions defined by myself.

;;; Code:

(defun creature/which-key-declare-prefixes (key doc &rest bind)
  "Define KEY's DOC with the same way of `evil-leader/set-key'.
BIND is rest sets of KEY and DOC."
  (while key
    (let ((key1 (concat evil-leader/leader " " key))
          (key2 (concat evil-leader/non-normal-prefix
                        evil-leader/leader " " key)))
      (which-key-add-key-based-replacements key1 doc)
      (which-key-add-key-based-replacements key2 doc))
    (setq key (pop bind)
          doc (pop bind))))

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
  (find-file (expand-file-name "init.el" creature-dir)))

(defun add-company-web-backend ()
  "Add company-web to company backends."
  (set (make-local-variable 'company-backends)
       (push 'company-web-html company-backends)))

(defun add-tern ()
  "Add tern to company backends."
  (set (make-local-variable 'company-backends)
       (push 'company-tern company-backends)))

(defun creature/emmet-expand ()
  "Expand at right way."
  (interactive)
  (if (bound-and-true-p yas-minor-mode)
      (call-interactively 'emmet-expand-yas)
    (call-interactively 'emmet-expand-line)))

(defun add-yas ()
  "Add yasnippet to company popup menu."
  (let ((backends company-backends))
    (set (make-local-variable 'company-backends) nil)
    (dolist (backend backends)
      (add-to-list 'company-backends
                   (cons backend
                         '(:with company-yasnippet))
                   'append))))

(defun creature/pyim-greatdict-enable ()
  "Enable a big dict for pyim."
  (let ((greatdict
         (concat creature-dir
                 "pyim-dicts/pyim-greatdict.pyim.gz")))
    (if (featurep 'pyim)
        (pyim-extra-dicts-add-dict
         `(:name "Greatdict-elpa"
                 :file ,greatdict
                 :coding utf-8-lang
                 :dict-type pinyin-dict))
      nil)))

(provide 'init-defuns)
;;; init-defuns.el ends here
