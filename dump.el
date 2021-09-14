(defconst creature/config-dir
  (file-name-directory
   (or load-file-name buffer-file-name))
  "Root directory of Creature.")

(defconst creature/cache-dir
  (expand-file-name ".cache" creature/config-dir)
  "Cache directory of Creature.")

(defconst creature/sys-win32p
  (eq system-type 'windows-nt)
  "If system is Windows return t, therwise return nil.")

(defconst creature/prefix-key "M-m"
  "Prefix key for `creature-map'.")

(define-prefix-command 'creature-map)

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(let ((dir (file-name-directory (or load-file-name buffer-file-name))))
  ;; (load (expand-file-name "./init.el" dir))
  (load (expand-file-name "./lisp/init-elpa.el" dir))

  (setq creature/dump-load-path load-path)

  (dolist (package '(evil evil-matchit evil-surround evil-nerd-commenter))
    (require package))

  (dolist (package '(emms
                     hydra
                     pinentry
                     keyfreq
                     rime
                     forge
                     magit
                     gitattributes-mode
                     gitconfig-mode
                     gitignore-mode
                     rg
                     projectile
                     counsel-projectile
                     avy
                     undo-tree
                     youdao-dictionary
                     expand-region))
    (require package))

  ;; (dolist (package '(company company-posframe))
  ;;   (require package))

  (dolist (package '(cmake-mode vimrc-mode yaml-mode lua-mode company-lua nginx-mode company-nginx editorconfig saveplace-pdf-view pdf-tools))
    (require package))

  (dolist (package '(yasnippet yasnippet-snippets auto-yasnippet))
    (require package))

  (dolist (package '(counsel ivy swiper amx pinyinlib))
    (require package))

  (dolist (package '(org htmlize org-pomodoro org-contrib ox-hugo))
    (require package))

  (dolist (package '(circadian modus-themes page-break-lines highlight-indent-guides))
    (require package))

  (load (expand-file-name "./lisp/init-autoloads.el" dir))
  (load (expand-file-name "./lisp/init-theme.el" dir))
  (load (expand-file-name "./lisp/init-highlight.el" dir))
  (load (expand-file-name "./lisp/init-modeline.el" dir))
  (load (expand-file-name "./lisp/init-basic.el" dir))
  (load (expand-file-name "./lisp/init-utils.el" dir))
  (load (expand-file-name "./lisp/init-program.el" dir))
  (load (expand-file-name "./lisp/init-file.el" dir))
  ;; (load (expand-file-name "./lisp/init-company.el" dir))
  (load (expand-file-name "./lisp/init-swiper.el" dir))
  (load (expand-file-name "./lisp/init-misc.el" dir))
  (load (expand-file-name "./lisp/init-org.el" dir))
  (load (expand-file-name "./lisp/init-dired.el" dir))
  (load (expand-file-name "./lisp/init-ibuffer.el" dir))
  (load (expand-file-name "./lisp/init-hydra.el" dir))
  (load (expand-file-name "./lisp/init-tools.el" dir))
  (load (expand-file-name "./lisp/init-media.el" dir))
  (load (expand-file-name "./lisp/init-evil.el" dir))
  (load (expand-file-name "./lisp/init-keybindings.el" dir))
  (load (expand-file-name "./lisp/init-which-key.el" dir))
  (load (expand-file-name "./lisp/init-yasnippet.el" dir))
  )

(dump-emacs-portable "~/.emacs.d/.cache/emacs.pdmp")
