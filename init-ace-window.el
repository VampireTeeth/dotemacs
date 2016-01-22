;ace-window config
(global-set-key (kbd "M-p") 'ace-window)
(add-hook 'shell-mode-hook (lambda () (define-key shell-mode-map (kbd "C-c M-p") 'ace-window)))
;(global-set-key (kbd "C-x C-x") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(global-set-key (kbd "RET") 'newline-and-indent)
