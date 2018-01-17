event firing
fireAsMouseStillDownEvent: anEvent
	self fireEvent:
			(anEvent asMouseStillDownEvent
				timestamp: DateAndTime now;
				yourself)