layout constraints
constraintsDo: aBlock
	"Perform aBlock with my constraints as argument.
	After evaluation requests layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument"
	self assert: aBlock isNotNil.
	self assert: aBlock argumentCount = 1.
	
	aBlock value: self constraints.
	self requestLayout