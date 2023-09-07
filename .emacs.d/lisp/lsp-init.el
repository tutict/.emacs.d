(use-package which-key)
;;;lsp配置
(use-package lsp-mode
  :ensure t
  :custom
  (lsp-completion-provider :none)
  :commands (lsp lsp-deferred)
  :hook
  (lsp-completion-mode . my/lsp-mode-setup-completion)
  :init
  (setq lsp-keep-workspace-alive nil
       lsp-prefer-flymake t)

  (defun my/lsp-mode-setup-completion ()
     (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
	    '(orderless))
	
  (defun my/orderless-dispatch-flex-first (_pattern index _total)
     (and (eq index 0) 'orderless-flex)))

  (add-hook 'orderless-style-dispatchers #'my/orderless-dispatch-flex-first nil 'local)

  (setq-local completion-at-point-functions (list (cape-capf-buster #'lsp-completion-at-point))))
  
  

;; Configure LSP Clients
(use-package lsp-clients
  :functions (lsp-format-buffer lsp-organize-imports))
  
  
;;; Optionally: lsp-ui, company-lsp
(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :hook ((lsp-mode . lsp-ui-mode)
	 (lsp-ui-mode . lsp-modeline-code-actions-mode)
	 ;; (lsp-ui-mode . lsp-ui-peek-mode) ;; drop it 'cause it has BUGs
	 )
  :init (setq lsp-ui-doc-enable t
	      lsp-ui-doc-use-webkit nil
	      lsp-ui-doc-delay .3
	      lsp-ui-doc-include-signature t
	      lsp-ui-doc-position 'at-point ;; top/bottom/at-point
	      lsp-eldoc-enable-hover t ;; eldoc displays in minibuffer
	      lsp-ui-sideline-enable nil
	      lsp-ui-sideline-show-hover nil
	      lsp-ui-sideline-show-code-actions t
	      lsp-ui-sideline-show-diagnostics t
	      lsp-ui-sideline-ignore-duplicate t
	      lsp-modeline-code-actions-segments '(count name)
	      lsp-headerline-breadcrumb-enable nil)
  :config
  (setq lsp-ui-flycheck-enable nil)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (when (display-graphic-p)
    (treemacs-resize-icons 4))
  )
  

(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list
  :init
  (when (display-graphic-p)
    (treemacs-resize-icons 4)))
    
    
;;符号补全
(electric-pair-mode 1)
(setq electric-pair-pairs
      '(
	(?\" . ?\")  ;; 添加双引号补齐
	(?\{ . ?\})  ;; 添加大括号补齐
	(?\' . ?\'))) ;; 添加单引号补齐

(provide 'lsp-init)
