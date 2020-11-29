;; -*- coding: utf-8; lexical-binding: t; -*-

;; disable menu, toolbar and scroll bar.
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; maximized window with alpha
(add-to-list 'default-frame-alist '(alpha . 90))
(add-to-list 'default-frame-alist '(fullscreen .maximized))

;; turn off startup screen
(setq inhibit-splash-screen t)

;; disable bell
(setq ring-bell-function 'ignore)
(setq visible-bell nil)

;; Keep cursor at end of lines when prev
;; position of cursor is at the end.
;; Require line-move-visual is nil.
(setq track-eol t)
(setq line-move-visual t)

;; disable gtk tooltips
(setq x-gtk-use-system-tooltips nil)
