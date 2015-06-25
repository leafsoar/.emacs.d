;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 编辑 init.el 文件
(defun ls-edit()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 测试

;; (setq default-frame-alist
;; 	  (append
;; 	   '( (top . 100)
;; 		  (left . 500))
;; 	   default-frame-alist))
;; (auto-image-file-mode nil)
;; (global-font-lock-mode t)
;; (setq org-log-done 'time)
;; (setq tab-always-indent nil)
;; (setq org-export-with-sub-superscripts nil)
;; (setq default-fill-column 80)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 环境
(setq user-full-name "leafsoar")
(setq user-mail-address "kltwjt@gmail.com")
(fset 'yes-or-no-p 'y-or-n-p)
;; minibuffer
(setq enable-recursive-minibuffers t)
(setq backup-inhibited t
      auto-save-default nil
      column-number-mode t
      inhibit-startup-message t
      kill-ring-max 200
      scroll-margin 3
	  scroll-step 1
      scroll-conservatively 10000
      visible-bell t)

;; 设定不产生备份文件 
(setq make-backup-files nil) 
;;自动保存模式  
(setq auto-save-mode t) 
;; 不生成临时文件  
(setq-default make-backup-files nil)
;; C-x C-f 扩展
(ido-mode t)
;; 扩展 path
(setq exec-path (append exec-path '("/usr/local/bin/")))

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
;; (setq display-time-24hr-format t)
;; (setq display-time-day-and-date t)
;; (setq display-time-interval 10)
;; 显示行号
(global-linum-mode t)

;; 设置宽度
(setq default-tab-width 4)
(setq tab-width 4
      indent-tabs-mode t
      c-basic-offset 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 操作

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 快捷键

;; 窗口相关
(global-set-key (kbd "M-0") 'other-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-C-z") 'undo)
(global-set-key (kbd "M-4") 'ls-kill-current-buffer)

(global-set-key [(meta g)] 'goto-line)
(global-set-key (kbd "C-=") 'set-mark-command)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-M-o") 'other-window)

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
;;;; org-mode
(add-hook 'org-mode-hook 
	  (function (lambda ()
		      (local-unset-key (kbd "C-c SPC")))))


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
    undo-tree
    sr-speedbar))

(dolist (p my-default-packages)
  (when (not (package-installed-p p))
	(package-install p)))

;; autopair
(autopair-global-mode t)
;; undo-tree
(undo-tree-mode t)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; company

(require 'company)
(dolist (hook (list
               'emacs-lisp-mode-hook
               'lisp-mode-hook
               'lisp-interaction-mode-hook
			   'lua-mode
               'scheme-mode-hook
               'c-mode-common-hook
               'python-mode-hook
               'haskell-mode-hook
               'asm-mode-hook
               'emms-tag-editor-mode-hook
               'sh-mode-hook))
  (add-hook hook 'company-mode))
(add-hook 'after-init-hook 'global-company-mode)

(global-set-key (kbd "M-/") 'company-complete)

(define-key company-active-map (kbd "\C-n") 'company-select-next)
(define-key company-active-map (kbd "\C-p") 'company-select-previous)
(define-key company-active-map (kbd "\C-d") 'company-show-doc-buffer)
;; (define-key company-active-map (kbd "\M-/") 'company-complete)

;; (add-to-list 'company-backends 'company-dabbrev t)
;; (add-to-list 'company-backends 'company-ispell t)
;; (add-to-list 'company-backends 'company-files t)
;; (add-to-list 'company-backends 'company-css t)
;; (add-to-list 'company-backends 'company-nxml t)
;; (add-to-list 'company-backends 'company-ropemacs t)
;; (add-to-list 'company-backends 'company-yasnippet t)
;; (add-to-list 'company-backends 'company-tern t)
;; not always down case
;; (setq company-dabbrev-downcase nil)

(setq lua-indent-level 4)

(message "leafsoar ~")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 其它
(when (window-system)
  (create-fontset-from-fontset-spec
   "-apple-bitstream vera sans mono-medium-r-normal--11-*-*-*-*-*-fontset-mymonaco,
ascii:-apple-Monaco-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1,
chinese-gb2312:-apple-STHeiti-medium-normal-normal-11-*-*-*-*-p-0-iso10646-1,
latin-iso8859-1:-apple-Monaco-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1,
mule-unicode-0100-24ff:-apple-Monaco-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1"))

(setq default-frame-alist (append '((font . "fontset-mymonaco")) default-frame-alist))
(set-default-font "fontset-mymonaco")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("15f77c4d76205e1b23bebb971ba9d4b7298e53390d0fdc5aa6579f7e4c14181e" default)))
 '(display-time-mode t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
