;; -*- coding: utf-8; lexical-binding: t; -*-

(with-eval-after-load 'dired
  ;; (require 'dired-x)
  (setq dired-dwim-target t)

  ;; show file size human readable
  (setq dired-listing-switches "-aghG")

  ;; copy and delete directory recursive
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)

  ;; don't make too many dired buffer
  (put 'dired-find-alternate-file 'disabled nil))

(provide 'init-dired)
