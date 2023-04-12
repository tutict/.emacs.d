(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mind-wave-enable-debug t)
 '(org-agenda-files nil)
 '(package-selected-packages
   '(lsp-mode yasnippet lsp-treemacs flycheck company which-key dap-mode php-mode))
 '(send-mail-function 'mailclient-send-it)
 '(warning-suppress-log-types
   '((use-package)
     (use-package)
     (use-package)
     (use-package)
     (emacs)
     (emacs)))
 '(warning-suppress-types
   '((use-package)
     (use-package)
     (use-package)
     (emacs)
     (emacs))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;use-package
(package-install 'use-package)
;;use-package相关	
(setq use-package-always-ensure t)
(setq use-package-always-defer t)
(setq use-package-always-demand nil)
(setq use-package-expand-minimally t)
(setq use-package-verbose t)
;;重启emacs的快捷方式	
(require 'use-package)
(use-package restart-emacs)
;;判断操作系统
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos)(eq system-type 'windows-nt)))
;;防乱码
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
;;去掉dos下的换行符
(defun remove-dos-col ()
  (interactive)
  (goto-char (point-min))
  while (search-forward "\r" nil t) (replace-match ""))
;;设置垃圾回收，加速启动
(setq gc-cons-threshold most-positive-fixnum)
;;用y/n代替yes/no
(defalias 'yes-or-no-p 'y-or-n-p)
;;org-mode语法高亮
(require 'org)
(setq org-src-fontify-natively t)
;;光标括号匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
;;.emacs文件如有变动，自动加载
(global-auto-revert-mode t)
;;光标移动到新buffer
(require 'popwin)
(popwin-mode t)
;;窗口跳转
(use-package ace-window
  :bind (("M-o" . 'ace-window)))
(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))
;;缩进
(defun indent-buffer()
  (interactive)
  (indent-region (point-min)(point-max)))
;;无序查找
(package-install 'orderless)
(setq completion-styles '(orderless))
;;命令注释
(package-install 'marginalia)
(marginalia-mode t)
;;显示快捷键C-x C-h
(package-install 'embark)
(setq prefix-help-command 'embark-prefix-help-command)
;;swiper
(package-install 'consult)
;;使emacs停止报警音
(setq ring-bell-function 'ignore)
;;网易云音乐相关
(require 'netease-cloud-music-comment)
;;mind-wave
(add-to-list 'load-path "~/.emacs.d/mind-wave")
(require 'mind-wave)
;;让EMACS能翻墙
(setq url-proxy-services '(("http" . "127.0.0.1:1087")
                           ("https" . "127.0.0.1:1087")))



(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'require)


(setq inhibit-eol-conversion t)

