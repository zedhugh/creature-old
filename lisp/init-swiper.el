;; -*- coding: utf-8; lexical-binding: t; -*-

(setq enable-recursive-minibuffers t)

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
                           "\\*prettier"))
    (add-to-list 'ivy-ignore-buffers ignore-buffer))

  ;; ivy pinyin search
  ;; let "ivy-read" support chinese pinyin
  ;; (require 'pinyinlib)
  (defun re-builder-pinyin (str)
    (or (pinyin-to-utf8 str)
        (ivy--regex-plus str)
        (ivy--regex-ignore-order)))

  (setq ivy-re-builders-alist '((t . re-builder-pinyin)))

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

  ;; remove "pinyin" match with this
  ;; (defun pinyin-to-utf8 (str) nil)
  )

;; smex freq file keep in cache directory
(with-eval-after-load 'amx
  (unless (file-exists-p creature/cache-dir)
    (make-directory creature/cache-dir))

  (setq smex-save-file (expand-file-name ".smex-items" creature/cache-dir))

  (setq amx-save-file (expand-file-name ".amx-items" creature/cache-dir)))

(with-eval-after-load 'counsel
  (amx-mode)
  (ivy-mode)
  (counsel-mode))

(defun creature/counsel-grep-or-swiper ()
  (interactive)
  (if (region-active-p)
      (let* ((begin (region-beginning))
             (end (region-end))
             (string (buffer-substring begin end)))
        (set-mark-command end)
        (counsel-grep-or-swiper string))
    (counsel-grep-or-swiper)))

(global-set-key (kbd "C-s") #'creature/counsel-grep-or-swiper)

(when (fboundp 'counsel-M-x)
  (define-key global-map [remap execute-extended-command] #'counsel-M-x))

(when (fboundp 'counsel-describe-face)
  (define-key global-map [remap describe-face] #'counsel-describe-face))

(when (fboundp 'counsel-describe-function)
  (define-key global-map [remap describe-function] #'counsel-describe-function))

(when (fboundp 'counsel-describe-symbol)
  (define-key global-map [remap describe-symbol] #'counsel-describe-symbol))

(when (fboundp 'counsel-describe-variable)
  (define-key global-map [remap describe-variable] #'counsel-describe-variable))


(provide 'init-swiper)
