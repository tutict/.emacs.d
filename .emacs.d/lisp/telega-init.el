(use-package telega
  :commands (telega) 
  :init (setq telega-proxies 
              '((:server "localhost"
                         :port "1089"
                         :enable t 
                         :type (:@type "proxyTypeSocks5")))
              telega-chat-show-avatars nil) 
  (setq telega-chat-fill-column 65) 
  (setq telega-emoji-use-images t))

(provide 'telega-init)
