debug - asserting
assert: aBlock description: aStringOrBlock
	"Throw an assertion error if aBlock does not evaluates to true.
	
	Note: Should be enabled with ===Bloc enableAssertions==="

	self assertionsEnabled
		ifTrue: [ aBlock value == true ifFalse: [ AssertionFailure signal: aStringOrBlock value ] ]