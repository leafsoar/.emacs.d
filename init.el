;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 编辑 init.el 文件
(defun ls-edit()
  (interactive)
  (find-file "~/.emacs.d/init.el"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 外观
(when (window-system)
  (tool-bar-mode 0)			;关闭 tool-bar
  (scroll-bar-mode 0)			;关闭 scroll-bar
  (message "windows-system"))

;; 显示成对的括号
(show-paren-mode t)
;; 显示时间
(display-time)
;; 显示行号
(global-linum-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 环境

;; minibuffer
(setq enable-recursive-minibuffers t)
(setq backup-inhibited t
      auto-save-default nil
      column-number-mode t
      inhibit-startup-message t
      kill-ring-max 200
      scroll-margin 3
      scroll-conservatively 10000
      visible-bell t)


;; C-x C-f 扩展
(ido-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 操作


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 快捷键

;; 窗口相关
(global-set-key (kbd "M-0") 'other-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-C-z") 'undo)
(global-set-key (kbd "M-4") 'ls-kill-current-buffer)


(global-set-key (kbd "C-=") 'set-mark-command)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-M-o") 'other-window)
(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key "%" 'ls-match-paren)
(global-set-key (kbd "C-; ") 'ls-comment-dwim-line)

(global-set-key [(control ?\.)] 'ska-point-to-register)
(global-set-key [(control ?\,)] 'ska-jump-to-register)

;; 简单的快速跳转
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register. 
Use ska-jump-to-register to jump back to the stored 
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))>
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

;; 关闭 buffer
(defun ls-kill-current-buffer()
  (interactive)
  (kill-buffer (current-buffer)))

;; 代码注释
(defun ls-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 其它


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 插件

;; 插件源
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("tromey" . "tromey.com/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
;; (setq package-enable-at-startup nil) 
(package-initialize)

;; (when (not package-archive-contents)
  ;; (package-refresh-contents))

(defvar my-default-packages
  '(autopair
    ace-jump-mode
    powerline
    sr-speedbar))

(dolist (p my-default-packages)
  (when (not (package-installed-p p))
	(package-install p)))

;; autopair
(autopair-global-mode t)
;; ace-jump-mode
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;; sr-speedbar
(setq sr-speedbar-max-width 40)
(setq sr-speedbar-right-side nil)
(global-set-key [f6] 'sr-speedbar-toggle)
(global-set-key (kbd "C-<f6>") 'sr-speedbar-refresh-toggle)
(global-set-key (kbd "M-<f6>") 'speedbar-up-directory)
;; powerline (minibuffer 上方的条 窗口样式)
;; (powerline-center-theme)

(message "leafsoar ~")
