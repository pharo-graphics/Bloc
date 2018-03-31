period
wait
	"Do not pause UI thread if there are no background tasks. UI becomes much smoother
(Processor nextReadyProcess == Processor backgroundProcess)
		ifFalse: [ (Delay forMilliseconds: milliSecs) wait ]."
	| milliSecs |
	milliSecs := (self pulsePeriod - (DateAndTime now - pulseStartTime)) min: 16 milliSeconds max: 0 milliSeconds.
	milliSecs isZero
		ifFalse: [ milliSecs wait ].

	lastElpasedTime := DateAndTime now