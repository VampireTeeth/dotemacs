;web-mode config
(require 'web-mode)

(defun my:web-mode-auto-mode ()
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode)))

(defun my:web-mode-setup ()
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-css-colorization t))

(add-hook 'after-init-hook 'my:web-mode-auto-mode)
(add-hook 'web-mode-hook 'my:web-mode-setup)
