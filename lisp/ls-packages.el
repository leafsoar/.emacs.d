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
	projectile
	yasnippet
	undo-tree))

;; (dolist (p my-default-packages)
;;   (when (not (package-installed-p p))
;; 	(package-install p)))

(require 'dired+)

(autopair-global-mode)
(undo-tree-mode)
(projectile-global-mode)
(window-numbering-mode)

;; highlight
(add-hook 'prog-mode-hook 'highlight-numbers-mode)
(add-hook 'prog-mode-hook 'hl-todo-mode)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)
(add-hook 'prog-mode-hook 'fci-mode)
(add-hook 'prog-mode-hook 'helm-projectile-on)
(add-hook 'prog-mode-hook 'flycheck-mode)
(add-hook 'prog-mode-hook 'highlight-tail-mode)
(setq highlight-tail-colors
          '(("black" . 0)
            ("#bc2525" . 25)
            ("purple" . 66)))
(setq highlight-tail-steps '60)
(setq highlight-tail-timer '0.05)

;; helm
(setq helm-quick-update                     t ; do not display invisible candidates
      helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-buffers-fuzzy-matching           t ; fuzzy matching buffer names when non--nil
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

;; company-mode 与  fci-mode 冲突解决
(defvar-local company-fci-mode-on-p nil)
(defun company-turn-off-fci (&rest ignore)
  (when (boundp 'fci-mode)
    (setq company-fci-mode-on-p fci-mode)
    (when fci-mode (fci-mode -1))))
(defun company-maybe-turn-on-fci (&rest ignore)
  (when company-fci-mode-on-p (fci-mode 1)))
(add-hook 'company-completion-started-hook 'company-turn-off-fci)
(add-hook 'company-completion-finished-hook 'company-maybe-turn-on-fci)
(add-hook 'company-completion-cancelled-hook 'company-maybe-turn-on-fci)

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


(provide 'ls-packages)
