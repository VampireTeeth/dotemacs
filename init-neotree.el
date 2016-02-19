(require 'neotree)
(global-set-key (kbd "C-c n t") 'neotree-toggle)
(global-set-key (kbd "C-c n d") 'neotree-dir)
(define-key neotree-mode-map [return] 'neotree-enter)
