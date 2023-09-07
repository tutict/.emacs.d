;;emacs主题
(use-package atom-one-dark-theme
	:init(load-theme 'atom-one-dark t))
;;状态栏主题
(use-package doom-modeline)
(use-package all-the-icons)
(use-package all-the-icons-completion
  :after(marginalia all-the-icons)
  :hook(marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))
;;设置行号
(use-package emacs
  :init
  (global-display-line-numbers-mode t)
  (setq completion-cycle-threshold 3)
  (setq read-extended-command-predicate #' command-completion-default-include-p)
(defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

(use-package savehist
  :init
  (savehist-mode))

;;emacs界面设置
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(use-package dashboard
  :config
  (dashboard-setup-startup-hook))
;;启用时间显示设置，在minibuffer上面的那个杠上
(display-time-mode 1)
;;去除开始菜单
(setq inhibit-startup-screen t)
(require 'dashboard)
(setq dashboard-setup-startup-hook t)
;;窗口透明
(set-frame-parameter nil 'alpha 0.87)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/awesome-tab"))

(require 'awesome-tab)
(awesome-tab-mode t)
(provide 'ui-init)
