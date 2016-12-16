as yet unclassified
processKeyDown: anEvent
	self preProcess: anEvent.
	anEvent isConsumed ifTrue: [ ^ self ].
	anEvent charCode = Character tab
		ifTrue: [ 
			anEvent modifiers isShift
				ifTrue: [ self previousFocusable requestFocus ]
				ifFalse: [ self nextFocusable requestFocus ] ]