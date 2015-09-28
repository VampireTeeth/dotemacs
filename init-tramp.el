;tramp mode setup
(require 'tramp)
(setq tramp-default-method "ssh")
;tramp multihops that enables editing root files on remote host
(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil nil))
