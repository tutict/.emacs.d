 (use-package dap-mode
   :ensure t
   :functions dap-hydra/nil
   :diminish
   :bind (:map lsp-mode-map
 			  ("<f5>" . dap-debug)
 			  ("M-<f5>" . dap-hydra))
   :hook ((after-init . dap-mode)
 		 (dap-mode . dap-ui-mode)
		 (java-mode . (lambda ()(require 'dap-java)))
 		 (python-mode . (lambda () (require 'dap-python)))
 		 (go-mode . (lambda () (require 'dap-dlv-go)))
 		 (php-mode . (lambda () (require 'dap-php)))
 		 (go-mode . (lambda () (require 'dap-go)))
 		 (js-mode . (lambda () (require 'dap-edge)))
 		 ((c-mode c++-mode) . (lambda () (require 'dap-lldb)))))



(provide 'dap-mode-init)
