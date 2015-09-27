(defun my:elpy-config ()
  (elpy-enable)
  (define-key python-mode-map (kbd "TAB") 'elpy-company-backend))

(add-hook 'python-mode-hook 'my:elpy-config)
