focus request
looseFor: anElement
	| evt |
	lastFocusOwner ~= anElement
		ifTrue: [ ^ self ].
	
	evt := BlBaseFocusEvent new
		target: anElement;
		yourself.
		
	self processBlur: evt