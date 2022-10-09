;;; mu4e.el --- part of mu4e, the mu mail user agent -*- lexical-binding: t -*-

;; Copyright (C) 2011-2022 Dirk-Jan C. Binnema

;; Author: Dirk-Jan C. Binnema <djcb@djcbsoftware.nl>
;; Maintainer: Dirk-Jan C. Binnema <djcb@djcbsoftware.nl>
;; Keywords: email

;; This file is not part of GNU Emacs.

;; mu4e is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; mu4e is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with mu4e.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'mu4e-vars)
(require 'mu4e-helpers)
(require 'mu4e-folders)
(require 'mu4e-context)
(require 'mu4e-contacts)
(require 'mu4e-headers)
(require 'mu4e-view)
(require 'mu4e-compose)
(require 'mu4e-bookmarks)
(require 'mu4e-update)
(require 'mu4e-main)
(require 'mu4e-server)     ;; communication with backend



(defcustom mu4e-confirm-quit t
  "Whether to confirm to quit mu4e."
  :type 'boolean
  :group 'mu4e)

(defcustom mu4e-org-support t
  "Support Org-mode links."
  :type 'boolean
  :group 'mu4e)

(defcustom mu4e-speedbar-support nil
  "Support having a speedbar to navigate folders/bookmarks."
  :type 'boolean
  :group 'mu4e)

(when mu4e-speedbar-support
  (require 'mu4e-speedbar)) ;; support for speedbar
(when mu4e-org-support
  (require 'mu4e-org))      ;; support for org-mode links

;; We can't properly use compose buffers that are revived using
;; desktop-save-mode; so let's turn that off.
(with-eval-after-load 'desktop
  (eval '(add-to-list 'desktop-modes-not-to-save 'mu4e-compose-mode)))

;;;###autoload
(defun mu4e (&optional background)
  "If mu4e is not running yet, start it.
Then, show the main window, unless BACKGROUND (prefix-argument)
is non-nil."
  (interactive "P")
  ;; start mu4e, then show the main view
  (mu4e--init-handlers)
  (mu4e--start (unless background 'mu4e--main-view)))

(defun mu4e-quit()
  "Quit the mu4e session."
  (interactive)
  (if mu4e-confirm-quit
      (when (y-or-n-p (mu4e-format "Are you sure you want to quit?"))
        (mu4e--stop))
    (mu4e--stop)))

;;; Internals

(defun mu4e--check-requirements ()
  "Check for the settings required for running mu4e."
  (unless (>= emacs-major-version 25)
    (mu4e-error "Emacs >= 25.x is required for mu4e"))
  (when (mu4e-server-properties)
    (unless (string= (mu4e-server-version) mu4e-mu-version)
      (mu4e-error "The mu server has version %s, but we need %s"
                  (mu4e-server-version) mu4e-mu-version)))
  (unless (and mu4e-mu-binary (file-executable-p mu4e-mu-binary))
    (mu4e-error "Please set `mu4e-mu-binary' to the full path to the mu
    binary"))
  (dolist (var '(mu4e-sent-folder mu4e-drafts-folder
                                  mu4e-trash-folder))
    (unless (and (boundp var) (symbol-value var))
      (mu4e-error "Please set %S" var))
    (unless (functionp (symbol-value var)) ;; functions are okay, too
      (let* ((dir (symbol-value var))
             (path (concat (mu4e-root-maildir) dir)))
        (unless (string= (substring dir 0 1) "/")
          (mu4e-error "%S must start with a '/'" dir))
        (unless (mu4e-create-maildir-maybe path)
          (mu4e-error "%s (%S) does not exist" path var))))))

;;; Starting / getting mail / updating the index

(defun mu4e--pong-handler (_data func)
  "Handle \"pong\" responses from the mu server.
Invoke FUNC if non-nil."
  (let ((doccount (plist-get (mu4e-server-properties) :doccount)))
    (mu4e--check-requirements)
    (when func (funcall func))
    (when (zerop doccount)
      (mu4e-message "Store is empty; try indexing (M-x mu4e-update-index)."))
    (when (and mu4e-update-interval (null mu4e--update-timer))
      (setq mu4e--update-timer
            (run-at-time 0 mu4e-update-interval
                         (lambda () (mu4e-update-mail-and-index
                                     mu4e-index-update-in-background)))))))

(defun mu4e--start (&optional func)
  "Start mu4e.
If `mu4e-contexts' have been defined, but we don't have a context
yet, switch to the matching one, or none matches, the first. If
mu4e is already running, invoke FUNC (if non-nil).

Otherwise, check requirements, then start mu4e. When successful,
invoke
 FUNC (if non-nil) afterwards."
  (unless (mu4e-context-current)
    (mu4e--context-autoswitch nil mu4e-context-policy))
  (setq mu4e-pong-func (lambda (info) (mu4e--pong-handler info func)))
  (mu4e--server-ping
   (mapcar ;; send it a list of queries we'd like to see read/unread info for
    (lambda (bm)
      (funcall (or mu4e-query-rewrite-function #'identity)
               (plist-get bm :query)))
    ;; exclude bookmarks that are not strings, and with certain flags
    (seq-filter (lambda (bm)
                  (and (stringp (plist-get bm :query))
                       (not (or (plist-get bm :hide)
				(plist-get bm :hide-unread)))))
                (append (mu4e-bookmarks)
                        (mu4e--maildirs-with-query)))))
  ;; maybe request the list of contacts, automatically refreshed after
  ;; reindexing
  (unless mu4e--contacts-set (mu4e--request-contacts-maybe)))

(defun mu4e--stop ()
  "Stop mu4e."
  (when mu4e--update-timer
    (cancel-timer mu4e--update-timer)
    (setq mu4e--update-timer nil))
  (mu4e-clear-caches)
  (mu4e--server-kill)
  ;; kill all mu4e buffers
  (mapc
   (lambda (buf)
     ;; When using the Gnus-based viewer, the view buffer has the
     ;; kill-buffer-hook function mu4e~view-kill-buffer-hook-fn which kills the
     ;; mm-* buffers created by Gnus' article mode.  Those have been returned by
     ;; `buffer-list' but might already be deleted in case the view buffer has
     ;; been killed first.  So we need a `buffer-live-p' check here.
     (when (buffer-live-p buf)
       (with-current-buffer buf
         (when (member major-mode
                       '(mu4e-headers-mode mu4e-view-mode mu4e-main-mode))
           (kill-buffer)))))
   (buffer-list)))

;;; Handlers
(defun mu4e--default-handler (&rest args)
  "Dummy handler function with arbitrary ARGS."
  (mu4e-error "Not handled: %S" args))

(defun mu4e--error-handler (errcode errmsg)
  "Handler function for showing an error with ERRCODE and ERRMSG."
  ;; don't use mu4e-error here; it's running in the process filter context
  (pcase errcode
    ('4 (mu4e-warn "No matches for this search query."))
    ('110 (display-warning 'mu4e errmsg :error)) ;; schema version.
    (_ (mu4e-error "Error %d: %s" errcode errmsg))))

(defun mu4e--update-status (info)
  "Update the status message with INFO."
  (setq mu4e-index-update-status
	`(:tstamp ,(current-time)
	  :checked ,(plist-get info :checked)
          :updated  ,(plist-get info :updated)
	  :cleaned-up ,(plist-get info :cleaned-up))))

(defun mu4e--info-handler (info)
  "Handler function for (:INFO ...) sexps received from server."
  (let* ((type (plist-get info :info))
         (checked (plist-get info :checked))
         (updated (plist-get info :updated))
         (cleaned-up (plist-get info :cleaned-up))
         (mainbuf (get-buffer mu4e-main-buffer-name)))
    (cond
     ((eq type 'add) t) ;; do nothing
     ((eq type 'index)
      (if (eq (plist-get info :status) 'running)
          (mu4e-index-message
           "Indexing... checked %d, updated %d" checked updated)
        (progn ;; i.e. 'complete
	  (mu4e--update-status info)
          (mu4e-index-message
           "%s completed; checked %d, updated %d, cleaned-up %d"
           (if mu4e-index-lazy-check "Lazy indexing" "Indexing")
           checked updated cleaned-up)
          (run-hooks 'mu4e-index-updated-hook)
	  ;; backward compatibility...
	  (unless (zerop (+ updated cleaned-up))
	    mu4e-message-changed-hook)
	  (unless (and (not (string= mu4e--contacts-tstamp "0"))
                       (zerop (plist-get info :updated)))
            (mu4e--request-contacts-maybe))
          (when (and (buffer-live-p mainbuf) (get-buffer-window mainbuf))
            (save-window-excursion
              (select-window (get-buffer-window mainbuf))
              (mu4e--main-view 'refresh))))))
     ((plist-get info :message)
      (mu4e-index-message "%s" (plist-get info :message))))))

(defun mu4e--init-handlers()
  "Initialize the server message handlers.
Only set set them if they were nil before, so overriding has a
chance."
  (mu4e-setq-if-nil mu4e-error-func            #'mu4e--error-handler)
  (mu4e-setq-if-nil mu4e-update-func           #'mu4e~headers-update-handler)
  (mu4e-setq-if-nil mu4e-remove-func           #'mu4e~headers-remove-handler)
  (mu4e-setq-if-nil mu4e-view-func             #'mu4e~headers-view-handler)
  (mu4e-setq-if-nil mu4e-headers-append-func   #'mu4e~headers-append-handler)
  (mu4e-setq-if-nil mu4e-found-func            #'mu4e~headers-found-handler)
  (mu4e-setq-if-nil mu4e-erase-func            #'mu4e~headers-clear)

  (mu4e-setq-if-nil mu4e-sent-func     #'mu4e--default-handler)
  (mu4e-setq-if-nil mu4e-compose-func  #'mu4e~compose-handler)
  (mu4e-setq-if-nil mu4e-contacts-func #'mu4e--update-contacts)
  (mu4e-setq-if-nil mu4e-info-func     #'mu4e--info-handler)
  (mu4e-setq-if-nil mu4e-pong-func     #'mu4e--default-handler))

(defun mu4e-clear-caches ()
  "Clear any cached resources."
  (setq
   mu4e-maildir-list nil
   mu4e--contacts-set nil
   mu4e--contacts-tstamp "0"))
;;; _
(provide 'mu4e)
;;; mu4e.el ends here
