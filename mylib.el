;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

(defun my:begin-of-buffer ()
  "Move the point to the beginning of the buffer;
leave mark at the previous position."
  (interactive)
  (push-mark)
  (goto-char (point-min)))

(defun simp-end-of-buffer ()
  "Move the point to the end of the buffer;
leave mark at the previous position."
  (interactive)
  (push-mark)
  (goto-char (point-max)))


(defun my:mark-whole-buffer ()
  "Put point at the beginning and mark at the end of the buffer."
  (interactive)
  (push-mark (point))
  (push-mark (point-max) nil t)
  (goto-char (point-min)))

(defun my:append-to-buffer (buffer start end)
  "Append the content of buffer to a specified buffer"
  (interactive
   (list
    (read-buffer "Append to buffer: " (other-buffer (current-buffer) t))
    (region-beginning)
    (region-end)))
  (let ((oldbuf (current-buffer)))
    (save-excursion
      (let* ((append-to (get-buffer-create buffer))
	     (windows (get-buffer-window-list append-to t t))
	     point)
	(set-buffer append-to);Set buffer to append-to buffer
	(setq point (point)) ;set point to current point of append-to buffer
	(barf-if-buffer-read-only) ;check if the buffer is writable
	(insert-buffer-substring oldbuf start end) ;insert the oldbuf content into current buffer
	(dolist (window windows)
	  (when (= (window-point window) point)
	    (set-window-point (porint))))))))


(defun my:copy-to-buffer (buffer start end)
  "Replace the content of a specified buffer with the selected region"
  (interactive "BCopy to buffer: \nr")
  (message "buffer=%s, start=%d, end=%d" buffer start end)
  (let* ((oldbuf (current-buffer)))
    (save-excursion
      (set-buffer (get-buffer-create buffer))
      (erase-buffer)
      (save-excursion
	(insert-buffer-substring oldbuf start end)))))


(defun my:insert-buffer (buf)
  "Insert after point the content of a buffer.
Puts the mark after the inserted text."
  (interactive "*bInsert buf: ")
  (or (bufp buf)
      (setq buf (get-buf buf)))
  (let (start end newmark)
    (save-excursion
      (save-excursion
	(set-buf buf)
	(setq start (point-min) end (point-max)))
      (insert-buf-substring buf start end)
      (setq newmark (point)))
    (push-mark newmark)))

(defun my:what-line ()
  "Prints out the line number of the cursor."
  (interactive)
  (save-restriction
    (widen)
    (save-excursion
      (beginning-of-line)
      (message
       "Line number %d"
       (1+ (count-lines 1 (point)))))))


(defun my:zap-to-char (times char)
  "Kill the region starting from
the point up to times occurence of char"
  (interactive "p\ncZap to char: ")
  (kill-region
   (point)
   (progn
     (search-forward
      (char-to-string char)
      nil nil times)
    (point))))


(defun my:copy-region-as-kill (begin end)
  "Save the region as if killed without killing it"
  (interactive "r")
  (if (eq last-command 'kill-region)
      (kill-append (filter-buffer-substring begin end) nil)
    (kill-new (filter-buffer-substring begin end)))
  (if (transient-mark-mode)
      (setq deactivate-mark t))
  nil)

(defun my:show-yank-menu ()
  (interactive)
  (popup-menu 'yank-menu))

(defun my:while-demo ()
  (interactive)
  (setq animals '(tiger bear deer wolf))
  (while animals
    (message "I am a %s" (car animals))
    (setq animals (cdr animals))))
