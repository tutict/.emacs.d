(use-package lsp-java
  :defer t
  :init
  (setq lsp-java-server-install-dir
        "~/.emacs.d/jdt-language-server-latest/")
  :hook (java-mode . (lambda ()
                       (require 'lsp-java)
                       (lsp-common-set))))

	(defun lsp-common-set ()
  (use-package lsp-ui
    :config
    (setq lsp-ui-doc-enable nil)
    (setq lsp-ui-sideline-enable nil)
    (define-key lsp-ui-mode-map [remap xref-find-references]
      #'lsp-ui-peek-find-references))
  (lsp)
  (setq-local company-backends
              '((company-yasnippet company-capf)
                company-dabbrev-code company-dabbrev
                company-files))
  (setq lsp-completion-styles '(basic))
  (define-key lsp-mode-map (kbd "S-<f2>") #'lsp-rename)
  (define-key lsp-mode-map (kbd "M-.") #'xref-find-definitions)
  (define-key lsp-mode-map (kbd "C-h .") #'lsp-describe-thing-at-point)
  (define-key lsp-mode-map (kbd "s-l") nil)
  (setq abbrev-mode nil))

(provide 'lsp-java-init)
