event processing
processKeystroke: anEvent
	| aTarget |
	
	self keystrokesAllowed
		ifFalse: [ ^ self ].

	aTarget := self findTarget: anEvent.
	anEvent target: aTarget.
	self fireEvent: anEvent.