;; -*- lexical-binding: t -*-

(require 'init-elpa)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          Highlight iindent guides                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(creature/maybe-require-package 'highlight-indent-guides)

(defvar creature-highlight-indentation t)

(defun highlight-indentation-enable ()
  (when (and (display-graphic-p) creature-highlight-indentation)
    (condition-case nil
        (progn
          (setq highlight-indent-guides-method      'column
                highlight-indent-guides-responsive  'top)
          (highlight-indent-guides-mode)
          (highlight-indent-guides-auto-set-faces))
      (error nil))))

(add-hook 'prog-mode-hook #'highlight-indentation-enable)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               Symbol-overlay                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(creature/require-package 'symbol-overlay)
;;; symbol-overlay-map
;; "i" -> symbol-overlay-put
;; "n" -> symbol-overlay-jump-next
;; "p" -> symbol-overlay-jump-prev
;; "w" -> symbol-overlay-save-symbol
;; "t" -> symbol-overlay-toggle-in-scope
;; "e" -> symbol-overlay-echo-mark
;; "d" -> symbol-overlay-jump-to-definition
;; "s" -> symbol-overlay-isearch-literally
;; "q" -> symbol-overlay-query-replace
;; "r" -> symbol-overlay-rename
(global-set-key (kbd "s-i") 'symbol-overlay-put)
(global-set-key (kbd "M-p") 'symbol-overlay-jump-prev)
(global-set-key (kbd "M-n") 'symbol-overlay-jump-next)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Rainbow packages                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(creature/require-package 'rainbow-delimiters)
(creature/require-package 'rainbow-identifiers)

(dolist (mode '(rainbow-delimiters-mode
                rainbow-identifiers-mode))
  (add-hook 'prog-mode-hook mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             Built-in packages                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; High light line
(global-hl-line-mode)

;; Show parens
(show-paren-mode)
(setq show-paren-when-point-in-periphery t)
(setq show-paren-when-point-inside-paren t)

(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (advice-remove 'show-paren-function 'ad-Advice-show-paren-function)
  (cond ((or
          (derived-mode-p 'python-mode)
          (looking-at-p "\\s("))
         (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))

;; Pulse
(defvar creature/pulse-enable t
  "Whether enable pulse for scroll and switch window.")

(defun creature/pulse-line (&rest _)
  "Pulse the current line."
  (when creature/pulse-enable
    (pulse-momentary-highlight-one-line (point))))

;; pulse setup, like beacon
(with-eval-after-load 'pulse
  (setq pulse-delay 0.04))

(dolist (command '(scroll-up
                   scroll-down
                   recenter))
  (advice-add command :after #'creature/pulse-line))
(add-to-list 'window-selection-change-functions #'creature/pulse-line)

(provide 'init-highlight)
