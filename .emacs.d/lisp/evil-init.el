
(require 'evil)
(evil-mode 1)

(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-everywhere t)          
(ido-mode 1)

(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
 "ff" 'counsel-find-file
 "s" 'ido-switch-buffer
 "k" 'ido-kill-buffer
 "fr" 'recentf-open-files
 "0" 'select-window-0
 "1" 'select-window-1
 "2" 'select-window-2
 "3" 'select-window-3
 ";" 'counsel-M-x
 "r" 'split-window-right
 "d" 'split-window-below
 "w" 'delete-other-windows
 "n" 'eaf-open-browser
 "yy" 'netease-cloud-music
 "e" 'restart-emacs
 "t" 'treemacs-select-window
 "c" 'calendar
 "i" 'consult-imenu
 "pf" 'project-find-file
 "ps" 'consult-ripgrep
 "m" 'mu4e
 "ai" 'mind-wave-refactory-code-with-input
 "asv" 'mind-wave-summary-video
 "asw" 'mind-wave-summary-web
 "aec" 'mind-wave-explain-code
 "arw" 'mind-wave-restore-window-configuration
 "arc" 'mind-wave-refactory-code
 )

(window-numbering-mode 1)

(provide 'evil-init)
 
