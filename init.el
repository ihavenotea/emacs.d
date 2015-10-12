;; Mac Specific Setup
(if (eq system-type 'darwin)
    (progn
      ;; (setq ns-antialias-text nil) ; we need to do this based on retina
      (setq mac-option-key-is-meta t)
      (setq mac-command-key-is-meta t)
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier nil)
      (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
      ))

;; Misc Reconfigurations
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; Paths and things
(setenv "PATH" (concat (getenv "PATH") ":~/.rvm/bin"))
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; UTF-8 Please
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Tabstop configuration
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; Kill trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Specify where backup files are stored
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/editor_backups"))))
(defconst use-backup-dir t)

;; Font Lock
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; Highlighting
(transient-mark-mode t)
(setq query-replace-highlight t)
(setq search-highlight t)

;; Show matching parens
(show-paren-mode 1)

;; Display the column number of the point in the mode line
(column-number-mode t)

(require 'package)
(add-to-list 'package-archives
              '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
    (package-install 'use-package))
(package-install 'use-package)
(require 'use-package)

;; Color Theme(s)
(defun color-theme-install (x) ()) ;; Avoid a warning when byte
				  ;; compiling solarized
(use-package color-theme-sanityinc-solarized
	     :ensure t
	     :if window-system
	     :config
	     (progn (load-theme 'sanityinc-solarized-dark t)))

;; git Support
(use-package gh :ensure t)
(setq magit-last-seen-setup-instructions "1.4.0")
;(use-package magit :ensure t)
(use-package magit-tramp :ensure t)

;; Ruby and Rails
(add-to-list 'auto-mode-alist
	     '("\\.\\(rb\\|ru\\|rake\\|gemspec\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
	     '("\\(rake\\|guard\\|gem\\)file\\'" . ruby-mode))
(use-package web-mode
	     :ensure t
	     :init
	     (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode)))

;; ECMAScript and Friends
(use-package coffee-mode
  :ensure t)

;; February's Functions
(load "support")

;; Setup Keys
(global-set-key [delete] 'delete-char)
(global-set-key [f5] 'magit-status)
(global-set-key [f6] 'compile)
(global-set-key [S-f6] 'recompile)
(global-set-key [f7] 'ispell-buffer)
(global-set-key [?\C-,] 'beginning-of-buffer)
(global-set-key [?\C-.] 'end-of-buffer)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [?\C-`] 'fhk-register-copy)
(global-set-key [?\M-`] 'fhk-register-insert)
(if (eq system-type 'darwin)
    (global-set-key [?\M-h] 'ns-do-hide-emacs))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#002b36" :foreground "#839496" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "nil" :family "Droid Sans Mono")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-attr-indent-offset nil)
 '(web-mode-code-indent-offset 2)
 '(web-mode-css-indent-offset 2)
 '(web-mode-markup-indent-offset 2))
