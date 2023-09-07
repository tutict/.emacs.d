;;php
(setq package-selected-packages '(lsp-mode lsp-treemacs flycheck dap-mode php-mode))
(add-hook 'php-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-php))

(provide 'php-init)
;;; php-init.el ends here
