focus - requesting
looseFor: anElement
	| evt |
	lastFocusOwner ~= anElement
		ifTrue: [ ^ self ].
	
	evt := BlBaseFocusEvent new
		target: anElement;
		yourself.
		
	self processBlur: evt.
	"don't forget to forget focused element"
	lastFocusOwner := nil