(defun creature/fontset (&optional frame)
  "Font sets for default and multi-byte code."
  ;; single-byte code
  (setq inhibit-compacting-font-caches t)
  (let ((family (car creature/default-font))
        (size (cdr creature/default-font)))
    (set-face-attribute 'default frame
                        :font (font-spec :family family :size size)))
  ;; multi-byte code
  (let ((family (car creature/chinese-font))
        (size (cdr creature/chinese-font)))
    (dolist (charset '(kana han cjk-misc bopomofo))
      (set-fontset-font t ;; (frame-parameter nil 'font)
                        charset
                        (font-spec :family family :size size) frame))))

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

;;; flycheck
;; flycheck is good at elisp
;; flycheck has some performance issue in Windows
(defun setup-flycheck ()
  (if (or sys/win32p (derived-mode-p 'emacs-lisp-mode))
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

;; define keybindings prompt for which-key
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
(put 'creature/which-key-declare-prefixes 'lisp-indent-function 'defun)

(defun creature/toggle-flycheck-error-list ()
  "Toggle flycheck's error list window.
If the error list is visible, hide it.  Otherwise, show and focus on it."
  (interactive)
  (-if-let (window (flycheck-get-error-list-window))
      (quit-window nil window)
    (flycheck-list-errors)
    (switch-to-buffer-other-window flycheck-error-list-buffer)))

(defun creature/desktop-read ()
  "Wrapper for `desktop-read'."
  (interactive)
  (unless (featurep 'desktop)
    (require 'desktop))
  (desktop-read creature-cache))

(defun creature/desktop-save ()
  "Wrapper for `desktop-save'."
  (interactive)
  (unless (featurep 'desktop)
    (require 'desktop))
  (desktop-save creature-cache))

(defun creature/editorconfig-enable ()
  "Enable `editorconfig-mode' once after open file."
  (editorconfig-mode)
  (delete 'creature/editorconfig-enable find-file-hook))

(provide 'init-funcs)
