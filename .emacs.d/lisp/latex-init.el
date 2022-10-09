;;latex
(setq TeX-tree-roots "/usr/local/texlive/2022/texmf-dist")
(setenv "PATH"
	(concat
	 "/usr/local/texlive/2022/bin/x86_64-linux:"
	 (getenv "PATH")))
;; 设定outline minor mode的前缀快捷键为C-o
(setq outline-minor-mode-prefix [(control o)]) 

;; 解决显示Unicode字符的卡顿问题
(setq inhibit-compacting-font-caches t)

(load-file "~/.emacs.d/cdlatex.el")
;; 以下为LaTeX mode相关设置
(setq-default TeX-master nil) ;; 编译时问询主文件名称
(setq TeX-parse-selt t) ;; 对新文件自动解析(usepackage, bibliograph, newtheorem等信息)
;; PDF正向搜索相关设置
(setq TeX-PDF-mode t) 
(setq TeX-source-correlate-mode t) 
(setq TeX-source-correlate-method 'synctex) 
;; 打开TeX文件时应该加载的mode/执行的命令
(defun my-latex-hook ()
  (turn-on-cdlatex) ;; 加载cdlatex
  (outline-minor-mode) ;; 加载outline mode
  (turn-on-reftex)  ;; 加载reftex
  (auto-fill-mode)  ;; 加载自动换行
  (flyspell-mode)   ;; 加载拼写检查 (需要安装aspell)
  (TeX-fold-mode t) ;; 加载TeX fold mode
  (assq-delete-all (quote output-pdf) TeX-view-program-selection)    ;; 以下两行是正向搜索相关设置
(add-hook 'LaTeX-mode-hook 'my-latex-hook)

(setq TeX-view-program-list
      (quote
       ((auto-mode) . emacs)
       ("\\.pdf\\'" . "evince %s"))))
(provide 'latex-init)
