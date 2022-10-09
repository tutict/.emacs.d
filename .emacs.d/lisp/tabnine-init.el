  (require 'company-tabnine)
(add-to-list 'company-backends #'company-tabnine)
(setq company-idle-delay 0)
(setq company-show-numbers t)
(company-tng-configure-default)
(setq company-frontends
      '(company-tng-frontend
        company-pseudo-tooltip-frontend
        company-echo-metadata-frontend))
(setq ess-r-company-backends
      '((company-tabnine company-R-library company-R-args company-R-objects :separate)))

(provide 'tabnine-init)
