;; define variales to keep environment
(defconst sys/win32p
  (eq system-type 'windows-nt)
  "If system is Windows return t, therwise return nil.")

(defconst creature-dir
  (expand-file-name ".." (file-name-directory
                          (or load-file-name buffer-file-name)))
  "Root directory of creature.")

(defconst creature-cache
  (expand-file-name ".cache" creature-dir)
  "Cache directory.")

;; make gc threshold to a big value to reduce initialize
;; time, and when emacs session startup, make gc threshold
;; to be a best value.
(defconst creature/best-gc-cons-threshold
  (if sys/win32p
      (* 512 1024 1024)
    4000000)
  "Best default gc threshold value. Should't be to big.")

(defconst creature/scratch-message
  (concat ";; Happy hacking "
          (or (user-login-name) "user")
          " - Emacs loves you.\n\n")
  "Customized initial scratch buffer message.")

;; font config
(defconst creature/default-font
  ;; '("Operator Mono Book" . 16)
  '("Sarasa Mono SC" . 16)
  ;; '("Source Code Pro" . 16)
  "Default font for single-byte code.")

(defconst creature/chinese-font
  '("Sarasa Mono SC" . 16)
  ;; (if sys/win32p
  ;;     '("SimSun" . 18)
  ;;   '("Emacs SimSun" . 18))
  "Default font for multi-byte code.")

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

;;; code block
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

(provide 'init-options)
;;; init-options.el ends here
