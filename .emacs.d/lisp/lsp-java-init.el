(use-package lsp-java
  :defer t
  :hook (java-mode . (lambda ()
		       (require 'lsp-java))))

(provide 'lsp-java-init)
