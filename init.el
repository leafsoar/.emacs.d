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

(defun ls-td()
  (interactive)
  (find-file "~/.emacs.d/td.org"))


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
(setq default-tab-width 4
	  tab-width 4
	  indent-tabs-mode t
	  c-basic-offset 4)


;; 显示成对的括号
(show-paren-mode)
(setq-default line-spacing 1)

;; 自动保存文件光标位置
(setq-default save-place t)
(require 'saveplace)

;; 扩展 path
(setq exec-path (append exec-path '("/usr/local/bin/")))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'ls-packages)
(require 'ls-key-binding)
(require 'ls-org-mode)
(require 'ls-code)


(add-to-list 'load-path (expand-file-name "olisp" user-emacs-directory))
;; (require 'unicad)
(require 'go-rename)

(winner-mode t)

;; dired 定时自动关闭
(defun delete-buffer-after-timeout (buffer sec)
  "delete the buffer after given seconds."
  (interactive)
  (run-at-time sec nil
               (lambda (buf)
                 (unless (equal buf (current-buffer))
                   (message "killed #<buffer %s> automatically." (buffer-name buf))
                   (kill-buffer buf))) buffer))

(define-key dired-mode-map (kbd "^")
  (lambda () (interactive)
    (delete-buffer-after-timeout (current-buffer) 5)
    (find-file "..")))

;; (global-set-key (kbd "M-p c") 'flycheck-mode)
(define-key dired-mode-map (kbd "q")
  (lambda () (interactive)
    (delete-buffer-after-timeout (current-buffer) 5)
    (quit-window)))

;; compilation 有色
(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(defun colorize-compilation-buffer ()
  (interactive)
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))

(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)


(message "leafsoar ~")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 其它
;; (when (window-system)
;;   (create-fontset-from-fontset-spec
;;    "-apple-bitstream vera sans mono-medium-r-normal--11-*-*-*-*-*-fontset-mymonaco,
;; ascii:-apple-Monaco-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1,
;; chinese-gb2312:-apple-STHeiti-medium-normal-normal-11-*-*-*-*-p-0-iso10646-1,
;; latin-iso8859-1:-apple-Monaco-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1,
;; mule-unicode-0100-24ff:-apple-Monaco-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1"))
;; (setq default-frame-alist (append '((font . "fontset-mymonaco")) default-frame-alist))

(when (window-system)
  (create-fontset-from-fontset-spec
   "-apple-bitstream vera sans mono-medium-r-normal--11-*-*-*-*-*-fontset-mymonaco,
ascii:-apple-Menlo-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1,
chinese-gb2312:-apple-STHeiti-medium-normal-normal-11-*-*-*-*-p-0-iso10646-1,
latin-iso8859-1:-apple-Menlo-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1,
mule-unicode-0100-24ff:-apple-Menlo-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1"))
(setq default-frame-alist (append '((font . "fontset-mymonaco")) default-frame-alist))

(provide 'init)

