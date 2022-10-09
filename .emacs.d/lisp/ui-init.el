;;emacs主题
(use-package atom-one-dark-theme
	:init(load-theme 'atom-one-dark t))
;;状态栏主题
(require 'powerline)
(powerline-default-theme)
(require 'powerline-evil)
;;设置行号
(use-package emacs
  :unless *is-windows*
  :config
  (setq display-line-numbers-type 'visual)
  (global-display-line-numbers-mode t))
;;emacs界面设置
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
;;启用时间显示设置，在minibuffer上面的那个杠上
(display-time-mode 1)
;;时间使用24小时制
(setq display-time-24hr-format t)
;;时间显示包括日期和具体时间
(setq display-time-day-and-date t)
;;去除开始菜单
(setq inhibit-startup-screen t)
(require 'dashboard)
(setq dashboard-setup-startup-hook t)
;;窗口透明
(set-frame-parameter nil 'alpha 0.87)
;;awesome-tab-mode
(add-to-list 'load-path (expand-file-name "~/.emacs.d/awesome-tab/"))
(require 'awesome-tab)
(awesome-tab-mode t)

(provide 'ui-init)
