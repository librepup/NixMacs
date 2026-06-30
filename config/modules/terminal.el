;; Functions
(defun my-term-setup ()
  (define-key term-raw-map (kbd "C-c o") #'other-window)
  (define-key term-raw-map (kbd "C-c b") #'switch-to-buffer)
  (define-key term-raw-map (kbd "C-c 1") #'delete-other-windows)
  (define-key term-raw-map (kbd "C-c 3") #'split-window-right)
  (define-key term-raw-map (kbd "C-c 2") #'split-window-below))

(defun my-new-term ()
  "Open a new terminal in the current window, prompting for shell."
  (interactive)
  (let* ((default-shell (or (and (boundp 'shell-file-name) shell-file-name)
                            "bash"))
         (shell (read-shell-command "Run shell: " default-shell))
         (term-buffer-name (generate-new-buffer-name "*term*")))
    (term shell)
    (rename-buffer term-buffer-name)))

(defun setup-term-ctrl-x-mirror ()
  (interactive)
  (cond
   ((derived-mode-p 'term-mode)
    (define-key term-mode-map (kbd "C-<XF86Tools>") ctl-x-map)
    (define-key term-raw-map (kbd "C-<XF86Tools>") ctl-x-map)
    (message "C-<XF86Tools> → C-x  (term-mode)"))
   ((derived-mode-p 'vterm-mode)
    (define-key vterm-mode-map (kbd "C-<XF86Tools>") ctl-x-map)
    (message "C-<XF86Tools> → C-x  (vterm-mode)"))
   (t
    (user-error "Not in a Terminal Buffer (term-mode or vterm-mode)."))))

;; Hooks
(add-hook 'term-mode-hook 'my-term-setup)
(add-hook 'term-mode-hook  #'setup-term-ctrl-x-mirror)
(add-hook 'vterm-mode-hook #'setup-term-ctrl-x-mirror)

;; Keybinds
(global-set-key (kbd "C-c <return>") #'my-new-term)
