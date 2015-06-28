;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   _                         
;;  _ __   __ _  ___| | ____ _  __ _  ___  ___ 
;; | '_ \ / _` |/ __| |/ / _` |/ _` |/ _ \/ __|
;; | |_) | (_| | (__|   < (_| | (_| |  __/\__ \
;; | .__/ \__,_|\___|_|\_\__,_|\__, |\___||___/
;; |_|                         |___/           
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


