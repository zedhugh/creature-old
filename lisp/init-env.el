;;; init-env.el --- environment

;;; Commentary:

;; get and set environment Emacs running with.

;;; Code:

(defconst sys/win32p
  (eq system-type 'windows-nt)
  "Is the system is Windows?")

(defconst sys/graphicp
  (display-graphic-p)
  "Is Emacs run with graphic?")

(defvar creature/indent-sensitive-modes
  '(asm-mode
    coffee-mode
    elm-mode
    haml-mode
    haskell-mode
    slim-mode
    makefile-mode
    makefile-bsdmake-mode
    makefile-gmake-mode
    makefile-imake-mode
    python-mode
    yaml-mode)
  "Modes which disable auto-indenting.")

(defvar creature/default-font
  '("Operator Mono Book" . 16)
  "Default font for single-byte code.")

(defvar creature/chinese-font
  '("Emacs SimSum" . 16)
  "Default font for multi-byte code.")

(provide 'init-env)
;;; init-env.el ends here
