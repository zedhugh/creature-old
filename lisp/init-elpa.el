;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'package)

(setq package-selected-packages nil
      package-native-compile t

      package-user-dir (concat creature/config-dir "elpa-" emacs-version)
      package-gnupghome-dir (concat creature/config-dir "elpa-" emacs-version "/gnupg")

      package-quickstart t
      package-quickstart-file (concat creature/config-dir "package-quickstart-" emacs-version ".el")

      package-archives
      '(
        ("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")

        ;; ("gnu-cn"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ;; ("nongnu-cn" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
        ;; ("melpa-cn"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ))

(defun creature-save-selected-packages (&optional value)
  "Set `package-selected-packages' to VALUE but do not save to `custom-file'."
  (when value
    (setq package-selected-packages value)))

(advice-add 'package--save-selected-packages :override #'creature-save-selected-packages)

(package-initialize)

(defun creature/require-package (package &optional min-version)
  "Ask elpa to install given PACKAGE."
  (cond
   ((package-installed-p package min-version)
    (add-to-list 'package-selected-packages package))
   ((assoc package package-archive-contents)
    (package-install package)
    (add-to-list 'package-selected-packages package))
   (t
    (package-refresh-contents)
    (creature/require-package package min-version))))

(defun creature/maybe-require-package (package &optional min-versioin)
  (condition-case err
      (creature/require-package package min-versioin)
    (error
     (message "Couldn't install optional package `': %S" package err)
     nil)))

(provide 'init-elpa)
