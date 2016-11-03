as yet unclassified
match: aKeyEvent
	^ alternative anySatisfy: [ :each | each match: aKeyEvent ]