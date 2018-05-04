api - touch up
processTouchUp: aTouchUpEvent
	
	self fireEvent: aTouchUpEvent.
	
	self updateCursorFrom: aTouchUpEvent target