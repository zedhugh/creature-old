;;; init-env.el --- environment

;;; Commentary:

;; get and set environment variables Emacs running with.

;;; Code:

(defconst sys/win32p
  (eq system-type 'windows-nt)
  "Is the system is Windows?")

(defconst sys/graphicp
  (display-graphic-p)
  "Is Emacs run with graphic?")

(defconst creature/indent-sensitive-modes
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

(defconst creature/org-src-lang-modes
  '(("js"   . js2)
    ("html" . web))
  "Better src lang reflex to mode.")

(defconst creature/default-font
  '("Operator Mono Book" . 16)
  "Default font for single-byte code.")

(defconst creature/chinese-font
  (if sys/win32p
      '("SimSun" . 18)
    '("Emacs SimSun" . 18))
  "Default font for multi-byte code.")

(defconst creature-cache
  (expand-file-name ".cache" creature-dir)
  "Cache directory.")

(defconst creature/elpa
  '(("gnu"   . "https://elpa.gnu.org/packages/")
    ("org"   . "https://orgmode.org/elpa/")
    ("melpa" . "https://melpa.org/packages/"))
  "Foreign package sources.")

(defconst creature/elpa-cn
  '(("gnu-cn"   . "https://elpa.emacs-china.org/gnu/")
    ("org-cn"   . "https://elpa.emacs-china.org/org/")
    ("melpa-cn" . "https://elpa.emacs-china.org/melpa/"))
  "Chinese mirror for package sources.")

(provide 'init-env)
;;; init-env.el ends here
