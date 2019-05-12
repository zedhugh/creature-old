;;; org pomodoro
(when sys/win32p
  (with-eval-after-load 'org-pomodoro
    (setq org-pomodoro-audio-player "mplayer")))

;; show inline image when open org file
(add-hook 'org-mode-hook 'org-display-inline-images)

(with-eval-after-load 'org
  ;; enable scale image
  (setq org-image-actual-width nil)

  ;; config latex preview
  (setq org-preview-latex-default-process 'dvipng)
  (setq org-preview-latex-image-directory
        (expand-file-name "ltximg/" creature-cache))

  ;; don't prompt before eval code
  (setq org-confirm-babel-evaluate nil)

  ;; sub-superscripts
  (setq org-export-with-sub-superscripts '{})

  ;; make options configged before work
  (org-babel-do-load-languages
   'org-babel-load-languages
   creature/org-src-enable-lang)
  (dolist (src2mode creature/org-src-lang-modes)
    (add-to-list 'org-src-lang-modes src2mode)))

(provide 'init-org)
