;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'init-elpa)

(creature/require-package 'emms)

;; (with-eval-after-load 'emms-player-mpd
;;   (setq emms-player-mpd-music-directory "/var/lib/mpd/music")
;;   (add-to-list 'emms-info-functions #'emms-info-mpd)
;;   (add-to-list 'emms-info-functions #'emms-info-mpd-process)
;;   (add-to-list 'emms-player-list 'emms-player-mpd)

;;   (require 'emms-volume)
;;   (setq emms-volume-change-function #'emms-volume-mpd-change))

(with-eval-after-load 'emms-lyrics
  (setq emms-lyrics-dir "/home/zedhugh/.lyrics"))

(with-eval-after-load 'emms-source-file
  (setq emms-source-file-default-directory "/var/lib/mpd/music"))

(with-eval-after-load 'emms-playlist-mode
  (define-key emms-playlist-mode-map (kbd "=") #'emms-volume-raise))

(defun creature-emms-setup ()
  (interactive)
  (emms-all)
  (emms-default-players))

(provide 'init-media)
