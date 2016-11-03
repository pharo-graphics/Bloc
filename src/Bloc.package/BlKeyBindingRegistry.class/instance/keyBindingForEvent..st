as yet unclassified
keyBindingForEvent: aKeyboardEvent
	^ self keyBindings
		detect: [ :each | 
			(each charCode = aKeyboardEvent charCode) and: [ each modifiers = aKeyboardEvent modifiers ] ]
		ifNone: [ nil ]