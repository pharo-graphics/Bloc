api - layout
constraintsDo: aBlock
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument"
	self assert: aBlock isNotNil.
	self assert: aBlock argumentCount = 1.
	
	aBlock value: self constraints.
	self requestLayout