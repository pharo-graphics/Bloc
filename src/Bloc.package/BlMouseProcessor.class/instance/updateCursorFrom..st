event processing
updateCursorFrom: aTarget
	| t |
	t := aTarget.
	[ t cursor isNil and: [ t parent isNotNil ] ] whileTrue: [ t := t parent ].
	self space currentCursor = t cursor
		ifTrue: [ ^ self ].
	self space currentCursor: t cursor