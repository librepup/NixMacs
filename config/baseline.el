;; Imports/Includes
(require 'hydra)
(require 'doom-modeline)
(require 'fancy-dabbrev)
(require 'ansi-color)
(require 'company)
(require 'lsp-mode)
(require 'nickel-mode)
(require 'hoon-mode)
(require 'multiple-cursors)
(require 'dired)
(require 'simple-httpd)
(require 'impatient-mode)
(require 'bongo)
(require 'lsp-ui)
(require 'rustic)

;; Conditional Module Loading
(defvar my/nixmacs-config-files
  '("~/.nixmacs/config/modules/splashscreen.el"
    "~/.nixmacs/config/modules/settings.el"
    "~/.nixmacs/config/modules/ansi.el"
    "~/.nixmacs/config/modules/orgmode.el"
    "~/.nixmacs/config/modules/inspector.el"
    "~/.nixmacs/config/modules/modes.el"
    "~/.nixmacs/config/modules/help.el"
    "~/.nixmacs/config/modules/lsp.el"
    "~/.nixmacs/config/modules/tabs.el"
    "~/.nixmacs/config/modules/emms.el"
    "~/.nixmacs/config/modules/terminal.el"))

(defun my/import-config-files-dolist ()
  "Import all configuration files listed in `my/nixmacs-config-files'."
  (interactive)
  (dolist (file my/nixmacs-config-files)
    (load file)))

(defun my/import-config-files-mapcar ()
  "Import all configuration files listed in `my/nixmacs-config-files'."
  (interactive)
  (mapcar (lambda (file) (load file)) my/nixmacs-config-files))

;; Load config modules synchronously so hooks (e.g. splash screen)
;; are registered before Emacs finishes starting up.
(my/import-config-files-dolist)

;; Module Confirmation
(defun check-import-success ()
  "Check if any of the configuration files were successfully loaded."
  (interactive)
  (let ((successful-loaded (some #'load my/nixmacs-config-files)))
    (if successful-loaded
        (message "Successfully loaded %d config file(s)." (length my/nixmacs-config-files))
      (let ((error-popup (make-instance 'popup :title "Error Loading Modular Config"
                                       :min-width 300
                                       :min-height 200)))
        (with-eval-after-load 'popup
          (popup-set-text error-popup "Error Loading Modular Config")
          (popup-show error-popup))))))

;; Inspector
(global-set-key (kbd "C-c i") #'my/config-inspector)

;; Modeline
(doom-modeline-mode 1)

;; Windows
(global-set-key (kbd "C-S-<up>") 'shrink-window)
(global-set-key (kbd "C-S-<down>") 'enlarge-window)
(global-set-key (kbd "C-S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-S-<right>") 'enlarge-window-horizontally)

;; Frame
(setq frame-title-format
      '("" invocation-name ": "
        (:eval
         (if buffer-file-name
             (abbreviate-file-name buffer-file-name)
           "%b"))))

;; Various Keybinds
(global-set-key (kbd "C-c h") 'help-command)
(global-set-key (kbd "C-h") 'backward-kill-word)
(global-set-key (kbd "M-[ 3 ; 5 ~") 'backward-kill-word)

;; DAbbrev
(global-fancy-dabbrev-mode)
(global-set-key (kbd "TAB") 'fancy-dabbrev-expand)
(global-set-key (kbd "<backtab>") 'fancy-dabbrev-backward)

;; Sudo Edit
(global-set-key (kbd "C-x e") #'sudo-edit)

;; Company
(global-company-mode 1)
(setq company-idle-delay 0.1
      company-minimum-prefix-length 1)

;; Auto-Saves
(make-directory "~/.nixmacs/autosaves" t)
(setq auto-save-file-name-transforms
      `((".*" "~/.nixmacs/autosaves/" t)))
(setq delete-auto-save-files t)

;; Rainbow Mode
(define-globalized-minor-mode my-global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))

(my-global-rainbow-mode 1)

;; Backspace
(define-key mc/keymap (kbd "DEL") 'mc/backspace)

;; Bongo
(setq bongo-default-browser-function 'bongo-dired-browser)
(setq bongo-enabled-backends '(mpv))
(setq bongo-default-backend 'mpv)
(setq bongo-mpv-program "mpv"
    bongo-mpv-default-options '("--no-video"))
(defun my-bongo-autoload-directory ()
  (when (and (eq major-mode 'bongo-playlist-mode)
             (= (buffer-size) 0))
    (bongo-insert-directory "~/Music")))

(add-hook 'bongo-playlist-mode-hook #'my-bongo-autoload-directory)

;; ERC
(setq erc-server "irc.libera.chat"
      erc-nick "nixpup"
      erc-user-full-name "nixpup"
      erc-track-shorten-start 8
      erc-autojoin-channels-alist '(("irc.libera.chat" "#nixos"))
      erc-kill-buffer-on-part t
      erc-auto-query 'bury)

;; Tab Completion
(defun my/fancy-dabbrev-tab ()
  "Expand with fancy-dabbrev on TAB."
  (global-set-key (kbd "TAB") 'fancy-dabbrev-expand))

(add-hook 'prog-mode-hook 'my/fancy-dabbrev-tab)
(add-hook 'text-mode-hook 'my/fancy-dabbrev-tab)

;; HTML
(defun my/html-live-preview ()
  "Start local HTTP server, enable impatient-mode, and open preview in browser."
  (interactive)
  (httpd-start)
  (impatient-mode 1)
  (browse-url "http://localhost:8080/imp/")
  (message "🌐 Live preview opened at http://localhost:8080/imp/"))

(defun my/html-bind-live-preview-key ()
  "Bind Ctrl+Shift+L to `my/html-live-preview` in HTML buffers only."
  (local-set-key (kbd "C-S-l") #'my/html-live-preview))

(add-hook 'html-mode-hook #'my/html-bind-live-preview-key)

;; Dired
(define-key dired-mode-map "i" 'dired-subtree-insert)
(define-key dired-mode-map "b" 'dired-subtree-remove)

(setq insert-directory-program (concat "/etc/profiles/per-user/" (getenv "USER") "/bin/ls"))

(global-set-key (kbd "C-x D") 'image-dired)
(global-set-key (kbd "C-I") 'image-dired-dired-display-image)
(global-set-key (kbd "C-x B") 'ibuffer)

;; Various Functions
(defun my/move-to-end-of-line ()
  "Move Cursor to End of Current Line"
  (interactive)
  (move-end-of-line 1))

(defun my/move-to-beginning-of-line ()
  "Move Cursor to Beginning/Front of Current Line"
  (interactive)
  (move-beginning-of-line 1))

(defun my/launch-scratch-buffer ()
  "Open Scratch Buffer"
  (interactive)
  (scratch-buffer))

(global-set-key (kbd "C-c C-S-n") #'my/toggle-line-numbers)
(global-set-key (kbd "C-N") #'my/toggle-line-numbers)

(global-set-key (kbd "C-a") #'my/move-to-beginning-of-line)
(global-set-key (kbd "C-e") #'my/move-to-end-of-line)

(global-set-key (kbd "C-c s") #'my/launch-scratch-buffer)

;; TMux
(defun x/y/z ()
  (interactive)
  (shell-command "tmux command-prompt"))

(keymap-local-set "M-[ Z" 'x/y/z)

;; Org-Mode
(defhydra my/org-insert-hydra (:color blue :hint nil)
  "
Insert:
  _t_: Table Skeleton    _c_: Code Block
  _f_: Figure Block      _e_: Example Doc
  _w_: Wrapfigure
"
  ("t" my/insert-table-skeleton)
  ("c" my/insert-code-block)
  ("f" my/insert-figure-block)
  ("e" my/insert-example-document)
  ("w" my/insert-wrapfigure)
  ("q" nil "quit"))

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-S-i") #'my/org-insert-hydra/body))

;; Font Size
(defun my/font-increase ()
  "Increase default font height by 10."
  (interactive)
  (let ((current (face-attribute 'default :height)))
    (set-face-attribute 'default nil :height (+ current 10))))

(defun my/font-decrease ()
  "Decrease default font height by 10."
  (interactive)
  (let ((current (face-attribute 'default :height)))
    (set-face-attribute 'default nil :height (- current 20))))

(global-set-key (kbd "C-x C-S-=") #'my/font-increase)
(global-set-key (kbd "C-x C-_") #'my/font-decrease)

;; Multiple Cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(defun mc/backspace ()
  "Backspace that works with multiple cursors."
  (interactive)
  (if multiple-cursors-mode
      (mc/execute-command-for-all-cursors 'backward-delete-char-untabify)
    (call-interactively 'backward-delete-char-untabify)))

(defun my/mc-switch-to-block ()
  (setq-local cursor-type 'box))

(defun my/mc-restore-cursor ()
  (kill-local-variable 'cursor-type))

(add-hook 'multiple-cursors-mode-enabled-hook #'my/mc-switch-to-block)
(add-hook 'multiple-cursors-mode-disabled-hook #'my/mc-restore-cursor)

(unless (display-graphic-p)
  (global-set-key (kbd "M->") #'mc/mark-next-like-this)
  (global-set-key (kbd "M-<") #'mc/mark-previous-like-this))

;; C-q Mappings
(define-prefix-command 'my-C-q-map)
(global-set-key (kbd "C-q") 'my-C-q-map)
(define-key my-C-q-map (kbd "C-q C-q") #'save-buffers-kill-terminal)

;; Theme
(custom-set-faces)
(add-to-list 'custom-theme-load-path  "~/.nixmacs/themes/")
(set-face-attribute 'default nil :height 125)
(load-theme 'filian t)
