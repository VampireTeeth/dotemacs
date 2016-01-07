;Company setup
(require 'company)
(define-key company-mode-map [(tab)] 'company-complete)
(define-key company-mode-map (kbd "C-x C-y") 'company-yasnippet)
(define-key company-mode-map [(control tab)] 'company-semantic)
(add-hook 'after-init-hook 'global-company-mode)
