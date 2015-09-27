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
    ;helm
    ;ac-helm
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
    fiplr
	python-mode
	;;To use elpy, install following packages
	;;pip install rope
	;;pip install jedi
	;;pip install flake8
	;;pip install importmagic
	elpy
	;;project management package
	projectile
	;;git integration
	magit
	;;svn integration
	psvn
	;;To use ggtags, install gnu global and pygments
	;;1. Install GNU global
	;;Download GNU global
	;;./configure --prefix=<PREFIX> --with-exuberant-ctags=/usr/local/bin/ctags
	;;make && sudo make install
	;;2. Install pygments
	;;pip install pygments
	ggtags
	;;ensime for scala
	;;scala-mode2 for scala
	ensime
	scala-mode2
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



(defvar load-file-suffixes
  '("ace-window"
	"auto-complete"
	"autopair"
	"cedet"
	"elpy"
	"evil"
	"fiplr"
	"flymake"
	"function-args"
	"highlight-parentheses"
	"iedit"
	"pascal-mode"
	"tramp"
	"web-mode"
	"yasnippet"
	"projectile"
	"ggtags"
	"ensime"
	"misc"
	)
  "A list of file suffix to load.")

(dolist (s load-file-suffixes)
  (load-file (concat "~/dotemacs/init-" s ".el")))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
