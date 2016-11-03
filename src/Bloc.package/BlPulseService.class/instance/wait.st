period
wait
	| milliSecs |
	milliSecs := (self pulsePeriod - (Time millisecondClockValue - pulseStartTime)) min:16 max:1.
	(Delay forMilliseconds: milliSecs) wait.
	lastElpasedTime := Time millisecondClockValue.