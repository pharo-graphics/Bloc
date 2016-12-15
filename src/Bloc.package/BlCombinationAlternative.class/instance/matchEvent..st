accessing
matchEvent: aKeyEvent
	^ alternative anySatisfy: [ :each | each matchEvent: aKeyEvent ]