;; -*- coding: utf-8; lexical-binding: t; -*-

(creature/require-package 'hydra)

(defhydra hydra-window (:hint nil)
  "
^Jump^       ^Operator^
------------------------------------------------
_j_:down     _{_:height     _}_:height
_k_:up       _[_:width      _]_:width
_h_:left     _d_:delete     _=_:balance
_l_:right    _/_:right      _m_:maxmium
_p_:prev     _-_:below      _q_:quit
_n_:next
"
  ("d" delete-window)
  ("/" split-window-right)
  ("-" split-window-below)
  ("=" balance-windows)
  ("j" windmove-down)
  ("k" windmove-up)
  ("h" windmove-left)
  ("l" windmove-right)
  ("m" delete-other-windows :exit t)
  ("n" other-window)
  ("p" (other-window -1))
  ("[" shrink-window-horizontally)
  ("]" enlarge-window-horizontally)
  ("{" shrink-window)
  ("}" enlarge-window)
  ("q" nil))

(provide 'init-hydra)
