testing
match: aKeyEvent
	^ self charCode = aKeyEvent charCode and: [ self modifiers = aKeyEvent modifiers ]