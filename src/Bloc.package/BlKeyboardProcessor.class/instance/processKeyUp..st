event processing
processKeyUp: anEvent
	| aTarget |

	(self buffer hasEvent: anEvent key)
		ifFalse: [ ^ self ].
	
	self buffer remove: anEvent.
	
	aTarget := self findTarget: anEvent.
	anEvent target: aTarget.
	self fireEvent: anEvent