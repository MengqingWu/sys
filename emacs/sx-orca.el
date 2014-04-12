;-----------------------------------------------------------
;  User Info
;-----------------------------------------------------------
(setq user-full-name "Xin Shi")
(setq user-mail-address "xshi@xshi.org")

;-----------------------------------------------------------
;  Frequently used Mode after the pack-list load 
;-----------------------------------------------------------
(helm-mode 1)

;-----------------------------------------------------------
; Auto-Complete
;-----------------------------------------------------------
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)

;-----------------------------------------------------------
; CMake 
;-----------------------------------------------------------
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
		("\\.cmake\\'" . cmake-mode))
	      auto-mode-alist))

;-----------------------------------------------------------
; Markdown
;-----------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

;-----------------------------------------------------------
; Aspell 
;-----------------------------------------------------------
(setq ispell-program-name "aspell")

;-----------------------------------------------------------
; tramp fix 
;-----------------------------------------------------------

;; (tramp-compat-funcall
;;  'buffer-substring-no-properties
;;  (point-min)
;;  (min (+ (point-min) tramp-echo-mark-marker-length) (point-max)))

;-----------------------------------------------------------
; Chinese font 
;-----------------------------------------------------------

(when (display-graphic-p) 
  (setq fonts 
        (cond ((eq system-type 'darwin)     '("Monaco"     "STHeiti")) 
              ((eq system-type 'gnu/linux)  '("Menlo"     "WenQuanYi Zen Hei")) 
              ((eq system-type 'windows-nt) '("Consolas"  "Microsoft Yahei")))) 
  
  (setq face-font-rescale-alist '(("STHeiti" . 1.2)
				  ("Microsoft Yahei" . 1.2) 
				  ("WenQuanYi Zen Hei" . 1.2))) 
  (set-face-attribute 'default nil :font 
                      (format "%s:pixelsize=%d" (car fonts) 14)) 
  (dolist (charset '(kana han symbol cjk-misc bopomofo)) 
    (set-fontset-font (frame-parameter nil 'font) charset 
                      (font-spec :family (car (cdr fonts)))))) 

;-----------------------------------------------------------
; Org LaTeX 
;-----------------------------------------------------------
(require 'org-latex)
(add-to-list 'org-export-latex-classes
             '("cjk"
               "\\documentclass{article}
               [NO-DEFAULT-PACKAGES]
               [EXTRA]"
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
