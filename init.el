;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 编辑 init.el 文件
(defun ls-edit()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 测试



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
(setq tab-always-indent nil)
;; 扩展 path
(setq exec-path (append exec-path '("/usr/local/bin/")))
(setq ido-enable-flex-matching t)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 操作

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 快捷键

;; 窗口相关
;; (global-set-key (kbd "M-1") 'delete-other-windows)
;; (global-set-key (kbd "M-4") 'ls-kill-current-buffer)
;; (global-set-key (kbd "M-5") 'delete-window)
;; (global-set-key (kbd "C-M-0") 'delete-other-windows)
(global-set-key (kbd "C--") 'delete-window)
(global-set-key (kbd "C-=") 'ls-kill-current-buffer)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; org-mode
;; org-mode config

(setq org-hide-leading-stars t)
;; (setq org-agenda-files (list "~/.leaf.org"))
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-remember)
(setq org-log-done 'time)
(setq org-export-with-sub-superscripts nil)

(add-hook 'org-mode-hook
	  (function (lambda ()
			  (local-unset-key (kbd "C-c SPC")))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 插件

;; 插件源
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
						 ("marmalade" . "http://marmalade-repo.org/packages/")
						 ("melpa" . "http://melpa.milkbox.net/packages/")))
;; (setq package-enable-at-startup nil)
(package-initialize)

;; (when (not package-archive-contents)
  ;; (package-refresh-contents))

(defvar my-default-packages
  '(autopair
	ace-jump-mode
	undo-tree))

(dolist (p my-default-packages)
  (when (not (package-installed-p p))
	(package-install p)))

;; autopair
(autopair-global-mode t)
;; undo-tree
(undo-tree-mode t)
;; ace-jump-mode
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;; highlight
(add-hook 'prog-mode-hook 'highlight-numbers-mode)
(add-hook 'prog-mode-hook 'hl-todo-mode)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)

;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; magit


;; sr-speedbar
(setq sr-speedbar-max-width 40)
(setq sr-speedbar-right-side nil)
(add-hook 'speedbar-mode-hook 'sr-speedbar-refresh-turn-off)
(setq speedbar-use-images nil)
(setq speedbar-show-unknown-files t)

;; (global-set-key [f6] 'sr-speedbar-toggle)
;; (global-set-key (kbd "C-<f6>") 'sr-speedbar-refresh-toggle)
;; (global-set-key (kbd "M-<f6>") 'speedbar-up-directory)

;;;; powerline (minibuffer 上方的条 窗口样式)
;; (powerline-center-theme)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; company

(require 'company)
(dolist (hook (list
			   'emacs-lisp-mode-hook
			   'lisp-mode-hook
			   'lisp-interaction-mode-hook
			   'lua-mode-hook
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

(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

;; golang 配置
(require 'company-go)
(add-hook 'go-mode-hook
		  (lambda ()
			(set (make-local-variable 'company-backends) '(company-go))))

(add-hook 'lua-mode-hook
		  (lambda ()
			(set (make-local-variable 'company-backends) '(company-dabbrev-code))))

(require 'company-files)
(setq company-backends '((company-capf company-dabbrev-code company-files)))

;; lua 配置
;; (require 'etags)
;; (require 'company-etags)
;; (add-hook 'lua-mode-hook
		  ;; (lambda ()
			;; (set (make-local-variable 'company-backends) '(company-etags))))
;; (setq tags-file-name "/Users/leafsoar/Cocos/cocos2d-x-3.6/TAGS")

;; (add-to-list 'company-backends 'company-files t)
;; not always down case
;; (setq company-dabbrev-downcase nil)
;; (add-hook 'after-init-hook 'global-company-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; projectile
(add-hook 'lua-mode-hook 'projectile-global-mode)
(setq projectile-enable-caching t)
(define-key global-map (kbd "M-p r") 'projectile-find-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 程序相关
(setq lua-indent-level 4)

(add-hook 'go-mode-hook
		  (lambda ()
			(add-hook 'before-save-hook 'gofmt-before-save)))
(add-hook 'prog-mode-hook 'global-auto-revert-mode t)

(add-hook 'prog-mode-hook 'hs-minor-mode)
(define-key global-map (kbd "C-c s") 'hs-show-block)
(define-key global-map (kbd "C-c h") 'hs-hide-block)
(define-key global-map (kbd "C-c S") 'hs-show-all)
(define-key global-map (kbd "C-c H") 'hs-hide-all)

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
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
	("05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "15f77c4d76205e1b23bebb971ba9d4b7298e53390d0fdc5aa6579f7e4c14181e" default)))
 '(display-time-mode t)
 '(fci-rule-color "#49483E")
 '(highlight-changes-colors ("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   (quote
	(("#49483E" . 0)
	 ("#67930F" . 20)
	 ("#349B8D" . 30)
	 ("#21889B" . 50)
	 ("#968B26" . 60)
	 ("#A45E0A" . 70)
	 ("#A41F99" . 85)
	 ("#49483E" . 100))))
 '(magit-diff-use-overlays nil)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
	((20 . "#F92672")
	 (40 . "#CF4F1F")
	 (60 . "#C26C0F")
	 (80 . "#E6DB74")
	 (100 . "#AB8C00")
	 (120 . "#A18F00")
	 (140 . "#989200")
	 (160 . "#8E9500")
	 (180 . "#A6E22E")
	 (200 . "#729A1E")
	 (220 . "#609C3C")
	 (240 . "#4E9D5B")
	 (260 . "#3C9F79")
	 (280 . "#A1EFE4")
	 (300 . "#299BA6")
	 (320 . "#2896B5")
	 (340 . "#2790C3")
	 (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#A20C41" "#F92672" "#67930F" "#A6E22E" "#968B26" "#E6DB74" "#21889B" "#66D9EF" "#A41F99" "#FD5FF0" "#349B8D" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
