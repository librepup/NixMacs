;;; guix-theme.el --- A theme converted from kitty colorscheme

;; Author: Generated from kitty colorscheme
;; Version: 1.0
;; Package-Requires: ((emacs "24"))

;;; Commentary:
;; A dark theme with warm orange/yellow accents

;;; Code:

(deftheme guix
  "A dark theme with warm orange/yellow accents from Guix color scheme")

(let ((bg "#0f0f0f")
      (fg "#c5c5c6")
      (cursor "#c5c5c6")
      (black "#0f0f0f")
      (bright-black "#89898a")
      (red "#5A5C5D")
      (bright-red "#5A5C5D")
      (green "#BC6E32")
      (bright-green "#BC6E32")
      (yellow "#B98E2A")
      (bright-yellow "#B98E2A")
      (blue "#ECA530")
      (bright-blue "#ECA530")
      (magenta "#FFC12D")
      (bright-magenta "#FFC12D")
      (cyan "#7E8081")
      (bright-cyan "#7E8081")
      (white "#c5c5c6")
      (bright-white "#c5c5c6"))

  (custom-theme-set-faces
   'guix

   ;; Basic faces
   `(default ((t (:foreground ,fg :background ,bg))))
   `(cursor ((t (:background ,cursor))))
   `(region ((t (:background "#1a1a1a" :foreground ,fg))))
   `(highlight ((t (:background "#1a1a1a"))))
   `(hl-line ((t (:background "#1a1a1a"))))
   `(fringe ((t (:background ,bg))))
   `(mode-line ((t (:foreground ,fg :background "#050505"))))
   `(mode-line-inactive ((t (:foreground ,bright-black :background "#0a0a0a"))))
   `(minibuffer-prompt ((t (:foreground ,blue :weight bold))))

   ;; Tab bar
   `(tab-bar ((t (:background "#050505" :foreground ,fg))))
   `(tab-bar-tab ((t (:background ,bg :foreground ,magenta :weight bold :box (:line-width 2 :color ,bg)))))
   `(tab-bar-tab-inactive ((t (:background "#050505" :foreground ,bright-black :box (:line-width 2 :color "#050505")))))

   ;; Tab line (alternative tab interface)
   `(tab-line ((t (:background "#050505" :foreground ,fg))))
   `(tab-line-tab ((t (:background ,bg :foreground ,magenta :weight bold))))
   `(tab-line-tab-inactive ((t (:background "#050505" :foreground ,bright-black))))
   `(tab-line-tab-current ((t (:background ,bg :foreground ,magenta :weight bold))))

   ;; Font lock faces
   `(font-lock-builtin-face ((t (:foreground ,blue))))
   `(font-lock-comment-face ((t (:foreground ,bright-black :slant italic))))
   `(font-lock-constant-face ((t (:foreground ,magenta))))
   `(font-lock-function-name-face ((t (:foreground ,blue))))
   `(font-lock-keyword-face ((t (:foreground ,yellow :weight bold))))
   `(font-lock-string-face ((t (:foreground ,green))))
   `(font-lock-type-face ((t (:foreground ,magenta))))
   `(font-lock-variable-name-face ((t (:foreground ,cyan))))
   `(font-lock-warning-face ((t (:foreground ,red :weight bold))))

   ;; Line numbers
   `(line-number ((t (:foreground ,bright-black :background ,bg))))
   `(line-number-current-line ((t (:foreground ,fg :background ,bg :weight bold))))

   ;; Search
   `(isearch ((t (:foreground ,bg :background ,magenta :weight bold))))
   `(lazy-highlight ((t (:foreground ,bg :background ,yellow))))

   ;; Links
   `(link ((t (:foreground ,blue :underline t))))
   `(link-visited ((t (:foreground ,magenta :underline t))))

   ;; Org mode
   `(org-level-1 ((t (:foreground ,magenta :weight bold :height 1.3))))
   `(org-level-2 ((t (:foreground ,blue :weight bold :height 1.2))))
   `(org-level-3 ((t (:foreground ,yellow :weight bold :height 1.1))))
   `(org-level-4 ((t (:foreground ,green :weight bold))))
   `(org-level-5 ((t (:foreground ,cyan :weight bold))))
   `(org-level-6 ((t (:foreground ,red :weight bold))))
   `(org-link ((t (:foreground ,blue :underline t))))
   `(org-code ((t (:foreground ,green))))
   `(org-verbatim ((t (:foreground ,yellow))))
   `(org-block ((t (:background "#0a0a0a"))))
   `(org-block-begin-line ((t (:foreground ,bright-black :slant italic))))
   `(org-block-end-line ((t (:foreground ,bright-black :slant italic))))

   ;; Company mode
   `(company-tooltip ((t (:background "#1a1a1a" :foreground ,fg))))
   `(company-tooltip-selection ((t (:background ,blue :foreground ,bg))))
   `(company-tooltip-common ((t (:foreground ,magenta :weight bold))))

   ;; Inline completion (corfu, company-preview, etc.)
   `(company-preview ((t (:background "#1a1a1a" :foreground ,bright-black))))
   `(company-preview-common ((t (:background "#1a1a1a" :foreground ,magenta))))
   `(corfu-default ((t (:background "#1a1a1a" :foreground ,fg))))
   `(corfu-current ((t (:background ,blue :foreground ,bg))))

   ;; Parentheses matching
   `(show-paren-match ((t (:background ,magenta :foreground ,bg :weight bold))))
   `(show-paren-mismatch ((t (:background ,red :foreground ,fg :weight bold))))

   ;; Dired
   `(dired-directory ((t (:foreground ,blue :weight bold))))
   `(dired-symlink ((t (:foreground ,magenta))))

   ;; Markdown
   `(markdown-header-face-1 ((t (:foreground ,magenta :weight bold :height 1.3))))
   `(markdown-header-face-2 ((t (:foreground ,blue :weight bold :height 1.2))))
   `(markdown-header-face-3 ((t (:foreground ,yellow :weight bold :height 1.1))))
   `(markdown-code-face ((t (:foreground ,green :background "#0a0a0a"))))
   `(markdown-inline-code-face ((t (:foreground ,green))))

   ;; Magit
   `(magit-branch-local ((t (:foreground ,blue))))
   `(magit-branch-remote ((t (:foreground ,green))))
   `(magit-diff-added ((t (:foreground ,green :background "#1a1a0f"))))
   `(magit-diff-added-highlight ((t (:foreground ,green :background "#252515"))))
   `(magit-diff-removed ((t (:foreground ,red :background "#1a1010"))))
   `(magit-diff-removed-highlight ((t (:foreground ,red :background "#251515"))))
   `(magit-section-heading ((t (:foreground ,yellow :weight bold))))

   ;; Error/warning/success
   `(error ((t (:foreground ,red :weight bold))))
   `(warning ((t (:foreground ,yellow :weight bold))))
   `(success ((t (:foreground ,green :weight bold))))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'guix)
