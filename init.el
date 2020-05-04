;;-----------------------------------------------------------
;; Initial Settings
;;-----------------------------------------------------------
(add-to-list 'load-path "~/.sys/emacs")

;-----------------------------------------------------------
; Guess Style 
;-----------------------------------------------------------
;(add-to-list 'load-path "/home/kpix/.sys/guess-style")

; needed the following to load the guess-style package correctly 2019-01-09
(require 'guess-style) 
(autoload 'guess-style-set-variable "guess-style" nil t)
(autoload 'guess-style-guess-variable "guess-style")
(autoload 'guess-style-guess-all "guess-style" nil t)
(add-hook 'python-mode-hook 'guess-style-guess-all)
(global-guess-style-info-mode 1)

;-----------------------------------------------------------
; Frames 
;-----------------------------------------------------------
(tool-bar-mode -1)

;; ido mode to find file
(require 'ido)
(ido-mode t)

;; redo hotkey: ctrl-shift-'+'
(require 'redo)
(global-set-key (quote [67108907]) (quote redo))   

;; buffer
(global-set-key (kbd "<C-tab>") 'switch-to-prev-buffer)
(global-set-key (kbd "<C-S-tab>") 'switch-to-next-buffer)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;-----------------------------------------------------------
; SmartTabs
;-----------------------------------------------------------

;; C-like language

(setq-default tab-width 4) ; or any other preferred value
(setq cua-auto-tabify-rectangles nil)

(defadvice align (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice align-regexp (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-relative (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))


(defadvice indent-according-to-mode (around smart-tabs activate)
  (let ((indent-tabs-mode indent-tabs-mode))
    (if (memq indent-line-function
	      '(indent-relative
		indent-relative-maybe))
	(setq indent-tabs-mode nil))
    ad-do-it))

(defmacro smart-tabs-advice (function offset)
  `(progn
     (defvaralias ',offset 'tab-width)
     (defadvice ,function (around smart-tabs activate)
       (cond
	(indent-tabs-mode
	 (save-excursion
	   (beginning-of-line)
	   (while (looking-at "\t*\\( +\\)\t+")
	     (replace-match "" nil nil nil 1)))
	 (setq tab-width tab-width)
	 (let ((tab-width fill-column)
	       (,offset fill-column)
	       (wstart (window-start)))
	   (unwind-protect
	       (progn ad-do-it)
	     (set-window-start (selected-window) wstart))))
	(t
	 ad-do-it)))))

(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)

;; Python, for python.el

;; (smart-tabs-advice python-indent-line-1 python-indent)
;; (add-hook 'python-mode-hook
;; 	  (lambda ()
;; 	    (setq indent-tabs-mode t)
;; 	    (setq tab-width (default-value 'tab-width))))




;; YAML MODE
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))





