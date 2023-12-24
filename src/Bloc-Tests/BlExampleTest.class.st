"
I'm a TestCase that adapts the GT-style examples as SUnit.

These are the rules for test in subclasses:
- Any instance-side method with <gtExample> pragma is considered a test method.
- Additionally, if a <gtExample> method has a <noTest> pragma, it's skipped.

"
Class {
	#name : #BlExampleTest,
	#superclass : #TestCase,
	#category : 'Bloc-Tests'
}

{ #category : #tests }
BlExampleTest class >> testSelectors [
	| pragmas |
	pragmas := #(#sampleInstance #gtExample).
	^ self methods
		  select: [ :eachM | 
				(pragmas anySatisfy: [ :s | (eachM hasPragmaNamed: s)]) 
					and: [ eachM selector isUnary ] ]
		  thenCollect: [ :each | each selector ]
]

{ #category : #private }
BlExampleTest >> performTest [ 

	| testMethod |
	testMethod := self class methodNamed: testSelector asSymbol.
	(testMethod hasPragmaNamed: #noTest)
		ifTrue: [ self skip ].

	^ super performTest
]
