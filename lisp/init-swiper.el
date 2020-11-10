(ivy-mode)
(counsel-mode)

(setq ivy-use-virtual-buffers t)
(setq ivy-use-selectable-prompt t)
(setq enable-recursive-minibuffers t)

;; smex freq file keep in cache directory
(unless (file-exists-p creature-cache)
  (make-directory creature-cache))
(setq smex-save-file
      (expand-file-name ".smex-items" creature-cache))
(amx-mode)
(setq amx-save-file (expand-file-name ".amx-items" creature-cache))

;; ivy pinyin search
;; let "ivy-read" support chinese pinyin
(require 'pinyinlib)
(defun re-builder-pinyin (str)
  (or (pinyin-to-utf8 str)
      (ivy--regex-plus str)
      (ivy--regex-ignore-order)))

(setq ivy-re-builders-alist '((t . re-builder-pinyin)))

(defun my-pinyinlib-build-regexp-string (str)
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
         (mapconcat 'my-pinyinlib-build-regexp-string
                    (remove nil
                            (mapcar 'my-pinyin-regexp-helper
                                    (split-string
                                     (replace-regexp-in-string "?" "" str)
                                     "")))
                    ""))
        nil))

;; remove "pinyin" match with this
;; (defun pinyin-to-utf8 (str) nil)

(defun creature/counsel-grep-or-swiper ()
  (interactive)
  (if (region-active-p)
      (let* ((begin (region-beginning))
             (end (region-end))
             (string (buffer-substring begin end)))
        (set-mark-command end)
        (counsel-grep-or-swiper string))
    (counsel-grep-or-swiper)))

(provide 'init-swiper)
