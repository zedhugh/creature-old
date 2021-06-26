;; -*- coding: utf-8; lexical-binding: t; -*-

(creature/require-package 'emms)

(with-eval-after-load 'emms-player-mpd
  (add-to-list 'emms-info-functions #'emms-info-mpd)
  (add-to-list 'emms-info-functions #'emms-info-mpd-process)
  (add-to-list 'emms-player-list 'emms-player-mpd)

  (require 'emms-volume)
  (setq emms-volume-change-function #'emms-volume-mpd-change))

(provide 'init-media)
