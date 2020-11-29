;; -*- coding: utf-8; lexical-binding: t; -*-

;;; mingus/mpd (music)
(creature/install-packages 'mingus)
(setq mingus-mode-line-separator " - ")
(global-set-key (kbd "C-c m") #'mingus)
(with-eval-after-load 'evil-core
  (dolist (func '(mingus-help-mode
                  mingus-browse-mode
                  mingus-playlist-mode))
    (advice-add func :after #'evil-emacs-state)))

(provide 'init-media)
