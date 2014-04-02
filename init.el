;; Mac Specific Setup
(if (eq system-type 'darwin)
    (progn
      ;; (setq ns-antialias-text nil) ; we need to do this based on retina
      (setq mac-option-key-is-meta nil)
      (setq mac-command-key-is-meta t)
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier nil)
      (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
      ))

;; Misc Reconfigurations
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;; Set titles for frame and icon (%f == file name, %b == buffer name)
;; (setq frame-title-format "Emacs - %f")
;; (setq icon-title-format "Emacs - %b")
;; (cd "/Users/gregory/") ; Start off in "~/" dir.

;; XXX - need to also detect how big the display is
(if window-system
      (set-frame-size (selected-frame) 80 34))

(setenv "PATH" (concat (getenv "PATH") ":~/.rvm/bin"))

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
; (add-to-list 'package-archives
;              '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("marmalade" . "http://melpa.milkbox.net/packages/"))
(package-initialize)


;; Color Theme and Zenburn
(require 'color-theme)
(load-theme 'solarized-dark t)

                                        ;

;(color-theme-select)
;(color-theme-jsc-light)
;;(color-theme-initialize)
;;(require 'zenburn-theme)

;; git support
;; DEBUG(require 'magit)
;;(require 'git-blame)

;; rvm support
(require 'rvm)
(rvm-use-default)


;; Prolog
(require 'ediprolog)
(global-set-key [f10] 'ediprolog-dwim)
(setq auto-mode-alist
      (append '(("\\.pl$" . prolog-mode)) auto-mode-alist))

;; HTML-ize
;;(require 'htmlize)


;; Ruby and Rails
;; (autoload 'ruby-mode "ruby-mode"
;;   "Mode for editing ruby source files" t)
;; (setq auto-mode-alist
;;       (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
;; (setq auto-mode-alist
;;       (append '(("\\.rake$" . ruby-mode)) auto-mode-alist))
;; (setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
;;                                      interpreter-mode-alist))
;; (push (ruby-hash-string
;;        (regexp . "\\(\\s-*\\)\\(\"[^\"]*\"\\|:[a-zA-Z]*\\)\\(\\s-*\\)=>\\(\\s-*\\)")
;;        (group . (1 3 4))
;;        (repeat . t)
;;        (modes '(ruby-mode)))
;;       align-rules-list)

;; (autoload 'run-ruby "inf-ruby"
;;   "Run an inferior Ruby process")
;; (autoload 'inf-ruby-keys "inf-ruby"
;;   "Set local key defs for inf-ruby in ruby-mode")
;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;              (inf-ruby-keys)
;;              ))

;; HAML
;;(require 'haml-mode)

; RI Mode
;; (setq ri-ruby-script "/Users/gregory/.emacs.d/ri-emacs.rb")
;; (autoload 'ri "/Users/gregory/.emacs.d/ri-ruby.el" nil t)
;; (add-hook 'ruby-mode-hook (lambda ()
;;                             (local-set-key 'f1 'ri)
;;                             (local-set-key "\M-\C-i" 'ri-ruby-complete-symbol)
;;                             (local-set-key 'f4 'ri-ruby-show-args)
;;                             ))

;; ;; Rinari
;; (require 'rhtml-mode)
;; (add-hook 'rhtml-mode-hook
;;      	  (lambda () (rinari-launch)))

;; (require 'rinari)
;; (setq rinari-tags-file-name "TAGS") ; XXX - I don't take advantage of this.

;; (add-to-list 'auto-mode-alist '("\\.rhtml\\'" . rhtml-mode))
;; (add-hook 'rhtml-mode-hook
;;           '(lambda ()
;;              (setq standard-indent 4)
;;              ))
(require 'rspec-mode)





;; Clojure inferior-lisp-mode
;; (add-hook 'clojure-mode-hook
;;           (lambda ()
;;             (setq inferior-lisp-program "lein repl")))


;; (require 'ansi-color)
;; (defun colorize-compilation-buffer ()
;;   (toggle-read-only)
;;   (ansi-color-apply-on-region (point-min) (point-max))
;;   (toggle-read-only))
;; (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; Gregory's Custumizations

; XXX Audit
; Setup Keys
(global-set-key [delete] 'delete-char)
(global-set-key [f5] 'magit-status)
(global-set-key [f6] 'compile)
(global-set-key [S-f6] 'recompile)
(global-set-key [f7] 'ispell-buffer)
(global-set-key [?\C-,] 'beginning-of-buffer)
(global-set-key [?\C-.] 'end-of-buffer)
(global-set-key [?\M-h] 'ns-do-hide-emacs) ; Make Command H behave as expected.

;;Misc KeyBindings
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)

;; Functions and Key bindings to Cut, Copy, and insert into registers 1-9
(global-set-key [?\C-`] 'gpk-copy)
(global-set-key [?\M-`] 'gpk-insert)
(defun gpk-copy (register)
  (interactive "cCopy to register: ")
  (copy-to-register register (point) (mark))
  (if mark-active (set-mark nil) ()))
(defun gpk-insert (register)
  (interactive "cInsert from register: ")
  (insert-register register (point)))


;; Helper functions
;;  XXX - should move to a seperate file
(defun find-first-non-ascii-char ()
  "Find the first non-ascii character from point onwards."
  (interactive)
  (let (point)
    (save-excursion
      (setq point
            (catch 'non-ascii
              (while (not (eobp))
                (or (eq (char-charset (following-char))
                        'ascii)
                    (throw 'non-ascii (point)))
                (forward-char 1)))))
    (if point
        (goto-char point)
        (message "No non-ascii characters."))))



;; ;; Misc Configuration
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(LilyPond-lilypond-command "/Applications/LilyPond.app/Contents/Resources/bin/lilypond")
;;  '(clojure-swank-command "echo \"~/local/bin/lein jack-in %s\" | $SHELL -l")
;;  '(coffee-command "coffee")
;;  '(column-number-mode t)
;;  '(electric-indent-mode nil)
;;  '(electric-pair-mode t)
;;  '(javascript-indent-level 2)
;;  '(js-indent-level 2)
;;  '(js2-highlight-level 3)
;;  '(js2-use-font-lock-faces t)
;;  '(mouse-wheel-mode t)
;;  '(mouse-wheel-progressive-speed nil)
;;  '(mouse-wheel-scroll-amount (quote (1 ((shift) . 5) ((control)))))
;;  '(org-agenda-files (quote ("~/Notes/gtd/index.org" "~/Notes/gtd/1life.org")))
;;  '(org-mobile-directory "/Volumes/gkeeney/gtd" t)
;;  '(quack-fontify-style (quote emacs))
;;  '(rspec-spec-command "rspec")
;;  '(rspec-use-rake-flag nil)
;;  '(ruby-electric-expand-delimiters-list nil)
;;  '(sgml-basic-offset 2)
;;  '(show-paren-mode t))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "#3f3f3f" :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "apple" :family "Menlo")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 150 :width normal :foundry "apple" :family "Droid_Sans_Mono")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediprolog-program "/opt/local/bin/swipl")
 '(rspec-use-opts-file-when-available nil)
 '(rspec-use-rake-when-possible nil)
 '(rspec-use-rvm t))
