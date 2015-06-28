;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  _                _     _           _ _             
;; | | _____ _   _  | |__ (_)_ __   __| (_)_ __   __ _ 
;; | |/ / _ \ | | | | '_ \| | '_ \ / _` | | '_ \ / _` |
;; |   <  __/ |_| | | |_) | | | | | (_| | | | | | (_| |
;; |_|\_\___|\__, | |_.__/|_|_| |_|\__,_|_|_| |_|\__, |
;;           |___/                               |___/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; 快捷键
;; 窗口相关
;; (global-set-key (kbd "M-1") 'delete-other-windows)
;; (global-set-key (kbd "M-4") 'ls-kill-current-buffer)
;; (global-set-key (kbd "M-5") 'delete-window)
;; (global-set-key (kbd "C-M-0") 'delete-other-windows)
(global-set-key (kbd "C-0") 'ls-kill-current-buffer)
(global-set-key (kbd "C-9") 'delete-window)
(global-set-key (kbd "C--") 'delete-other-windows)

(global-set-key (kbd "M-C-z") 'undo)

(global-set-key [(meta g)] 'goto-line)
(global-set-key (kbd "C-=") 'set-mark-command)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-M-o") 'other-window)

(global-set-key "%" 'ls-match-paren)
(global-set-key (kbd "C-;") 'ls-comment-dwim-line)

(global-set-key [(control ?\.)] 'ska-point-to-register)
(global-set-key [(control ?\,)] 'ska-jump-to-register)

;; 简单的快速跳转
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register.
Use ska-jump-to-register to jump back to the stored
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))
(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
		(jump-to-register 8)
		(set-register 8 tmp)))

;; 括号跳转
(defun ls-match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

;; 代码注释
(defun ls-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
	  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
	(comment-dwim arg)))

(defun ls-kill-current-buffer()
  (interactive)
  (kill-buffer (current-buffer)))
