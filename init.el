;; init.el --- entry

;;; Commentary:

;; Entry of Emacs config.
;; add load path for this way beacuse I don't want
;; make it's too long pre line.

;;; Code:
;; (package-initialize)

(let ((dir (file-name-directory buffer-file-name)))
  (let ((path (expand-file-name "lisp" dir)))
    (add-to-list 'load-path path)))

(require 'init-env)

;; (provide 'init)
;;; init.el ends here
