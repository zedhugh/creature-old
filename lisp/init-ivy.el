;;; init-ivy.el --- ivy packages

;;; Commentary:

;; packages for ivy

;;; Code:

(counsel-mode)
(evil-leader/set-key
  "fr" 'counsel-recentf)


(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq ivy-use-selectable-prompt t)
(setq enable-recursive-minibuffers t)

;; ivy-rich
(setq ivy-rich--display-transformers-list
      '(ivy-switch-buffer
        (:columns
         ((ivy-rich-candidate
           (:width 30))
          (ivy-rich-switch-buffer-size
           (:width 7))
          (ivy-rich-switch-buffer-indicators
           (:width 4 :face error :align right))
          (ivy-rich-switch-buffer-major-mode
           (:width 20 :face warning))
          (ivy-rich-switch-buffer-project
           (:width 15 :face success))
          (ivy-rich-switch-buffer-path
           (:width
            (lambda (x)
              (ivy-rich-switch-buffer-shorten-path
               x
               (ivy-rich-minibuffer-width 0.3))))))
         :predicate
         (lambda
           (cand)
           (get-buffer cand)))
        counsel-M-x
        (:columns
         ((counsel-M-x-transformer
           (:width 40))
          (ivy-rich-counsel-function-docstring
           (:face font-lock-doc-face))))
        counsel-describe-function
        (:columns
         ((counsel-describe-function-transformer
           (:width 40))
          (ivy-rich-counsel-function-docstring
           (:face font-lock-doc-face))))
        counsel-describe-variable
        (:columns
         ((counsel-describe-variable-transformer
           (:width 40))
          (ivy-rich-counsel-variable-docstring
           (:face font-lock-doc-face))))
        counsel-recentf
        (:columns
         ((ivy-rich-candidate
           (:width 0.8))
          (ivy-rich-file-last-modified-time
           (:face font-lock-comment-face))))))
(ivy-rich-mode)
(setq ivy-virtual-abbreviate 'full)
(setq ivy-rich-switch-buffer-align-virtual-buffer t)
(setq ivy-rich-path-style 'abbrev)

(global-set-key (kbd "C-s") 'swiper)

;; smex: record freq for command

(unless (file-exists-p creature-cache)
  (make-directory creature-cache))
(setq smex-save-file
      (expand-file-name ".smex-items" creature-cache))

;; let `ivy-read' support chinese pinyin
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

;; remove `pinyin' match with this
;; (defun pinyin-to-utf8 (str) nil)

(provide 'init-ivy)
;;; init-ivy.el ends here
