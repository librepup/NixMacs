;;; marnie-theme.el --- A muted theme converted from kitty colorscheme

;; Author: Generated from kitty colorscheme
;; Version: 1.0
;; Package-Requires: ((emacs "24"))

;;; Commentary:
;; A muted theme with dark gray background and sage green/mauve accents

;;; Code:

(deftheme marnie
  "A muted theme with dark gray background and soft mauve/sage colors")

(let ((bg "#181818")
      (fg "#bcc7c1")
      (cursor "#bcc7c1")
      (black "#181818")
      (bright-black "#838b87")
      (red "#935F71")
      (bright-red "#935F71")
      (green "#928375")
      (bright-green "#928375")
      (yellow "#A86082")
      (bright-yellow "#A86082")
      (blue "#B26686")
      (bright-blue "#B26686")
      (magenta "#C67A92")
      (bright-magenta "#C67A92")
      (cyan "#658C86")
      (bright-cyan "#658C86")
      (white "#bcc7c1")
      (bright-white "#bcc7c1"))

  (custom-theme-set-faces
   'marnie

   ;; Basic faces
   `(default ((t (:foreground ,fg :background ,bg))))
   `(cursor ((t (:background ,cursor))))
   `(region ((t (:background ,bright-black))))
   `(highlight ((t (:background ,bright-black))))
   `(hl-line ((t (:background "#242424"))))
   `(fringe ((t (:background ,bg))))
   `(mode-line ((t (:foreground ,fg :background "#0b0b0b"))))
   `(mode-line-inactive ((t (:foreground ,bright-black :background "#121212"))))
   `(minibuffer-prompt ((t (:foreground ,cyan :weight bold))))

   ;; Tab bar
   `(tab-bar ((t (:background "#0b0b0b" :foreground ,fg))))
   `(tab-bar-tab ((t (:background ,bg :foreground ,magenta :weight bold :box (:line-width 2 :color ,bg)))))
   `(tab-bar-tab-inactive ((t (:background "#0b0b0b" :foreground ,bright-black :box (:line-width 2 :color "#0b0b0b")))))

   ;; Tab line (alternative tab interface)
   `(tab-line ((t (:background "#0b0b0b" :foreground ,fg))))
   `(tab-line-tab ((t (:background ,bg :foreground ,magenta :weight bold))))
   `(tab-line-tab-inactive ((t (:background "#0b0b0b" :foreground ,bright-black))))
   `(tab-line-tab-current ((t (:background ,bg :foreground ,magenta :weight bold))))

   ;; Font lock faces
   `(font-lock-builtin-face ((t (:foreground ,blue))))
   `(font-lock-comment-face ((t (:foreground ,bright-black :slant italic))))
   `(font-lock-constant-face ((t (:foreground ,magenta))))
   `(font-lock-function-name-face ((t (:foreground ,cyan))))
   `(font-lock-keyword-face ((t (:foreground ,red :weight bold))))
   `(font-lock-string-face ((t (:foreground ,green))))
   `(font-lock-type-face ((t (:foreground ,yellow))))
   `(font-lock-variable-name-face ((t (:foreground ,blue))))
   `(font-lock-warning-face ((t (:foreground ,red :weight bold))))

   ;; Line numbers
   `(line-number ((t (:foreground ,bright-black :background ,bg))))
   `(line-number-current-line ((t (:foreground ,fg :background ,bg :weight bold))))

   ;; Search
   `(isearch ((t (:foreground ,bg :background ,cyan :weight bold))))
   `(lazy-highlight ((t (:foreground ,bg :background ,magenta))))

   ;; Links
   `(link ((t (:foreground ,cyan :underline t))))
   `(link-visited ((t (:foreground ,magenta :underline t))))

   ;; Org mode
   `(org-level-1 ((t (:foreground ,magenta :weight bold :height 1.3))))
   `(org-level-2 ((t (:foreground ,cyan :weight bold :height 1.2))))
   `(org-level-3 ((t (:foreground ,blue :weight bold :height 1.1))))
   `(org-level-4 ((t (:foreground ,yellow :weight bold))))
   `(org-level-5 ((t (:foreground ,green :weight bold))))
   `(org-level-6 ((t (:foreground ,red :weight bold))))
   `(org-link ((t (:foreground ,cyan :underline t))))
   `(org-code ((t (:foreground ,green))))
   `(org-verbatim ((t (:foreground ,yellow))))
   `(org-block ((t (:background "#121212"))))
   `(org-block-begin-line ((t (:foreground ,bright-black :slant italic))))
   `(org-block-end-line ((t (:foreground ,bright-black :slant italic))))

   ;; Company mode
   `(company-tooltip ((t (:background ,bright-black :foreground ,fg))))
   `(company-tooltip-selection ((t (:background ,blue :foreground ,bg))))
   `(company-tooltip-common ((t (:foreground ,cyan :weight bold))))

   ;; Parentheses matching
   `(show-paren-match ((t (:background ,magenta :foreground ,bg :weight bold))))
   `(show-paren-mismatch ((t (:background ,red :foreground ,bg :weight bold))))

   ;; Dired
   `(dired-directory ((t (:foreground ,blue :weight bold))))
   `(dired-symlink ((t (:foreground ,cyan))))

   ;; Markdown
   `(markdown-header-face-1 ((t (:foreground ,magenta :weight bold :height 1.3))))
   `(markdown-header-face-2 ((t (:foreground ,cyan :weight bold :height 1.2))))
   `(markdown-header-face-3 ((t (:foreground ,blue :weight bold :height 1.1))))
   `(markdown-code-face ((t (:foreground ,green :background "#121212"))))
   `(markdown-inline-code-face ((t (:foreground ,green))))

   ;; Magit
   `(magit-branch-local ((t (:foreground ,cyan))))
   `(magit-branch-remote ((t (:foreground ,green))))
   `(magit-diff-added ((t (:foreground ,green :background "#1a2a1e"))))
   `(magit-diff-added-highlight ((t (:foreground ,green :background "#2a3a2e"))))
   `(magit-diff-removed ((t (:foreground ,red :background "#2a1a1e"))))
   `(magit-diff-removed-highlight ((t (:foreground ,red :background "#3a2a2e"))))
   `(magit-section-heading ((t (:foreground ,yellow :weight bold))))

   ;; Error/warning/success
   `(error ((t (:foreground ,red :weight bold))))
   `(warning ((t (:foreground ,yellow :weight bold))))
   `(success ((t (:foreground ,green :weight bold))))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'marnie)

;;; marnie-theme.el ends here
