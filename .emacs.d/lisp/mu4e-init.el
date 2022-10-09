;;mu4e
(add-to-list 'load-path "~/.emacs.d/mu4e")
(require 'smtpmail)
(require 'mu4e)

(setq mail-user-agent 'mu4e-user-agent
      user-full-name "tutict"
      message-send-mail-function 'smtpmail-send-it
      send-mail-function 'smtpmail-send-it)

(setq mu4e-get-mail-command "offlineimap"
      mu4e-update-interval 120
      mu4e-header-auto-update t
      mu4e-maildir-list "~/Mail"
      mu4e-view-show-images t
      mu4e-view-use-old nil
      mu4e-attachment-dir "~/Downloads"
      mu4e-sent-messages-behavior 'delete)

(setq mu4e-sent-folder "//Sent Messages"
      mu4e-drafts-folder "/Mail/Drafts"
      user-full-name "tutict"
      user-mail-address "tutict@163.com"
      smtpmail-smtp-server "smtp.163.com"
      smtpmail-local-domain "163.com"
      smtpmail-debug-info t
      smtpmail-smtp-service 994
      smtpmail-stream-type 'ssl)

(provide 'mu4e-init)
