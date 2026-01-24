;;; fuwamoco-theme.el --- A pastel theme converted from kitty colorscheme

;; Author: Generated from kitty colorscheme
;; Version: 1.0
;; Package-Requires: ((emacs "24"))

;;; Commentary:
;; A soft pastel theme with dark purple background and cyan accents

;;; Code:

(deftheme fuwamoco
  "A pastel theme with dark purple background and soft pink/cyan colors")

(let ((bg "#26131e")
      (fg "#bcedf5")
      (cursor "#bcedf5")
      (black "#26131e")
      (bright-black "#83a5ab")
      (red "#C29DA5")
      (bright-red "#C29DA5")
      (green "#DA9EA3")
      (bright-green "#DA9EA3")
      (yellow "#C7A6B2")
      (bright-yellow "#C7A6B2")
      (blue "#B2B6C3")
      (bright-blue "#B2B6C3")
      (magenta "#DDB2CD")
      (bright-magenta "#DDB2CD")
      (cyan "#FDA9D8")
      (bright-cyan "#FDA9D8")
      (white "#bcedf5")
      (bright-white "#bcedf5"))

  (custom-theme-set-faces
   'fuwamoco

   ;; Basic faces
   `(default ((t (:foreground ,fg :background ,bg))))
   `(cursor ((t (:background ,cursor))))
   `(region ((t (:background ,bright-black))))
   `(highlight ((t (:background ,bright-black))))
   `(hl-line ((t (:background "#3a2030"))))
   `(fringe ((t (:background ,bg))))
   `(mode-line ((t (:foreground ,fg :background "#150b11"))))
   `(mode-line-inactive ((t (:foreground ,bright-black :background "#1a0e15"))))
   `(minibuffer-prompt ((t (:foreground ,cyan :weight bold))))

   ;; Tab bar
   `(tab-bar ((t (:background "#150b11" :foreground ,fg))))
   `(tab-bar-tab ((t (:background ,bg :foreground ,cyan :weight bold :box (:line-width 2 :color ,bg)))))
   `(tab-bar-tab-inactive ((t (:background "#150b11" :foreground ,bright-black :box (:line-width 2 :color "#150b11")))))

   ;; Tab line (alternative tab interface)
   `(tab-line ((t (:background "#150b11" :foreground ,fg))))
   `(tab-line-tab ((t (:background ,bg :foreground ,cyan :weight bold))))
   `(tab-line-tab-inactive ((t (:background "#150b11" :foreground ,bright-black))))
   `(tab-line-tab-current ((t (:background ,bg :foreground ,cyan :weight bold))))

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
   `(org-level-1 ((t (:foreground ,cyan :weight bold :height 1.3))))
   `(org-level-2 ((t (:foreground ,magenta :weight bold :height 1.2))))
   `(org-level-3 ((t (:foreground ,blue :weight bold :height 1.1))))
   `(org-level-4 ((t (:foreground ,yellow :weight bold))))
   `(org-level-5 ((t (:foreground ,green :weight bold))))
   `(org-level-6 ((t (:foreground ,red :weight bold))))
   `(org-link ((t (:foreground ,cyan :underline t))))
   `(org-code ((t (:foreground ,green))))
   `(org-verbatim ((t (:foreground ,yellow))))
   `(org-block ((t (:background "#1a0e15"))))
   `(org-block-begin-line ((t (:foreground ,bright-black :slant italic))))
   `(org-block-end-line ((t (:foreground ,bright-black :slant italic))))

   ;; Company mode
   `(company-tooltip ((t (:background "#1E0F18" :foreground ,fg))))
   `(company-tooltip-selection ((t (:background ,blue :foreground ,bg))))
   `(company-tooltip-common ((t (:foreground ,cyan :weight bold))))

   ;; Inline completion (corfu, company-preview, etc.)
   `(company-preview ((t (:background "#1E0F18" :foreground ,bright-black))))
   `(company-preview-common ((t (:background "#1E0F18" :foreground ,cyan))))
   `(corfu-default ((t (:background "#1E0F18" :foreground ,fg))))
   `(corfu-current ((t (:background ,blue :foreground ,bg))))

   ;; Parentheses matching
   `(show-paren-match ((t (:background ,magenta :foreground ,bg :weight bold))))
   `(show-paren-mismatch ((t (:background ,red :foreground ,bg :weight bold))))

   ;; Dired
   `(dired-directory ((t (:foreground ,blue :weight bold))))
   `(dired-symlink ((t (:foreground ,cyan))))

   ;; Markdown
   `(markdown-header-face-1 ((t (:foreground ,cyan :weight bold :height 1.3))))
   `(markdown-header-face-2 ((t (:foreground ,magenta :weight bold :height 1.2))))
   `(markdown-header-face-3 ((t (:foreground ,blue :weight bold :height 1.1))))
   `(markdown-code-face ((t (:foreground ,green :background "#1a0e15"))))
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

(provide-theme 'fuwamoco)

;;; fuwamoco-theme.el ends here
