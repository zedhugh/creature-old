;; -*- coding: utf-8; lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  Flymake                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'init-elpa)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  Packages                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(creature/require-package 'flymake)
(creature/require-package 'flymake-eslint)
(creature/require-package 'eslint-disable-rule)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  flymake                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(with-eval-after-load 'flymake
  (setq flymake-mode-line-format
        '(" " flymake-mode-line-exception flymake-mode-line-counters))

  (define-key flymake-mode-map (kbd "C-c C-n") #'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "C-c C-p") #'flymake-goto-prev-error)
  (define-key flymake-diagnostics-buffer-mode-map
              [remap quit-window]
              (lambda () (interactive) (quit-window t))))

(add-hook 'flymake-mode-hook
          (lambda ()
            (creature/set-keys creature-map
                               "ex" #'flymake-show-diagnostic
                               "el" #'flymake-show-diagnostics-buffer-and-jump)))

(defun flymake-eslint-find-work-dir ()
  (let ((max-len 0)
        (curr-len 0)
        (temp-dir nil)
        (work-dir nil))
    (dolist (filename '(".eslintrc"
                        ".eslintrc.js"
                        ".eslintrc.cjs"
                        ".eslintrc.yaml"
                        ".eslintrc.yml"
                        ".eslintrc.json"
                        "package.json"))
      (setq temp-dir (locate-dominating-file buffer-file-name filename))
      (when (stringp temp-dir)
        (setq curr-len (string-bytes (file-truename temp-dir)))

        (when (> curr-len max-len)
          (setq max-len curr-len
                work-dir temp-dir))))
    work-dir))

(defun flymake-eslint-setup ()
  (when (derived-mode-p 'js-mode 'typescript-mode)
    (flymake-eslint-enable)
    (setq-local flymake-eslint-project-root (flymake-eslint-find-work-dir))))

;; (dolist (hook '(web-mode-hook typescript-mode-hook js-mode-hook))
;;   (add-hook hook #'flymake-eslint-setup 90))


(provide 'init-flymake)
