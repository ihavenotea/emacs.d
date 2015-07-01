;; Assorted helper functions

(defun fhk-register-copy (register)
  (interactive "cCopy to register: ")
  (copy-to-register register (point) (mark))
  (if mark-active (set-mark nil) ()))

(defun fhk-register-insert (register)
  (interactive "cInsert from register: ")
  (insert-register register (point)))

(defun find-first-non-ascii-char ()
  "Find the first non-ascii character from point onwards."
  (interactive)
  (let (point)
    (save-excursion
      (setq point
            (catch 'non-ascii
              (while (not (eobp))
                (or (eq (char-charset (following-char))
                        'ascii)
                    (throw 'non-ascii (point)))
                (forward-char 1)))))
    (if point
        (goto-char point)
        (message "No non-ascii characters."))))
