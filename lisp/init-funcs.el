(defun creature/open-init-file ()
  "Open init file."
  (interactive)
  (find-file (expand-file-name "init.el" creature-dir)))

(defun creature/open-early-init-org-file ()
  "Open init file."
  (interactive)
  (find-file (expand-file-name "creature.org" creature-dir)))

(defun creature/open-in-external-app (file-path)
  (if sys/win32p
      (w32-shell-execute "open" (replace-regexp-in-string "/" "\\\\" file-path))
    (start-process "" nil "xdg-open" file-path)))

(defun creature/open-file-or-directory-in-external-app (arg)
  (interactive "P")
  (if arg
      (creature/open-in-external-app (expand-file-name default-directory))
    (let ((file-path (if (derived-mode-p 'dired-mode)
                         (dired-get-file-for-visit)
                       buffer-file-name)))
      (if file-path
          (creature/open-in-external-app file-path)
        (message "No file associated to this buffer")))))

;;; indentation
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
          (indent-region (point-min) (point-max))
          (message "Indented buffer.")))
      (whitespace-cleanup))))

;;; company
(defun enable-ispell ()
  "Turn on spell prompt."
  (set (make-local-variable 'company-backends)
       (add-to-list 'company-backends 'company-ispell 'append)))

;; yasnippet
(defun creature/show-snippets-in-company (backend)
  (if (and (listp backend) (member 'company-yasnippet backend))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(defun add-yas ()
  "Add yasnippet to company popup menu."
  (set (make-local-variable 'company-backends)
       (mapcar 'creature/show-snippets-in-company company-backends)))

;;; dired
(defun creature/dired-toggle-read-only ()
  "Turn off icons in dired mode before edit file name."
  (interactive)
  (all-the-icons-dired-mode 'toggle)
  (dired-toggle-read-only))
(defun creature/wdired-finish-edit ()
  "Turn on icons in wdired after finish editing file name."
  (interactive)
  (wdired-finish-edit)
  (all-the-icons-dired-mode))
(defun creature/wdired-exit ()
  "Turn on icons in wdired after abort editing file name."
  (interactive)
  (wdired-exit)
  (all-the-icons-dired-mode))

;;; flycheck
(defun setup-flycheck ()
  (if (derived-mode-p 'emacs-lisp-mode)
      (flycheck-mode -1)
    (flycheck-mode)))

;;; modeline
(defun creature/set-mode-line-format-for-exist-buffers ()
  "Make customized mode line works in exist buffers."
  (mapc (lambda (buffer)
          (with-current-buffer buffer
            (setq mode-line-format creature/mode-line-format)))
        (buffer-list)))

;;; misc
;; kill buffer when calling quit-window.
(defun quit-window-and-kill-buffer ()
  "Kill buffer when quit-window."
  (interactive)
  (quit-window 'kill))

(defun creature/sudo-edit (&optional arg)
  (interactive "P")
  (let ((fname (if (or arg (not buffer-file-name))
                   (read-file-name "File: ")
                 buffer-file-name)))
    (find-file
     (cond ((string-match-p "^/ssh:" fname)
            (with-temp-buffer
              (insert fname)
              (search-backward ":")
              (let ((last-match-end nil)
                    (last-ssh-hostname nil))
                (while (string-match "@\\\([^:|]+\\\)" fname last-match-end)
                  (setq last-ssh-hostname (or (match-string 1 fname)
                                              last-ssh-hostname))
                  (setq last-match-end (match-end 0)))
                (insert (format "|sudo:%s" (or last-ssh-hostname "localhost"))))
              (buffer-string)))
           (t (concat "/sudo:root@localhost:" fname))))))

;;; emmet
(defun creature/emmet-expand ()
  "Expand at right way."
  (interactive)
  (if (bound-and-true-p yas-minor-mode)
      (call-interactively 'emmet-expand-yas)
    (call-interactively 'emmet-expand-line)))

(defun creature/set-keys (map key def &rest bindings)
  (while key
    (define-key map (kbd key) def)
    (setq key (pop bindings)
          def (pop bindings))))
(put 'creature/set-keys 'lisp-indent-function 'defun)

(provide 'init-funcs)