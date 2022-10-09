;;eaf神器配置
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
(require 'eaf)
(require 'netease-cloud-music)
(require 'netease-cloud-music-ui)
(require 'eaf-camera)
(require 'eaf-git)
(require 'eaf-rss-reader)
(require 'eaf-2048)
(require 'eaf-browser)
(require 'eaf-system-monitor)
(require 'eaf-demo)
(require 'eaf-file-manager)
(require 'eaf-jupyter)
(require 'eaf-file-sender)
(require 'eaf-markdown-previewer)
(require 'eaf-video-player)
(require 'eaf-file-browser)
(require 'eaf-image-viewer)
(require 'eaf-pdf-viewer)
(require 'eaf-mindmap)
(require 'eaf-vue-demo)
(require 'eaf-netease-cloud-music)
(require 'eaf-music-player)
(require 'eaf-org-previewer)
(require 'eaf-terminal)
(require 'eaf-airshare)

(use-package eaf
  :load-path "~/.emacs.d/site-lisp/emacs-application-framework"
  :commands (eaf-open eaf-search-it eaf-open-browser eaf-open-bookmark eaf-open-browser-with-history)
  :init
  (setq browse-url-browser-function 'eaf-open-browser)
  (defalias 'browse-web #'eaf-open-browser)
  :custom
  (eaf-find-alternate-file-in-dired t)
  (eaf-proxy-type "socks5")
  (eaf-proxy-host "127.0.0.1")
  (eaf-proxy-port "1080")
  :config
  (use-package ctable)
  (use-package deferred)
  (use-package epc))


(provide 'eaf-init)
