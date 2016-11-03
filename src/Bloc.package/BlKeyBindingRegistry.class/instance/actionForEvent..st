as yet unclassified
actionForEvent: aKeyEvent
	keyBindings detect: [ :each | each match: aKeyEvent ] ifFound: [ :kb | ^ kb action ].
	^ nil