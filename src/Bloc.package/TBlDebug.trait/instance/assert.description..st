debug - asserting
assert: aBlock description: aStringOrBlock
	"Throw an assertion error if aBlock does not evaluates to true.
	
	Note: Should be enabled with ===Bloc enableAssertions==="
	
	Bloc assertionsEnabled
		ifTrue: [ aBlock value ifFalse: [ AssertionFailure signal: aStringOrBlock value ] ]