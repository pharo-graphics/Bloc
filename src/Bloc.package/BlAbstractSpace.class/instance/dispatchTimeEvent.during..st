pulse
dispatchTimeEvent: anEventClass during: aBlock
	| aStartTime |
	aStartTime := Time millisecondClockValue.
	aBlock value.
	self eventDispatcher dispatchEvent:
			(anEventClass new
				start: aStartTime;
				end: Time millisecondClockValue;
				yourself)