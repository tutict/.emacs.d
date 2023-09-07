(use-package web-mode
  :mode ("\\.html\\'")
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-current-element-highlight t
        web-mode-enable-css-colorization t))

(use-package emmet-mode
  :hook (web-mode css-mode))
(provide 'web-init)
