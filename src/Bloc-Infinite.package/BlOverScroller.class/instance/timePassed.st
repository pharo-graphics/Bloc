accessing
timePassed
	| aTime aStartTime |
	
	aTime := DateAndTime millisecondClockValue.
	aStartTime := scrollerX startTime min: scrollerY startTime.
	^ aTime - aStartTime