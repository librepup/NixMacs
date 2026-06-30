;; LSP
(add-to-list 'lsp-language-id-configuration '(nickel-mode . "nickel"))
  (lsp-register-client (make-lsp-client
                           :new-connection (lsp-stdio-connection "nls")
                           :activation-fn (lsp-activate-on "nickel")
                           :server-id 'nls
                           :major-modes '(nickel-mode)
                           :initialization-options (lambda ()
						     ;; pass empty object to use default config
						     (list :eval (make-hash-table)))))
(add-hook 'nickel-mode-hook #'lsp-deferred)
(setq lsp-completion-provider :capf)
(add-hook 'rust-mode-hook #'lsp)
(add-hook 'rust-mode-hook
	  (lambda ()
	    (setq-local company-backends '(company-capf))))
(add-hook 'rustic-mode-hook #'lsp)
(add-hook 'rustic-mode-hook
          (lambda ()
            (setq-local company-backends '(company-capf))))
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(setq rustic-lsp-client 'lsp-mode)
