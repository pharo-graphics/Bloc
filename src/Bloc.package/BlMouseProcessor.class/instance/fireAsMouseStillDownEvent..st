event firing
fireAsMouseStillDownEvent: anEvent
	self fireEvent:
			(anEvent asMouseStillDownEvent
				timestamp: Time millisecondClockValue;
				yourself)