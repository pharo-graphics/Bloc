period
wait
	"Do not pause UI thread if there are no background tasks. UI becomes much smoother
(Processor nextReadyProcess == Processor backgroundProcess)
		ifFalse: [ (Delay forMilliseconds: milliSecs) wait ]."
	| milliSecs |
	milliSecs := (self pulsePeriod - (Time millisecondClockValue - pulseStartTime)) min:16 max:1.
	(Delay forMilliseconds: milliSecs) wait.
	lastElpasedTime := Time millisecondClockValue.