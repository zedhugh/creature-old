;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'package)

(setq package-selected-packages nil
      package-native-compile t
      ;; package-enable-at-startup nil

      ;; change this options need call `package-initialize', but `package-initialize' too slow
      package-user-dir (concat creature/config-dir "elpa-" emacs-version)
      package-gnupghome-dir (concat creature/config-dir "elpa-" emacs-version "/gnupg")

      package-quickstart t
      package-quickstart-file (concat creature/config-dir "package-quickstart-" emacs-version ".el")

      package-archives
      '(
        ;; ("gnu"    . "https://elpa.gnu.org/packages/")
        ;; ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ;; ("melpa"  . "https://melpa.org/packages/")

        ("gnu-cn"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("nongnu-cn" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
        ("melpa-cn"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ))

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

(provide 'init-elpa)
