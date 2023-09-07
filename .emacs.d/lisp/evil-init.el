(use-package evil
  :demand t
  :init
  (evil-mode t)
  :config
  ;; 添加自定义的按键绑定
  ( evil-define-key 'normal global-map
    (kbd "<SPC>ff") 'consult-locate
    (kbd "<SPC>s") 'consult-buffer
    (kbd "<SPC>k") 'ido-kill-buffer
    (kbd "<SPC>0") 'select-window-0
    (kbd "<SPC>1") 'select-window-1
    (kbd "<SPC>2") 'select-window-2
    (kbd "<SPC>3") 'select-window-3
    (kbd "<SPC>;") 'counsel-M-x
    (kbd "<SPC>r") 'split-window-right
    (kbd "<SPC>d") 'split-window-below
    (kbd "<SPC>w") 'delete-other-windows
    (kbd "<SPC>n") 'eaf-open-browser
    (kbd "<SPC>e") 'restart-emacs
    (kbd "<SPC>t") 'treemacs-select-window
    (kbd "<SPC>c") 'calendar
    (kbd "<SPC>l") 'consult-line
    (kbd "<SPC>fs") 'consult-ripgrep
    (kbd "<SPC>m") 'mu4e
    (kbd "<SPC>ai") 'mind-wave-refactory-code-with-input
    (kbd "<SPC>asv") 'mind-wave-summary-video
    (kbd "<SPC>asw") 'mind-wave-summary-web
    (kbd "<SPC>aec") 'mind-wave-explain-code
    (kbd "<SPC>arw") 'mind-wave-restore-window-configuration
    (kbd "<SPC>arc") 'mind-wave-refactory-code
    )
  :custom
  (global-evil-leader-mode t))

(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-everywhere t)          

(use-package window-numbering
  :init
  (setq window-numbering-mode t))

(provide 'evil-init)

