"
I'm a TestCase that adapts the GT-style examples as SUnit.

These are the rules for test in subclasses:
- Any instance-side method with <gtExample> pragma is considered a test method.
- Additionally, if a <gtExample> method has a <noTest> pragma, it's skipped.

"
Class {
	#name : #BlExamplesTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests'
}

{ #category : #tests }
BlExamplesTest class >> testSelectors [
	| pragmas |
	pragmas := #(#sampleInstance #gtExample).
	^ self methods
		  select: [ :eachM | 
				(pragmas anySatisfy: [ :s | (eachM hasPragmaNamed: s)]) 
					and: [ eachM selector isUnary ] ]
		  thenCollect: [ :each | each selector ]
]

{ #category : #private }
BlExamplesTest >> performTest [ 

	| testMethod result |
	testMethod := self class methodNamed: testSelector asSymbol.
	(testMethod hasPragmaNamed: #noTest)
		ifTrue: [ self skip ].

	result := self perform: testSelector asSymbol.
	result class = BlSpace
		ifTrue: [ result close; settle ]
		ifFalse: [
			((result isKindOf: BlElement) and: [ result isAttachedToSceneGraph ]) ifTrue: [
				| sp |
				sp := result space.
				result removeFromParent.
				sp close; settle ] ].
	^ result
]
