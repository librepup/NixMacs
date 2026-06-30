;; Tabs
(tab-bar-mode 1)
(setq tab-bar-show 1)
(setq tab-bar-new-tab-button-show nil)
(setq tab-bar-close-button-show nil)

(set-face-attribute 'tab-bar nil
                    :height 0.5
                    :box nil)

(set-face-attribute 'tab-bar-tab nil
                    :box '(:line-width 1 :color "#282828")
                    :weight 'normal)

(set-face-attribute 'tab-bar-tab-inactive nil
                    :box '(:line-width 1 :color "#1d1f21")
                    :weight 'normal)

(set-face-attribute 'tab-bar nil :height 1.0)

(global-set-key (kbd "C-c t") #'tab-bar-new-tab)
(global-set-key (kbd "C-c w") #'tab-bar-close-tab)
(global-set-key (kbd "C-c <tab>") #'tab-bar-switch-to-next-tab)
(global-set-key (kbd "C-c <backtab>") #'tab-bar-switch-to-prev-tab)

(defun my/tab-bar-toggle ()
  "Toggle the visibility of the Emacs tab-bar."
  (interactive)
  (if (or (eq tab-bar-show 1) (eq tab-bar-show t))
      (setq tab-bar-show 0)
    (setq tab-bar-show 1)))

(tab-bar-mode 1)
(global-set-key (kbd "C-c C-t") #'my/tab-bar-toggle)
;; vim-tab-bar-mode is not defined in this config; commented out to avoid load errors
;; (vim-tab-bar-mode)
