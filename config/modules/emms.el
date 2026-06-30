;; EMMS
(emms-all)

(setq emms-player-list '(emms-player-mpv)
      emms-info-functions '(emms-info-native
			    emms-info-ogginfo))

(emms-add-directory-tree "~/Music/")

(global-set-key (kbd "C-c m") 'emms-browser)

(dolist (binding '(("p" . emms-browser-add-tracks-and-play)
		   ("RET" . emms-browser-add-tracks-and-play)
		   ("P" . emms-pause)
		   ("N" . emms-next)
		   ("B" . emms-previous)))
  (define-key emms-browser-mode-map (kbd (car binding)) (cdr binding)))

(emms-mode-line 1)

(setq emms-mode-line-format "♫ %s")
