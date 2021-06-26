;; -*- coding: utf-8; lexical-binding: t; -*-

(creature/require-package 'htmlize)
(creature/require-package 'org-pomodoro)
(creature/require-package 'org-contrib)
(creature/require-package 'ox-hugo)

;; customize mode for src lang
(defconst creature/org-src-lang-modes
  '(("js"   . js)
    ("ts"   . typescript)
    ("html" . web))
  "Better src lang reflex to mode.")

;; enable code block in org file
(defconst creature/org-src-enable-lang
  '((C          . t)
    (js         . t)
    (latex      . t)
    (shell      . t)
    (python     . t)
    (emacs-lisp . t))
  "Enabled lang in org src code block.")

(when creature/sys-win32p
  (with-eval-after-load 'org-pomodoro
    (setq org-pomodoro-audio-player "mplayer")))

;; 保存链接
(defun creature/org-capture-setup ()
  (require 'org-capture)
  (require 'org-protocol)
  (setq org-capture-templates
        '(("" "org-protocol" entry (file "~/org/bookmarks.org")
           "* TODO Review %a\n  %T:initial\n" :immediate-finish t)
          ))
  (setq org-protocol-default-template-key ""))
(run-with-idle-timer 10 nil #'creature/org-capture-setup)
(with-eval-after-load 'org
  ;; show inline image when open org file
  (creature/org-capture-setup)
  (add-hook 'org-mode-hook 'org-display-inline-images)

  ;; org agenda
  (setq org-agenda-files '("~/org"))
  (global-set-key (kbd "C-c a") 'org-agenda)
  ;; enable scale image
  (setq org-image-actual-width nil)

  ;; config latex preview
  (setq org-preview-latex-default-process 'dvipng)
  (setq org-preview-latex-image-directory
        (expand-file-name "ltximg/" creature/cache-dir))

  ;; don't prompt before eval code
  (setq org-confirm-babel-evaluate nil)

  ;; sub-superscripts
  (setq org-export-with-sub-superscripts '{})

  ;; make options configged before work
  (org-babel-do-load-languages
   'org-babel-load-languages
   creature/org-src-enable-lang)
  (dolist (src2mode creature/org-src-lang-modes)
    (add-to-list 'org-src-lang-modes src2mode))

  (define-key org-mode-map (kbd "RET") 'org-return-indent))

(with-eval-after-load 'ox
  (require 'ox-hugo))

(provide 'init-org)
