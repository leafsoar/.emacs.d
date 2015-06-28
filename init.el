;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  _                    
;; | |__   __ _ ___  ___ 
;; | '_ \ / _` / __|/ _ \
;; | |_) | (_| \__ \  __/
;; |_.__/ \__,_|___/\___|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; 环境
(setq user-full-name "leafsoar")
(setq user-mail-address "kltwjt@gmail.com")

;; 编辑 init.el 文件
(defun ls-edit()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)

;;自动保存模式
(setq auto-save-mode t
	  make-backup-files t
	  kept-old-versions 3
	  kept-new-versions 3
	  delete-old-versions t
	  backup-directory-alist '(("." . "~/.emacs.d/backup")))

;; 窗口样式
(menu-bar-mode 0)
(when (window-system)
  (global-linum-mode)
  (menu-bar-mode)
  (tool-bar-mode 0)
  (scroll-bar-mode 0))

(setq enable-recursive-minibuffers t)
(setq column-number-mode t
	  kill-ring-max 200
	  scroll-margin 3
	  scroll-step 1
	  scroll-conservatively 10000
	  visible-bell t)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq default-frame-alist
	  (append
	   '((top . 200)
		 (left . 450)
		 (width . 86))
	   default-frame-alist))
(setq tab-always-indent nil)
;; 设置宽度
(setq default-tab-width 4)
(setq tab-width 4
	  indent-tabs-mode t
	  c-basic-offset 4)

;; 显示成对的括号
(show-paren-mode)

;; 自动保存文件光标位置
(setq-default save-place t)
(require 'saveplace)

;; C-x C-f 扩展
(ido-mode t)
;; 扩展 path
(setq exec-path (append exec-path '("/usr/local/bin/")))
(setq ido-enable-flex-matching t)

(load "~/.emacs.d/ls-key-binding.el")
(load "~/.emacs.d/ls-org-mode.el")
(load "~/.emacs.d/ls-packages.el")
(load "~/.emacs.d/ls-code.el")

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
