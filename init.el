;; package --- summary

;;; Commentary:
;; Entry of Emacs config.

;;; Code:
;; (package-initialize)

(let ((dir (file-name-directory buffer-file-name)))
  (let ((path (expand-file-name "lisp" dir)))
    (add-to-list 'load-path path)))

(require 'init-env)

;; (provide 'init)
;;; init.el ends here
