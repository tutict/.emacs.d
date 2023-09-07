(setq auto-mode-alist
	  (append
	   '(("\\.rs\\'" . rust-mode))
	   auto-mode-alist))
(use-package rust-mode
  :bind (:map rust-mode-map ("C-c C-c" . rust-run)) ;bind the rust-run key
  :config (setq indent-tabs-mode nil                ;rust use spaces instead of tab
                rust-format-on-save t)              ;format code before save
  )
(use-package flycheck-rust)
(use-package cargo)
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(provide 'rust-init)
