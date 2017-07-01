testing
matchEvent: aKeyEvent
	^ self key = aKeyEvent key
		and: [ self modifiers = aKeyEvent modifiers ]