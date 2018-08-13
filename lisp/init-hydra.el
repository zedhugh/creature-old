(defhydra hydra-zoom ()
  "zoom"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out")
  ("q" nil "quit" :exit t))

(global-set-key (kbd "<f5>") 'hydra-zoom/body)

(defhydra hydra-launcher (:color blue
                                 :hint nil)
  "
^Emms^       ^Misc^
------------------------------------------------
_r_andom     _t_erm             _E_nable/Disable
_n_ext       _a_utoComplete     _V_intage/Modern
_p_revious   _C_reate workgroup Open recent _f_ile
_P_ause      _l_oad workgroup   Recent _d_irectory
_O_pen       _B_ookmark         Last dired _c_ommand
_L_ Playlist Goto book_m_ark    Dired comand _h_istory
_S_huffle    Undo _v_isualize   _b_ack
_q_uit
"
  ("c" my-dired-redo-last-command)
  ("h" my-dired-redo-from-commands-history)
  ("B" bookmark-set)
  ("m" counsel-bookmark-goto)
  ("f" my-counsel-recentf)
  ("d" counsel-recent-directory)
  ("C" wg-create-workgroup)
  ("l" my-wg-switch-workgroup)
  ("t" ansi-term)
  ("a" toggle-company-ispell)
  ("E" toggle-typewriter)
  ("V" twm/toggle-sound-style)
  ("v" undo-tree-visualize)
  ("r" emms-random)
  ("n" emms-next)
  ("p" emms-previous)
  ("P" emms-pause)
  ("O" emms-play-playlist)
  ("b" back-to-previous-buffer)
  ("L" emms-playlist-mode-go)
  ("S" (progn (emms-shuffle) (emms-random)))
  ("q" nil))

(defhydra hydra-window (:hint nil)
  "
^Jump^       ^Operator^     ^Move^
------------------------------------------------
_j_:down     _d_:delete     _J_:bottom
_k_:up       _/_:right      _K_:top
_h_:left     _-_:below      _H_:left
_l_:right    _m_:maxmium    _L_:right
_p_:prev     _=_:balance    _<_:height    _>_:height
_n_:next     _q_:quit       _[_:width     _]_:width
"
  ("d" delete-window)
  ("/" split-window-right)
  ("-" split-window-below)
  ("=" balance-windows)
  ("j" evil-window-down)
  ("J" evil-window-move-very-bottom)
  ("k" evil-window-up)
  ("K" evil-window-move-very-top)
  ("h" evil-window-left)
  ("H" evil-window-move-far-left)
  ("l" evil-window-right)
  ("L" evil-window-move-far-right)
  ("m" delete-other-windows)
  ("n" evil-window-next)
  ("p" evil-window-prev)
  ("[" evil-window-decrease-width)
  ("]" evil-window-increase-width)
  ("<" evil-window-decrease-height)
  (">" evil-window-increase-height)
  ("q" nil))

(evil-leader/set-key
  "w" 'hydra-window/body)

(provide 'init-hydra)
