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

;misc configs
(defun my:misc-configs ()
  (setq make-backup-files nil)
  (setq backup-inhibited t))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'after-init-hook 'my:misc-configs)
