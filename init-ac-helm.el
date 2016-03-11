(require 'ac-helm)  ;; Not necessary if using ELPA package
(global-set-key (kbd "C-.") 'ac-complete-with-helm)
(define-key ac-complete-mode-map (kbd "C-.") 'ac-complete-with-helm)
