;;jk->esc
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)
;;设置f3打开.emacs
(defun my-find()
  (interactive)
   ( find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f3>") 'my-find)
;;设置f4打开eshell
(global-set-key [f4] 'eshell)
;;使用ag
(global-set-key (kbd "M-a") 'helm-do-ag)
(provide 'jianwei-init)
