;; ──────────────────────────────────────────────────────────
;; Configuration Inspector — popup overview of every setting
;; loaded by conditional-config-import-func
;; ──────────────────────────────────────────────────────────

(defvar my/config-inspector-files
  '("~/.nixmacs/config/modules/splashscreen.el"
    "~/.nixmacs/config/modules/settings.el"
    "~/.nixmacs/config/modules/ansi.el"
    "~/.nixmacs/config/modules/orgmode.el"
    "~/.nixmacs/config/modules/configinspector.el"
    "~/.nixmacs/config/modules/modes.el"
    "~/.nixmacs/config/modules/help.el"
    "~/.nixmacs/config/modules/lsp.el"
    "~/.nixmacs/config/modules/emms.el"
    "~/.nixmacs/config/baseline.el"
    "~/.nixmacs/config/modules/terminal.el"))

;; ── scanner ──────────────────────────────────────────────

(defun my/extract-settings-from-file (file-path)
  "Read FILE-PATH and extract setq/setq-default/customize-* forms.
Returns a list (VARIABLE CONFIGURED-STR CURRENT-STR) for each setting found."
  (let ((pairs '()))
    (with-temp-buffer
      (insert-file-contents file-path)
      (condition-case nil
          (progn
            (goto-char (point-min))
            ;; skip any shebang line
            (when (looking-at "#!") (forward-line))
            (while t
              (let ((form (read (current-buffer))))
                (when (consp form)
                  (pcase (car form)
                    ;; ── setq / setq-local ─────────────
                    ((or 'setq 'setq-local)
                     (let ((args (cdr form)))
                       (while (and args (consp args) (symbolp (car args)))
                         (let* ((sym  (car args))
                                (val-expr (and (cdr args) (cadr args)))
                                (cfg-str  (prin1-to-string val-expr))
                                (cur      (ignore-errors (symbol-value sym)))
                                (cur-str  (prin1-to-string cur)))
                           (push (list sym cfg-str cur-str) pairs))
                         (setq args (cddr args)))))
                    ;; ── setq-default ───────────────────
                    ('setq-default
                     (let ((args (cdr form)))
                       (while (and args (consp args) (symbolp (car args)))
                         (let* ((sym  (car args))
                                (val-expr (and (cdr args) (cadr args)))
                                (cfg-str  (prin1-to-string val-expr))
                                (cur      (ignore-errors (default-value sym)))
                                (cur-str  (prin1-to-string cur)))
                           (push (list sym cfg-str cur-str) pairs))
                         (setq args (cddr args)))))
                    ;; ── customize-set-variable ─────────
                    ('customize-set-variable
                     (when (and (symbolp (cadr form)) (caddr form))
                       (let* ((sym  (cadr form))
                              (cfg-str (prin1-to-string (caddr form)))
                              (cur     (ignore-errors (symbol-value sym)))
                              (cur-str (prin1-to-string cur)))
                         (push (list sym cfg-str cur-str) pairs))))
                    ;; ── custom-theme-set-variables ─────
                    ('custom-theme-set-variables
                     (dolist (spec (cdr form))
                       (when (and (consp spec) (symbolp (car spec)))
                         (let* ((sym  (car spec))
                                (cfg-str (prin1-to-string (cadr spec)))
                                (cur     (ignore-errors (symbol-value sym)))
                                (cur-str (prin1-to-string cur)))
                           (push (list sym cfg-str cur-str) pairs))))))))))
        (error nil))                          ; EOF or read error → done
      (nreverse pairs))))

;; ── display mode ────────────────────────────────────────

(defvar my/config-inspector-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "q")         #'quit-window)
    (define-key map (kbd "<up>")      #'previous-line)
    (define-key map (kbd "<down>")    #'next-line)
    (define-key map (kbd "<prior>")   #'scroll-down-command)    ; PgUp
    (define-key map (kbd "<next>")    #'scroll-up-command)      ; PgDn
    (define-key map (kbd "g")         #'my/config-inspector-refresh)
    map)
  "Keymap for `my/config-inspector-mode'.")

(define-derived-mode my/config-inspector-mode special-mode "ConfigInspector"
  "Major mode for the configuration inspector popup.
\\{my/config-inspector-mode-map}"
  (setq-local truncate-lines t)
  (setq-local buffer-read-only t))

;; ── popup commands ──────────────────────────────────────

(defun my/config-inspector--render (&optional buffer)
  "Fill BUFFER (default *Config Inspector*) with the settings report."
  (with-current-buffer (or buffer (get-buffer-create "*Config Inspector*"))
    (let ((inhibit-read-only t))
      (erase-buffer)
      (insert (propertize "╔══════════════════════════════════════════════════════╗\n"
                          'face 'font-lock-comment-face))
      (insert (propertize "║               Configuration Inspector               ║\n"
                          'face 'font-lock-comment-face))
      (insert (propertize "║  q=close  ↑↓←→=scroll  PgUp/PgDn=page  g=refresh   ║\n"
                          'face 'font-lock-comment-face))
      (insert (propertize "╚══════════════════════════════════════════════════════╝\n\n"
                          'face 'font-lock-comment-face))
      (dolist (file my/config-inspector-files)
        (if (not (file-exists-p file))
            (insert (propertize (format "✕  missing: %s\n\n" file)
                                'face 'error))
          (insert (propertize (format "◆  %s\n" file) 'face 'bold))
          (let ((settings (my/extract-settings-from-file file)))
            (if (null settings)
                (insert "   (no setq / customize forms found)\n")
              (dolist (s settings)
                (cl-destructuring-bind (var cfg-str cur-str) s
                  (let ((line (format "    %s\n" (propertize (symbol-name var)
                                                             'face 'font-lock-keyword-face))))
                    (when cfg-str
                      (setq line (concat line (format "         config:  %s\n" cfg-str))))
                    (when cur-str
                      (setq line (concat line (format "         current: %s\n" cur-str))))
                    (insert line)))))
            (insert "\n"))))
      (goto-char (point-min)))))

;;;###autoload
(defun my/config-inspector ()
  "Pop up an overlaid window listing every config setting loaded
by `conditional-config-import-func' and their current values.

Press `q' to close, arrows / PgUp / PgDn to scroll, `g' to refresh."
  (interactive)
  (let* ((buf (get-buffer-create "*Config Inspector*"))
         (window (display-buffer
                  buf
                  '((display-buffer-in-side-window
                     display-buffer-at-bottom)
                    (side . bottom)
                    (window-height . 0.45)))))
    (with-current-buffer buf
      (unless (derived-mode-p 'my/config-inspector-mode)
        (my/config-inspector-mode))
      (my/config-inspector--render buf))
    (select-window window)))

(defun my/config-inspector-refresh ()
  "Re-scan config files and refresh *Config Inspector*."
  (interactive)
  (let ((buf (get-buffer "*Config Inspector*")))
    (when buf
      (with-current-buffer buf
        (my/config-inspector--render buf))
      (message "Config Inspector refreshed."))))

(provide 'config-inspector)
