as yet unclassified
partiallyMatch: aKeyEvent
	^ alternative anySatisfy: [ :each | each partiallyMatch: aKeyEvent ]