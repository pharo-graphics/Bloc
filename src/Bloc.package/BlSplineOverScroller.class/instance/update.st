updating
update
	"Update the current position and velocity for current time.
	Returns true if update has been done and false if animation duration has been reached."
	<return: #Boolean>

	^ self mode updateOn: self