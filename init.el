;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 编辑 init.el 文件
(defun ls-edit()
  (interactive)
  (find-file "~/.emacs.d/init.el"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 外观
(when (window-system)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (message "windows-system"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 环境

;; minibuffer
(setq enable-recursive-minibuffers t)
(setq scroll-margin 3
      scroll-conservatively 10000)
(display-time)
;; C-x C-f 扩展
(ido-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 操作

;; 窗口相关
(global-set-key (kbd "M-4") 'ls-kill-current-buffer)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-0") 'other-window)
(global-set-key (kbd "M-C-z") 'undo)

(global-set-key (kbd "C-=") 'set-mark-command)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-M-o") 'other-window)
(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "C-; ") 'ls-comment-dwim-line)

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
;;;; 插件

;; 插件源
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("tromey" . "tromey.com/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(message "leafsoar ~")
