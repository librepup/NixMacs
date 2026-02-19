;;; jungle-vibrant-theme.el --- A vibrant variant of the Jungle kitty colorscheme

;; Author: Generated from kitty colorscheme
;; Version: 1.0
;; Package-Requires: ((emacs "24"))

;;; Commentary:
;; A dark theme with vivid, saturated tones — a vibrant variant of the Jungle color scheme.
;; Same hue families as jungle-theme, but with saturation pushed to the max.

;;; Code:

(deftheme jungle-vibrant
  "A dark theme with vivid, saturated tones from the Jungle color scheme (vibrant variant)")

(let ((bg "#0a0a05")
      (fg "#f5e8d5")
      (cursor "#f5e8d5")
      (black "#0a0a05")
      (bright-black "#8a7a6e")
      ;; Vibrant: hues preserved from the jungle palette, saturation dramatically boosted
      (red "#4CBF5A")           ; jungle sage green → vivid green
      (bright-red "#4CBF5A")
      (green "#D4921A")         ; jungle khaki → vivid amber/gold
      (bright-green "#D4921A")
      (yellow "#C23FAD")        ; jungle dusty mauve → vivid magenta-purple
      (bright-yellow "#C23FAD")
      (blue "#78BADC")          ; jungle silver → vivid steel blue
      (bright-blue "#78BADC")
      (magenta "#F04535")       ; jungle soft rose → vivid coral red
      (bright-magenta "#F04535")
      (cyan "#FF6040")          ; jungle salmon → vivid orange
      (bright-cyan "#FF6040")
      (white "#f5e8d5")
      (bright-white "#f5e8d5"))

  (custom-theme-set-faces
   'jungle-vibrant

   ;; Basic faces
   `(default ((t (:foreground ,fg :background ,bg))))
   `(cursor ((t (:background ,cursor))))
   `(region ((t (:background "#1a1a10" :foreground ,fg))))
   `(highlight ((t (:background "#1a1a10"))))
   `(hl-line ((t (:background "#1a1a10"))))
   `(fringe ((t (:background ,bg))))
   `(mode-line ((t (:foreground ,fg :background "#050503"))))
   `(mode-line-inactive ((t (:foreground ,bright-black :background "#0d0d08"))))
   `(minibuffer-prompt ((t (:foreground ,blue :weight bold))))

   ;; Tab bar
   `(tab-bar ((t (:background "#050503" :foreground ,fg))))
   `(tab-bar-tab ((t (:background ,bg :foreground ,magenta :weight bold :box (:line-width 2 :color ,bg)))))
   `(tab-bar-tab-inactive ((t (:background "#050503" :foreground ,bright-black :box (:line-width 2 :color "#050503")))))

   ;; Tab line (alternative tab interface)
   `(tab-line ((t (:background "#050503" :foreground ,fg))))
   `(tab-line-tab ((t (:background ,bg :foreground ,magenta :weight bold))))
   `(tab-line-tab-inactive ((t (:background "#050503" :foreground ,bright-black))))
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
   `(org-block ((t (:background "#0d0d08"))))
   `(org-block-begin-line ((t (:foreground ,bright-black :slant italic))))
   `(org-block-end-line ((t (:foreground ,bright-black :slant italic))))

   ;; Company mode
   `(company-tooltip ((t (:background "#1a1a10" :foreground ,fg))))
   `(company-tooltip-selection ((t (:background ,blue :foreground ,bg))))
   `(company-tooltip-common ((t (:foreground ,magenta :weight bold))))

   ;; Inline completion (corfu, company-preview, etc.)
   `(company-preview ((t (:background "#1a1a10" :foreground ,bright-black))))
   `(company-preview-common ((t (:background "#1a1a10" :foreground ,magenta))))
   `(corfu-default ((t (:background "#1a1a10" :foreground ,fg))))
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
   `(markdown-code-face ((t (:foreground ,green :background "#0d0d08"))))
   `(markdown-inline-code-face ((t (:foreground ,green))))

   ;; Magit
   `(magit-branch-local ((t (:foreground ,blue))))
   `(magit-branch-remote ((t (:foreground ,green))))
   `(magit-diff-added ((t (:foreground ,green :background "#141409"))))
   `(magit-diff-added-highlight ((t (:foreground ,green :background "#1e1e0e"))))
   `(magit-diff-removed ((t (:foreground ,red :background "#12140e"))))
   `(magit-diff-removed-highlight ((t (:foreground ,red :background "#1a1f17"))))
   `(magit-section-heading ((t (:foreground ,yellow :weight bold))))

   ;; Error/warning/success
   `(error ((t (:foreground ,red :weight bold))))
   `(warning ((t (:foreground ,yellow :weight bold))))
   `(success ((t (:foreground ,green :weight bold))))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'jungle-vibrant)
