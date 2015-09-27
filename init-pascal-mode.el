;pascal-mode config
(add-to-list 'auto-mode-alist '("\\.pas\\'" . pascal-mode))
(add-hook 'pascal-mode-hook
	  (lambda ()
	    (auto-complete-mode)
	    (define-key pascal-mode-map "\t" 'pascal-complete-word)
	    (define-key pascal-mode-map "\M-;" 'pascal-show-completions)
	    (set (make-local-variable 'compile-command)
		 (concat "fpc " (file-name-nondirectory (buffer-file-name))))) t)
