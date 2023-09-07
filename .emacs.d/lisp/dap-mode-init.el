 (use-package dap-mode
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
		 (rust-mode . (lambda () (require 'dap-gdb-lldb)))
 		 (go-mode . (lambda () (require 'dap-go)))
 		 (js-mode . (lambda () (require 'dap-chrome)))
 		 (html-mode . (lambda () (require 'dap-chrome)))
 		 ((c-mode c++-mode) . (lambda () (require 'dap-gdb-lldb)))))



(provide 'dap-mode-init)
