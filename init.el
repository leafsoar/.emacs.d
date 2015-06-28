;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  _                    
;; | |__   __ _ ___  ___ 
;; | '_ \ / _` / __|/ _ \
;; | |_) | (_| \__ \  __/
;; |_.__/ \__,_|___/\___|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 编辑 init.el 文件
(defun ls-edit()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

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

;; 自动保存文件光标位置
(setq-default save-place t)
(require 'saveplace)
;; 设定不产生备份文件
(setq make-backup-files nil)
;;自动保存模式
(setq auto-save-mode t)
;; 不生成临时文件
(setq-default make-backup-files nil)
;; C-x C-f 扩展
(ido-mode t)
(setq tab-always-indent nil)
;; 扩展 path
(setq exec-path (append exec-path '("/usr/local/bin/")))
(setq ido-enable-flex-matching t)
;; 平滑滚动
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; 显示成对的括号
(show-paren-mode t)
;; 显示时间
;; (display-time)
;; (setq display-time-24hr-format t)
;; (setq display-time-day-and-date t)
;; (setq display-time-interval 10)

(when (window-system)
  (global-linum-mode t)
  )

(setq default-frame-alist
	  (append
	   '((top . 200)
		 (left . 450)
		 (width . 86))
	   default-frame-alist))

;; 设置宽度
(setq default-tab-width 4)
(setq tab-width 4
	  indent-tabs-mode t
	  c-basic-offset 4)

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
