;; -*- coding: utf-8; lexical-binding: t; -*-

(creature/require-package 'counsel)
(creature/require-package 'ivy)
(creature/require-package 'swiper)
(creature/require-package 'amx)
(creature/require-package 'pinyinlib)

(setq enable-recursive-minibuffers t)

;; ivy pinyin search
;; let "ivy-read" support chinese pinyin
;; (require 'pinyinlib)
(defun re-builder-pinyin (str)
  (or (pinyin-to-utf8 str)
      (ivy--regex-plus str)
      (ivy--regex-ignore-order)))

(defun creature/pinyinlib-build-regexp-string (str)
  (progn
    (cond ((equal str ".*") ".*")
          (t (pinyinlib-build-regexp-string str t)))))

(defun my-pinyin-regexp-helper (str)
  (cond ((equal str " ") ".*")
        ((equal str "") nil)
        (t str)))

(defun pinyin-to-utf8 (str)
  (cond ((equal 0 (length str))nil)
        ((equal (substring str 0 1) "?")
         (mapconcat 'creature/pinyinlib-build-regexp-string
                    (remove nil
                            (mapcar 'my-pinyin-regexp-helper
                                    (split-string
                                     (replace-regexp-in-string "?" "" str)
                                     "")))
                    ""))
        nil))

(with-eval-after-load 'ivy
  (amx-mode)
  (ivy-mode)
  (counsel-mode)

  (setq ivy-use-virtual-buffers t)
  (setq ivy-use-selectable-prompt t)

  (dolist (ignore-buffer '("::stderr\\*"
                           "\\*lsp-log\\*"
                           "\\*clangd\\*"
                           "-ls\\*"
                           "\\*tide-"
                           "^\\*EGLOT.*events\\*$"
                           "\\*prettier"))
    (add-to-list 'ivy-ignore-buffers ignore-buffer))

  (setq ivy-re-builders-alist '((t . re-builder-pinyin)))

  ;; remove "pinyin" match with this
  ;; (defun pinyin-to-utf8 (str) nil)
  )

;; smex freq file keep in cache directory
(with-eval-after-load 'amx
  (unless (file-exists-p creature/cache-dir)
    (make-directory creature/cache-dir))

  (setq smex-save-file (expand-file-name ".smex-items" creature/cache-dir))

  (setq amx-save-file (expand-file-name ".amx-items" creature/cache-dir)))

(defun creature/counsel-grep-or-swiper ()
  (interactive)
  (if (region-active-p)
      (let* ((begin (region-beginning))
             (end (region-end))
             (string (buffer-substring begin end)))
        (set-mark-command end)
        (counsel-grep-or-swiper string))
    (counsel-grep-or-swiper)))

(with-eval-after-load 'counsel
  (amx-mode)
  (ivy-mode)
  (define-key counsel-mode-map (kbd "C-s") #'creature/counsel-grep-or-swiper)
  (creature/set-keys creature-map "fr" 'counsel-recentf))

(counsel-mode)

(provide 'init-swiper)
