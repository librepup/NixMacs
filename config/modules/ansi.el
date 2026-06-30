(setq ansi-color-faces-vector
      [ansi-color-black
       ansi-color-red
       ansi-color-green
       ansi-color-yellow
       ansi-color-blue
       ansi-color-magenta
       ansi-color-cyan
       ansi-color-white])

(setq ansi-color-map (ansi-color-make-color-map))
(defun display-ansi-colors ()
  (interactive)
  (require 'ansi-color)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

(defun my/maybe-colorize-ansi ()
"Check for ANSI escape sequences and colorize if found."
(save-excursion
  (goto-char (point-min))
  (when (re-search-forward "\033\\[[0-9;]*m" 5000 t)
    (display-ansi-colors)
    (set-buffer-modified-p nil))))

(add-hook 'find-file-hook 'my/maybe-colorize-ansi)

(defun my/ansi-colorize-buffer ()
  (interactive)
  (require 'ansi-color)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

(global-set-key (kbd "C-c C-a") #'my/ansi-colorize-buffer)
