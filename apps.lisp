(uiop:define-package
    :scripts/apps
    (:use :cl
	  :fare-utils
	  :uiop
	  :inferior-shell
	  :cl-scripting
	  :cl-launch/dispatch)
  (:export #:firefox
	   #:kill-firefox
	   #:stop-firefox
	   #:continue-firefox
	   #:block-screen))

(in-package :scripts/apps)

(exporting-definitions
 (defun firefox (&rest args)
   (run/i `(firefox-esr ,@args)))
 (defun kill-firefox (&rest args)
   (run `(killall ,@args firefox firefox-esr)
	:output :interactive :input :interactive :error-output nil :on-error nil)
   (success))

 (defun stop-firefox ()
   (kill-firefox "-STOP"))

 (defun block-screen ()
   (labels
       ((first-time ()
	  (total-seconds (time-now)))
	(exec ()
	  (run/i `(xtrlock)))
	(second-time ()
	  (total-seconds (time-now))))
     (let ((timeone (first-time)))
       (exec)
       (format t "~a" (sec-to-hm
		       (subtract-seconds timeone (second-time))))))))

;; INIT time functions

(defun hour-to-seconds (hour)
  (* hour 3600.0))

(defun minute-to-seconds (minutes)
  (* minutes 60.0))

(defun seconds-to-hour (seconds)
  "Return a list of hours and rest-time in seconds. Explicit transformation
in float with 3600.0."
  (multiple-value-bind
	(hour rest-seconds)
      (floor (/ seconds 3600.0))
    (list hour
	  (multiple-value-bind
		(integer)
	      (floor (hour-to-seconds rest-seconds))
	    integer))))

(defun seconds-to-minutes (seconds)
  "Return a list of minutes and rest-time in seconds."
  (multiple-value-bind
	(minutes rest-seconds)
      (floor (/ seconds 60.0))
    (list minutes
	  (multiple-value-bind
		(integer)
	      (floor (minute-to-seconds rest-seconds))
	    integer))))

(defun sec-to-hm (seconds)
  "Return a list of `hour' and `minutes' from seconds."
  (let* ((hour (car (seconds-to-hour seconds)))
	 (first-rest-of-seconds (car (cdr (seconds-to-hour seconds))))
	 (minutes (car (seconds-to-minutes first-rest-of-seconds))))
    (list hour minutes)))

(defun sum-seconds (lst)
  "Return a sum of seconds of a list."
  (if (null lst)
      0
      (+ (car lst)
	 (sum-seconds (cdr lst)))))

(defun time-now ()
  "Capture the time of the computer and return a list with
`hour', `minute' and `seconds'."
  (multiple-value-bind
	(second minute hour)
      (get-decoded-time)
    (list hour minute second)))

(defun to-seconds (lst-hms)
  "The input is a list of hour, minutes and seconds. The output is a list with the
hour in seconds, minutes in seconds and the seconds."
  (let ((hour (hour-to-seconds (car lst-hms)))
	(minute (minute-to-seconds (second lst-hms)))
	(second (car (last lst-hms))))
    (list hour minute second)))

(defun total-seconds (lst-seconds)
  "Auxiliar function. Apply the functions sum-seconds and to-seconds."
  (sum-seconds (to-seconds lst-seconds)))

(defun subtract-seconds (timeone timetwo)
  (if (> timeone timetwo)
      (error "Error: the last time is minor of first time.")
      (- timetwo timeone)))

(register-commands :scripts/apps)
