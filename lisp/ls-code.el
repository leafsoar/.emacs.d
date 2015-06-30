;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                _      
;;   ___ ___   __| | ___ 
;;  / __/ _ \ / _` |/ _ \
;; | (_| (_) | (_| |  __/
;;  \___\___/ \__,_|\___|
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

(setenv "GOPATH" (shell-command-to-string "source $HOME/.leafsoarc && printf $GOPATH"))

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

;; (add-hook 'lua-mode-hook 'imenu-list)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; projectile
(add-hook 'lua-mode-hook 'projectile-global-mode)
(setq projectile-enable-caching t)

;; ;; scroll 设置
;; (global-set-key [wheel-left] 'scroll-right-1)                                   
;; (global-set-key [wheel-right] 'scroll-left-1)
;; (global-set-key [wheel-down] 'scroll-up-1)
;; (global-set-key [wheel-up] 'scroll-down-1)
;; (global-set-key [double-wheel-down] 'scroll-down-double)
;; (global-set-key [double-wheel-up] 'scroll-up-double)
;; (global-set-key [triple-wheel-down] 'scroll-down-triple)
;; (global-set-key [triple-wheel-up] 'scroll-up-triple)
;; (defun scroll-down-double()
;;   (interactive)
;;   (scroll-up 5))
;; (defun scroll-up-double()
;;   (interactive)
;;   (scroll-down 5))
;; (defun scroll-down-triple()
;;   (interactive)
;;   (scroll-up 20))
;; (defun scroll-up-triple()
;;   (interactive)
;;   (scroll-down 20))
;; (require 'smooth-scroll)
;; (add-hook 'prog-mode-hook 'toggle-truncate-lines)
;; (smooth-scroll-mode t)
;; ;; (toggle-truncate-lines)

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

(provide 'ls-code)
