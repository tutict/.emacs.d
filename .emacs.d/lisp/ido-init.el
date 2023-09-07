(use-package ido)
(use-package ido-vertical-mode)
(use-package flx-ido)
(use-package ido-hacks
	:init
	(setq ido-hacks-mode t))

(ido-mode 1)
(flx-ido-mode 1)
(ido-everywhere 1)
(ido-vertical-mode 1)

(setq ido-enable-flex-matching t
      ido-use-filename-at-point nil 
      ido-vertical-define-keys 'C-n-C-p-up-down-left-right)


(provide 'ido-init)
