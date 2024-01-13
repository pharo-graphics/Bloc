"
I contain useful debug utility methods that can be enabled / disabled with:

[[[
	Bloc enableAssertions.
	Bloc disableAssertions.
]]]
"
Trait {
	#name : #TBlDebug,
	#category : #'Bloc-Utilities - Debugging'
}

{ #category : #'debug - asserting' }
TBlDebug classSide >> assert: aBlock [
	"Throw an assertion error if aBlock does not evaluates to true.
	We check for true explicitly to make the assertion fail for non booleans.
	
	Note: Should be enabled with ===Bloc enableAssertions==="
	
	self assertionsEnabled
		ifTrue: [ aBlock value == true ifFalse: [ AssertionFailure signal: 'Assertion failed' ] ]
]

{ #category : #'debug - asserting' }
TBlDebug classSide >> assert: aBlock description: aStringOrBlock [
	"Throw an assertion error if aBlock does not evaluates to true.
	
	Note: Should be enabled with ===Bloc enableAssertions==="

	self assertionsEnabled
		ifTrue: [ aBlock value == true ifFalse: [ AssertionFailure signal: aStringOrBlock value ] ]
]

{ #category : #'debug - asserting' }
TBlDebug classSide >> assertionsEnabled [

	^ Bloc assertionsEnabled
]

{ #category : #'debug - asserting' }
TBlDebug >> assert: aBlock [
	"Throw an assertion error if aBlock does not evaluates to true"
	
	self class assert: aBlock
]

{ #category : #'debug - asserting' }
TBlDebug >> assert: aBlock description: aStringOrBlock [
	"Throw an assertion error if aBlock does not evaluates to true."

	self class assert: aBlock description: aStringOrBlock
]

{ #category : #'debug - asserting' }
TBlDebug >> assert: actual equals: expected [
	^ self
		assert: actual = expected
		description: [self comparingStringBetween: actual and: expected]
]

{ #category : #'debug - asserting' }
TBlDebug >> comparingStringBetween: actual and: expected [

	^ String streamContents: [:stream |
			stream
				nextPutAll: 'Got ';
				nextPutAll: actual fullPrintString;
				nextPutAll: ' instead of ';
				nextPutAll: expected fullPrintString;
				nextPutAll: '.']
]
