;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

(defun multiply-by-seven (number)
  "Multiply NUMBER by seven."
  (interactive "p")
  (message "The restul is %d" (* 7 number)))


(defun test-arg-char (arg char)
  "documentation test"
  (interactive "p\ncZap to char:")
  (message "arg=%d, char=%c" arg char))


(let ((zebra 'stripes)
      (tiger 'fierce))
  (message "One kind of animal has %s and another is %s"
	   zebra tiger))


(defun simp-begin-of-buffer ()
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


(defun simple-mark-whole-buffer ()
  "Put point at the beginning and mark at the end of the buffer."
  (interactive)
  (push-mark (point))
  (push-mark (point-max) nil t)
  (goto-char (point-min)))

(defun append-to-buffer (buffer start end)
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
