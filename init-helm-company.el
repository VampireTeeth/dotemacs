(require 'helm-company)
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-.") 'helm-company)
     (define-key company-active-map (kbd "C-.") 'helm-company)))
