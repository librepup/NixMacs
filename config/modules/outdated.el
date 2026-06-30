;; Manual Conditional
(defun check-and-load-splashscreen-config ()
  (interactive)
  (let ((splashscreen-file "~/.nixmacs/config/splashscreen.el"))
    (if (file-exists-p splashscreen-file)
        (progn
          (message "Found splashscreen.el, now Loading...")
          (load-file splashscreen-file))
      (message "splashscreen.el not found. Continuing..."))))
(defun conditional-config-import-func (config-file-list)
  (interactive)
  (dolist (file config-file-list)
    (if (file-exists-p file)
        (progn
          (message "Found configuration file: %s. Loading..." file)
          (load-file file))
      (message "Configuration file %s not found. Continuing..." file))))

(conditional-config-import-func '("~/.nixmacs/config/modules/splashscreen.el"
                                  "~/.nixmacs/config/modules/settings.el"
                                  "~/.nixmacs/config/modules/ansi.el"
                                  "~/.nixmacs/config/modules/orgmode.el"
                                  "~/.nixmacs/config/modules/terminal.el"
                                  ))
