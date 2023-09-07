(use-package cal-china-x
			 :init
			 (setq org-agenda-include-diary t) 
			 (setq org-agenda-diary-file "~/org/standard-diary") 
			 (setq diary-file "~/org/standard-diary") 
			 )
;; diary in org-agenda-view 
;Sunrise and Sunset 
;;日出而作 
(defun diary-sunrise () 
  (let ((dss (diary-sunrise-sunset))) 
	(with-temp-buffer 
	  (insert dss) 
	  (goto-char (point-min)) 
	  (while (re-search-forward " ([^)]*)" nil t) 
			 (replace-match "" nil nil)) 
	  (goto-char (point-min)) 
	  (search-forward ",") 
	  (buffer-substring (point-min) (match-beginning 0))))) 

;; sunset 日落而息 
(defun diary-sunset () 
  (let ((dss (diary-sunrise-sunset)) 
		start end) 
	(with-temp-buffer 
	  (insert dss) 
	  (goto-char (point-min)) 
	  (while (re-search-forward " ([^)]*)" nil t) 
			 (replace-match "" nil nil)) 
	  (goto-char (point-min)) 
	  (search-forward ", ") 
	  (setq start (match-end 0)) 
	  (search-forward " at") 
	  (setq end (match-beginning 0)) 
	  (goto-char start) 
	  (capitalize-word 1) 
	  (buffer-substring start end)))) 
;Sunrise and Sunset 

(setq calendar-longitude 108) ;;long是经度, 东经 
(setq calendar-latitude 22)	 ;;lat, flat, 北纬 

;; 中文的天干地支 
(setq calendar-chinese-celestial-stem ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"]) 
(setq calendar-chinese-terrestrial-branch ["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"]) 

(setq mark-holidays-in-calendar t) 
(require 'cal-china-x)
(setq cal-china-x-important-holidays cal-china-x-chinese-holidays) 
(setq calendar-holidays 
	  (append cal-china-x-important-holidays 
			  cal-china-x-general-holidays 
			  holiday-general-holidays 
			  holiday-christian-holidays 
			  )) 
;;中美的节日. 

;; display Chinese date 
(setq org-agenda-format-date 'zeroemacs/org-agenda-format-date-aligned) 

(defun zeroemacs/org-agenda-format-date-aligned (date) 
  "Format a DATE string for display in the daily/weekly agenda, or timeline. 
  This function makes sure that dates are aligned for easy reading." 
  (require 'cal-iso) 
  (let* ((dayname (aref cal-china-x-days 
						(calendar-day-of-week date))) 
		 (day (cadr date)) 
		 (month (car date)) 
		 (year (nth 2 date)) 
		 (cn-date (calendar-chinese-from-absolute (calendar-absolute-from-gregorian date))) 
		 (cn-month (cl-caddr cn-date)) 
		 (cn-day (cl-cadddr cn-date)) 
		 (cn-month-string (concat (aref cal-china-x-month-name 
										(1- (floor cn-month))) 
								  (if (integerp cn-month) 
									"" 
									"(闰月)"))) 
		 (cn-day-string (aref cal-china-x-day-name 
							  (1- cn-day)))) 
	(format "%04d-%02d-%02d 周%s %s%s" year month 
			day dayname cn-month-string cn-day-string))) 
;;今天的日期高亮
(defface my-calendar-today-date-face
		 '((t :inherit calendar-today :underline t))
		 "Face for highlighting today's date in the calendar.")

(defun my-calendar-mark-today ()
  "Highlight today's date in the calendar."
  (when (calendar-date-is-visible-p (calendar-current-date))
	(calendar-mark-visible-date (calendar-current-date) 'my-calendar-today-date-face)))

(add-hook 'calendar-today-visible-hook 'my-calendar-mark-today)


(provide 'rili-init)
;;;rili-init.el ends here


