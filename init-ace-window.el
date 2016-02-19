;ace-window config
(global-set-key (kbd "C-;") nil)
(global-set-key (kbd "C-;") 'ace-window)
;(add-hook 'shell-mode-hook (lambda () (define-key shell-mode-map (kbd "C-c a w") 'ace-window)))
;(global-set-key (kbd "C-x C-x") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(global-set-key (kbd "RET") 'newline-and-indent)
