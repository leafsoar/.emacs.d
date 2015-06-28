;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   ___  _ __ __ _       _ __ ___   ___   __| | ___ 
;;  / _ \| '__/ _` |_____| '_ ` _ \ / _ \ / _` |/ _ \
;; | (_) | | | (_| |_____| | | | | | (_) | (_| |  __/
;;  \___/|_|  \__, |     |_| |_| |_|\___/ \__,_|\___|
;;            |___/

;;;; org-mode
(setq org-hide-leading-stars t)
;; (setq org-agenda-files (list "~/.leaf.org"))
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-remember)
(setq org-log-done 'time)
(setq org-export-with-sub-superscripts nil)

(add-hook 'org-mode-hook
	  (function (lambda ()
			  (local-unset-key (kbd "C-c SPC")))))
