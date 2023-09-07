(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(embark-consult lsp-mode lsp-treemacs flycheck dap-mode php-mode))
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
;;优化垃圾回收
(use-package gcmh
  :hook (emacs-startup . gcmh-mode)
  :init
  (setq gcmh-idle-delay 'auto
	  gcmh-auto-idle-delay-factor 10
	  gcmh-high-cons-threshold 33554432)) ; 32MB
;;关闭启动动画
(setq inhibit-startup-message t)
;; 加载 use-package
(eval-when-compile
  (require 'use-package))
;;增加IO性能
(setq process-adaptive-read-buffering nil)
(setq read-process-output-max (* 1024 1024))
;;use-package相关	
(setq use-package-always-defer t)
(setq use-package-always-demand nil)
(setq use-package-expand-minimally t)
(setq use-package-verbose t)
;;重启emacs的快捷方式	
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
(setq gc-cons-threshold (* 100 1024 1024))
(setq gc-cons-percentage 0.6)
;;禁止启动过程中自动初始化 package 系统
(setq package-enable-at-startup nil)
;;阻止在启动时隐式调整 Emacs 窗口大小
(setq frame-inhibit-implied-resize t)
(setq initial-frame-alist
      '((width . 80)     ; 窗口宽度
        (height . 40)     ; 窗口高度
        (top . 50)        ; 窗口距离屏幕顶部的距离
        (left . 100)))    ; 窗口距离屏幕左侧的距离
;;用y/n代替yes/no
(defalias 'yes-or-no-p 'y-or-n-p)
;;lsp-mode性能设置
(setq lsp-enable-file-watchers nil)
(setq lsp-file-watch-threshold 1000)
(setq lsp-idle-delay 0.5)
;;org-mode语法高亮
(require 'org)
(setq org-src-fontify-natively t)
;;光标括号匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
;;.emacs文件如有变动，自动加载
(global-auto-revert-mode t)
;;auto-save自动保存
(use-package auto-save
  :defer t
  :init
  ;; 关闭 emacs 默认的自动备份
  (setq make-backup-files nil)
  ;; 关闭 emacs 默认的 自动保存
  (setq auto-save-default nil)
  :config
  (setq auto-save-silent t)
  (auto-save-enable)
  )
;;光标移动到新buffer
(use-package popwin
  :defer t)
;;窗口跳转
(use-package ace-window
  :bind (("M-o" . 'ace-window)))
(use-package benchmark-init
  :defer t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))
;;缩进
(defun indent-buffer()
  (interactive)
  (indent-region (point-min)(point-max)))
;;命令注释
(use-package marginalia
  :config
  (marginalia-mode t))
;;显示快捷键C-x C-h
(use-package embark
  :defer t
  :config
  (setq prefix-help-command 'embark-prefix-help-command))
;;swiper
(use-package consult
  :defer t)
;;使emacs停止报警音
(setq ring-bell-function 'ignore)
;;holo-layer
(add-to-list 'load-path "~/.emacs.d/holo-layer/")
(require 'holo-layer)
(holo-layer-enable)
;;mind-wave
(add-to-list 'load-path "~/.emacs.d/mind-wave")
(require 'mind-wave)
;;让EMACS能翻墙
(setq url-proxy-services '(("http" . "127.0.0.1:1087")
			   ("https" . "127.0.0.1:1087")))

;; 设置 consult-find 命令来使用 fd
(setq consult-find-command "fd --color=never --full-path ARG OPTS")


(setq update-buffered-local-mode nil)

(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'require)



