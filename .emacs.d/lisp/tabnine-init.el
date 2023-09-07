
(use-package tabnine
  :commands (tabnine-start-process)
  :hook ((prog-mode . tabnine-mode)
	 (text-mode . tabnine-mode)
	 (kill-emacs . tabnine-kill-process))
  :init
  (setq tabnine-minimum-prefix-length 0)
  :diminish "⌬"
  :custom
  (global-tabnine-mode t)
  (tabnine-wait 0.1)
  (tabnine-max-wait-count-while-nil 5)
  (tabnine-wait-interval-while-nil 0.2)
  (tabnine-minimum-prefix-length 0)
  (tabnine-chat-default-mode 'org-mode)
  (tabnine-chat-prompt-alist '((explain-code . "解释这段代码含义")
			       (generate-test-for-code . "为这段代码编写测试用例")
			       (document-code . "为这段代码添加文档注释")
			       (fix-code . "找到并修复这段代码的潜在问题")))
  
  :config
  (add-to-list 'completion-at-point-functions #'(tabnine-completion-at-point))
  (tabnine-start-process)
  :bind
  (:map  tabnine-completion-map
	 ("<tab>" . tabnine-accept-completion)
	 ("TAB" . tabnine-accept-completion)
	 ("M-f" . tabnine-accept-completion-by-word)
	 ("M-<return>" . tabnine-accept-completion-by-line)
	 ("C-g" . tabnine-clear-overlay)
	 ("M-[" . tabnine-previous-completion)
	 ("M-]" . tabnine-next-completion)))

(provide 'tabnine-init)
