;; Functions
(defun my/open-current-config-dot-el ()
  (interactive)
  (find-file "~/.nixmacs/config/e.el"))
(defun my/help-runner-func ()
  (interactive)
  (help))
(defun my/interactive-package-menu ()
  (interactive)
  (package-list-packages))

;; Hydra Menu
(defhydra my/quick-cmd-menu-hydra (:color blue :hint nil)
  "
Press Key:
  _n_: Toggle Line Numbers
  _s_: Open Scratch Buffer
  _h_: Launch Interactive Help
  _p_: Package List
  _c_: Open Current Config
"
  ("n" my/toggle-line-numbers)
  ("s" my/launch-scratch-buffer)
  ("c" my/open-current-config-dot-el)
  ("h" my/help-runner-func)
  ("p" my/interactive-package-menu)
  ("q" nil "quit"))

;; Keybinds
(global-set-key (kbd "C-S-h") #'my/help-runner-func)
(global-set-key (kbd "C-c h") #'my/quick-cmd-menu-hydra/body)
