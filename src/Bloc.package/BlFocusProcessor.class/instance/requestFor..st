focus request
requestFor: anElement
	| evt |
	lastFocusOwner = anElement
		ifTrue: [ ^ self ].
	
	evt := BlBaseFocusEvent new
		target: lastFocusOwner;
		yourself.
		
	self processBlur: evt.
	evt target: anElement.
	self processFocus: evt