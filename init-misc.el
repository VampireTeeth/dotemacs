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
  (ido-mode 1)
  (global-set-key (kbd "C-x C-d") 'dired)
  (setq make-backup-files nil)
  (setq backup-inhibited t)
  (global-hl-line-mode 1)
  (add-to-list 'auto-mode-alist '("\\.xml\\'" . sgml-mode))
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  (put 'narrow-to-region 'disabled nil)
  (put 'downcase-region 'disabled nil)
  (load-theme 'deeper-blue))

(defun my:indentation-setup (n)
  (setq indent-tabs-mode t)
  (setq tab-width n)
  (setq tab-stop-list (number-sequence n 200 n))
  (setq sgml-basic-offset n)
  (setq c-basic-offset n)
  (setq coffee-tab-width n) ; coffeescript
  (setq javascript-indent-level n) ; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq css-indent-offset n)
  (setq python-indent n))

(add-hook 'after-init-hook 'my:misc-configs)
(add-hook 'prog-mode-hook (lambda () (my:indentation-setup 4)))
