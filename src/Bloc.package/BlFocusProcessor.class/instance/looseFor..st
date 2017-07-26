focus - requesting
looseFor: anElement
	| evt |
	focusOwner ~= anElement
		ifTrue: [ ^ self ].
	
	evt := BlBaseFocusEvent new
		target: anElement;
		yourself.
		
	self processBlur: evt.
	"don't forget to forget focused element"
	focusOwner := nil