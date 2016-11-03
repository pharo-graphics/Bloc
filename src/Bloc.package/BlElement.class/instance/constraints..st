accessing
constraints: anElementConstraints
	"Set new element constraints and request layout update.
	anElementConstraints must not be nil"
	self assert: anElementConstraints isNotNil.
	constraints := anElementConstraints.

	self requestLayout