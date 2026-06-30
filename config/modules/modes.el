;; Syntax Modes
(add-to-list 'auto-mode-alist '("\\.ino\\'" . arduino-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-mode))

(with-eval-after-load 'hoon-mode
  (require 'hoon-mode)
  (add-hook 'hoon-mode-hook
            (lambda ()
              (define-key hoon-mode-map (kbd "C-c r") 'hoon-eval-region-in-herb)
              (define-key hoon-mode-map (kbd "C-c b") 'hoon-eval-buffer-in-herb))))

(add-to-list 'auto-mode-alist '("\\.hoon\\'" . hoon-mode))
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

(defun my-nix-indent-line ()
  "Indent current line for Nix mode, handling '' strings."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (if (bobp)
        (indent-line-to 0)
      (let ((prev-line-content
             (save-excursion
               (forward-line -1)
               (buffer-substring-no-properties
                (line-beginning-position)
                (line-end-position))))
            (prev-indent
             (save-excursion
               (forward-line -1)
               (current-indentation))))
        (if (string-match-p "''\\s-*$" prev-line-content)
            (indent-line-to (+ prev-indent 2))
          (nix-indent-line)))))
  (when (< (current-column) (current-indentation))
    (move-to-column (current-indentation))))
(add-hook 'nix-mode-hook
          (lambda ()
            (setq-local indent-line-function 'my-nix-indent-line)))

(defun my-nix-electric-pair-quote ()
  "Handle electric pairing for '' in nix-mode."
  (interactive)
  (insert "'")
  (when (and (eq major-mode 'nix-mode)
             (looking-back "''" 2)
             (looking-at "\\s-*$"))
    (let ((current-indent (current-indentation)))
      (save-excursion
        (newline)
        (indent-line-to current-indent)
        (insert "'';"))
      (newline-and-indent))))

(add-hook 'nix-mode-hook
          (lambda ()
            (local-set-key (kbd "'") 'my-nix-electric-pair-quote)))
