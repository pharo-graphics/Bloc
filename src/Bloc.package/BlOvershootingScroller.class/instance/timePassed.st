accessing
timePassed
	"Returns the time elapsed since the beginning of the scrolling."
	<return: #Duration>
	| aTime aStartTime |
	
	aTime := DateAndTime millisecondClockValue.
	aStartTime := scrollerX startTime min: scrollerY startTime.

	^ aTime - aStartTime