;Cider configuration


(add-hook 'cider-repl-mode-hook 'company-mode)
(add-hook 'cider-mode-hook 'company-mode)

(define-key cider-mode-map (kbd "C-TAB") 'company-indent-or-complete-common)
