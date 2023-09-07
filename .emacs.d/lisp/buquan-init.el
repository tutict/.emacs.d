(use-package corfu
  :demand t
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :config
  (setq corfu-auto-delay 0
	corfu-auto-prefix 1
	completion-styles '(orderless-fast basic))
  :custom
  (corfu-auto t)
  (corfu-quit-no-match t)
  (corfu-max-width 110)
  (corfu-cycle t)
  (corfu-preview-current 'insert)
  (corfu-doc-mode t)
  (corfu-quit-at-boundary nil)
  (corfu-preselect-first t)
  :config
  (advice-add #'corfu-insert :after #'corfu-send-shell)
  (add-to-list 'corfu-auto-commands 'some-special-insert-command)
  (setq corfu-sort-override-function #'my-corfu-combined-sort)
  (defun my/corfu-setup-lsp ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
	  '(orderless)))
  
  (defun corfu-enable-always-in-minibuffer ()
    "Enable Corfu in the minibuffer if Vertico/Mct are not active."
    (unless (or (bound-and-true-p mct--active) ; Useful if I ever use MCT
		(bound-and-true-p vertico--input))
      (setq-local corfu-auto nil)       ; Ensure auto completion is disabled
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1))


(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'tabnine-completion-at-point)
  (add-to-list 'completion-at-point-functions #'cape-file t)
  (add-to-list 'completion-at-point-functions #'cape-tex t)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev t)
  (add-to-list 'completion-at-point-functions #'cape-keyword t)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster))

(use-package pinyinlib
  :defer t
  :config
  ;; 拼音搜索支持
  (defun completion--regex-pinyin (str)
    (require 'pinyinlib)
    (orderless-regexp (pinyinlib-build-regexp-string str)))
  (add-to-list 'orderless-matching-styles 'completion--regex-pinyin))

(use-package orderless
  :init
  (icomplete-mode)
  (setq completion-styles '(orderless partial-completion basic)
	completion-category-defaults nil
	completion-category-overrides '((file (styles . (partial-completion)))))
  :custom (completion-styles '(orderless)))

(use-package embark
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package vertico
  :custom
  (vertical-count 13)
  (vertical-resize t)
  (vertical-cycle nil)
  (vertico-indexed t)
  (vertico-flat t)
  (vertico-grid t)
  (vertico-mouse t)
  (vertico-quick t)
  (vertico-buffer t)
  (vertico-repeat t)
  (vertico-reverse t)
  (vertico-directory t)
  (vertico-multiform t)
  (vertico-unobtrusive t)
  :init
  (vertico-mode))

(use-package marginalia
  :after (vertico)
  :init
  (marginalia-mode))

(use-package consult
  :defer t
  :custom
  (consult-preview-key nil)
  (consult-buffer-sources '(consult--source-buffer consult--source-recent-file)))


(use-package corfu-prescient
  :init(corfu-prescient-mode 1))


(defun corfu-send-shell (&rest _)
  "Send completion candidate when inside comint/eshell."
  (cond
   ((and (derived-mode-p 'eshell-mode) (fboundp 'eshell-send-input))
    (eshell-send-input))
   ((and (derived-mode-p 'comint-mode)  (fboundp 'comint-send-input))
    (comint-send-input))))

(defun my-corfu-combined-sort (candidates)
  "Sort CANDIDATES using both display-sort-function and corfu-sort-function."
  (let ((candidates
         (let ((display-sort-func (corfu--metadata-get 'display-sort-function)))
           (if display-sort-func
               (funcall display-sort-func candidates)
             candidates))))
    (if corfu-sort-function
        (funcall corfu-sort-function candidates)
      candidates)))


(provide 'buquan-init)
