; start package.el with emacs
(require 'package)
; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;initialize package.el
(package-initialize)

;installing a list of packages
(require 'cl)
(defvar prelude-packages
  ;;'(ack-and-a-half auctex clojure-mode coffee-mode deft expand-region
  ;;                 gist groovy-mode haml-mode haskell-mode inf-ruby
  ;;                 magit magithub markdown-mode paredit projectile python
  ;;                 sass-mode rainbow-mode scss-mode solarized-theme
  ;;                 volatile-highlights yaml-mode yari zenburn-theme)
  '(
    auto-complete
    ;company
    helm
    ac-helm
    function-args
    yasnippet
    evil
    auto-complete-c-headers
    ;flymake-google-cpplint
    autopair
    highlight-parentheses
    ace-window
    auto-complete-clang
    paredit
    iedit
    clojure-mode
    cider
    php-mode
    web-mode
    smarty-mode
    ;eww-lnum
    )
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  (loop for p in prelude-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (prelude-packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs Prelude is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p prelude-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;load the wombat theme
(load-theme 'wombat)

;start yasnippet with emacs
(require 'yasnippet)
  (yas-global-mode 1)

;start evil-mode with emacs
(require 'evil)
(evil-mode 1)


;iedit configuration
(define-key global-map (kbd "C-c ;") 'iedit-mode)


;helm-config configuration
(require 'helm-config)
(helm-mode 1)
;rebind tab to do persistent action
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(global-set-key (kbd "C-x C-h C-f") 'helm-find)
;(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-f") 'find-file)

;ac-helm configuration
(require 'ac-helm)
(global-set-key (kbd "C-:") 'ac-complete-with-helm)
(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)

;autopair configuration
(require 'autopair)
(add-hook 'prog-mode-hook 'autopair-mode)

;highlight parenthesis configuration
(require 'highlight-parentheses)
(global-highlight-parentheses-mode 1)
;;(add-hook 'prog-mode-hook 'highlight-parentheses-mode)


;Turn on Semantics (CEDET)
;Semantic setup
(require 'cc-mode)
(require 'semantic)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(semantic-mode 1)

;auto-complete setup
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;Company setup
;(require 'company)
;(define-key company-mode-map [(tab)] 'company-complete)
;(define-key company-mode-map (kbd "C-x C-y") 'company-yasnippet)
;(define-key company-mode-map [(control tab)] 'company-semantic)
;(add-hook 'after-init-hook 'global-company-mode)

;function-args setup
(require 'function-args)
(fa-config-default)
;;(define-key c-mode-map [(control tab)] 'moo-complete)
;;(define-key c++-mode-map [(control tab)] 'moo-complete)
(define-key c-mode-map (kbd "M-o") 'fa-show)
(define-key c++-mode-map (kbd "M-o") 'fa-show)

;tramp mode setup
(require 'tramp)
(setq tramp-default-method "ssh")

;ace-window config
;(global-set-key (kbd "M-p") 'ace-window)
(global-set-key (kbd "C-x C-x") 'ace-window)
(global-set-key (kbd "RET") 'newline-and-indent)


;pascal-mode config
(add-to-list 'auto-mode-alist '("\\.pas\\'" . pascal-mode))
(add-hook 'pascal-mode-hook
	  (lambda ()
	    (auto-complete-mode)
	    (define-key pascal-mode-map "\t" 'pascal-complete-word)
	    (define-key pascal-mode-map "\M-;" 'pascal-show-completions)
	    (set (make-local-variable 'compile-command)
		 (concat "fpc " (file-name-nondirectory (buffer-file-name))))) t)

;eww config
;(require 'eww-lnum)
;(require 'eww)


;web-mode config
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

;smarty-mode config
(require 'smarty-mode)




;Helper functions
(defun my:pprint-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t)
      (backward-char) (insert "\n"))
    (indent-region begin end))
  (message "Ah, much better!"))

;misc configs
(defun my:misc-configs ()
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)
  (setq make-backup-files nil)
  (setq backup-inhibited t))

(defun my:indentation-setup (n)
  (setq indent-tabs-mode nil)
  (setq tab-width n)
  (setq tab-stop-list (number-sequence n 200 n))
  (setq c-basic-offset n)
  (setq coffee-tab-width n) ; coffeescript
  (setq javascript-indent-level n) ; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq css-indent-offset n))

(defun my:load-path-env ()
  (interactive)
  (let* ((path (shell-command-to-string "source ~/.profile; echo -n $PATH"))
	 (newpath (concat (getenv "PATH") path)))
    (message "New PATH is: %s" newpath)
    (setq exec-path
	  (append
	   (split-string-and-unquote path ":")
	   exec-path))))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'after-init-hook 'my:misc-configs)
;;(add-hook 'prog-mode-hook 'my:misc-configs)
(add-hook 'prog-mode-hook (lambda () (my:indentation-setup 2)))

(put 'narrow-to-region 'disabled nil)
