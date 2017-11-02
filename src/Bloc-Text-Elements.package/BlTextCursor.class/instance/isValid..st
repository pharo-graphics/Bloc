testing
isValid: aBrText
	"Return true if this cursor position is valid for a given text, false otherwise"
	<return: #Boolean>
	
	self
		assert: [ self position >= 0 ]
		description: [ 'Cursor position must not be negative' ].
	
	"Zero position is always allowed, independent of text"
	self position isZero
		ifTrue: [ ^ self ].
	
	^ self position <= aBrText size