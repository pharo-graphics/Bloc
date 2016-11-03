event firing
fireAsFocusInEvent: anEvent
	self dispatchEvent: anEvent asFocusInEvent target: anEvent target