;;; you can MTC all you want

(require 'color)

(defvar *timer* nil)

(defun enable-rave-mode (&optional bpm)
  (unless bpm (setq bpm 175))
  (let ((wait-time (/ (/ (float bpm) 60) 8)))
    (setf *timer* (run-with-timer 0 wait-time
				  #'set-random-background-color))))

(defun disable-rave-mode ()
  (cancel-timer *timer*)
  (set-background-color "white")
  (setf *timer* nil))

(defun rave-mode ()
  (interactive)
  (if (null *timer*)
      (enable-rave-mode)
    (disable-rave-mode)))

(defun set-random-background-color ()
  (set-background-color (random-background-color)))

(defun random-background-color ()
  "Generate a suitable light background color."
  (apply #'color-rgb-to-hex
	 (apply #'color-hsl-to-rgb
		(apply #'color-lighten-hsl (append (random-color) '(50))))))

(defun random-color ()
  "Random hsl color."
  (let* ((l (make-list 3 0)))
    (mapcar (lambda (x) (/ (float (random 30)) 50)) l)))

(provide 'rave-mode)
