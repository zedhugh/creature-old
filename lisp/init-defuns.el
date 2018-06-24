;;; init-defuns.el --- functions

;;; Commentary:
;; all functions defined by myself.

;;; Code:

(defconst creature/indent-sensitive-modes
  '(asm-mode
    coffee-mode
    elm-mode
    haml-mode
    haskell-mode
    slim-mode
    makefile-mode
    makefile-bsdmake-mode
    makefile-gmake-mode
    makefile-imake-mode
    python-mode
    yaml-mode)
  "Modes which disable auto-indenting.")

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
    (interactive)
    (kill-buffer (buffer-name))))

(defun creature/open-init-file ()
  "Open init file."
  (interactive)
  (find-file (expand-file-name "init.el" creature-dir)))

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

(defun creature/fontset ()
  "Font sets for default and multi-byte code."
  ;; single-byte code
  (let ((family (car creature/default-font))
        (size (cdr creature/default-font)))
    (set-face-attribute 'default nil
                        :font (font-spec :family family :size size)))
  ;; multi-byte code
  (let ((family (car creature/chinese-font))
        (size (cdr creature/chinese-font)))
    (dolist (charset '(kana han cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font) charset
                        (font-spec :family family :size size)))))

(defun creature/emacsclient-setup (frame)
  "Fontset when emacs setup by emacsclient."
  (select-frame frame)
  (load-theme creature/theme t)
  (set-face-attribute 'font-lock-comment-face nil :slant 'italic)
  (when (window-system frame)
    (creature/fontset)))

(provide 'init-defuns)
;;; init-defuns.el ends here
