(use-package flycheck
  :diminish
  :autoload flycheck-redefine-standard-error-levels
  :hook (after-init . global-flycheck-mode)
  :init (setq flycheck-global-modes
              '(not text-mode outline-mode fundamental-mode lisp-interaction-mode
                    org-mode diff-mode shell-mode eshell-mode term-mode vterm-mode)
              flycheck-emacs-lisp-load-path 'inherit
              flycheck-indication-mode (if (display-graphic-p)
                                           'right-fringe
                                         'right-margin)
              ;; Only check while saving and opening files
              flycheck-check-syntax-automatically '(save mode-enabled))
  :config
  ;; Prettify indication styles
  (when (fboundp 'define-fringe-bitmap)
    (define-fringe-bitmap 'flycheck-fringe-bitmap-arrow
      [16 48 112 240 112 48 16] nil nil 'center))
  (flycheck-redefine-standard-error-levels "⏴" 'flycheck-fringe-bitmap-arrow)

  ;; Display Flycheck errors
      (use-package flycheck-posframe
        :custom-face
        (flycheck-posframe-face ((t (:foreground ,(face-foreground 'success)))))
        (flycheck-posframe-info-face ((t (:foreground ,(face-foreground 'success)))))
        (flycheck-posframe-background-face ((t (:inherit tooltip))))
        (flycheck-posframe-border-face ((t (:inherit posframe-border))))
        :hook (flycheck-mode . flycheck-posframe-mode)
        :init
        (setq flycheck-posframe-border-width 1)
        (add-hook 'flycheck-posframe-inhibit-functions
                  (lambda (&rest _) (bound-and-true-p company-backend)))
        :config
        (with-no-warnings
          ;; FIXME: Prettify the child frame.
          ;; @see https://github.com/alexmurray/flycheck-posframe/issues/28
          (defun my-flycheck-posframe-show-posframe (errors)
            "Display ERRORS, using posframe.el library."
            (posframe-hide flycheck-posframe-buffer)
            (when (and errors
                       (not (run-hook-with-args-until-success 'flycheck-posframe-inhibit-functions)))
              (let ((poshandler (intern (format "posframe-poshandler-%s" flycheck-posframe-position))))
                (unless (functionp poshandler)
                  (setq poshandler nil))
                (flycheck-posframe-check-position)
                (posframe-show
                 flycheck-posframe-buffer
                 :string (flycheck-posframe-format-errors errors)
                 :background-color (face-background 'flycheck-posframe-background-face nil t)
                 :position (point)
                 :left-fringe 4
                 :right-fringe 4
                 :max-width (round (* (frame-width) 0.62))
                 :max-height (round (* (frame-height) 0.62))
                 :internal-border-width flycheck-posframe-border-width
                 :internal-border-color (face-background 'flycheck-posframe-border-face nil t)
                 :poshandler poshandler
                 :hidehandler #'flycheck-posframe-hidehandler))))
          (advice-add #'flycheck-posframe-show-posframe :override #'my-flycheck-posframe-show-posframe)))
    (use-package flycheck-popup-tip
      :hook (flycheck-mode . flycheck-popup-tip-mode)))

(provide 'flycheck-init)
