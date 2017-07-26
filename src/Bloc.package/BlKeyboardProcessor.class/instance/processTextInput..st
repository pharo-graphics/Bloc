event processing
processTextInput: anEvent
	| aTarget |
	
	aTarget := self findTarget: anEvent.
	anEvent target: aTarget.
	self fireEvent: anEvent.