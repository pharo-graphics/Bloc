children accessing
childrenDo: aBlock
	"Evaluate aBlock with each of my direct children as argument.
	aBlock can not be nil.
	aBlock must accept exactly one argument"
	self assert: aBlock isNotNil.
	self assert: aBlock argumentCount = 1.
	
	^ self children do: aBlock