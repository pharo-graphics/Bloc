"
I'm a TestCase that adapts the GT-style examples as SUnit.

These are the rules for test in subclasses:
- Any instance-side method with <gtExample> pragma is considered a test method.
- Additionally, if a <gtExample> method has a <noTest> pragma, it's skipped.

"
Class {
	#name : #BlExamplesTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Examples'
}

{ #category : #tests }
BlExamplesTest class >> testSelectors [

	^ self methods
		  select: [ :each | (each hasPragmaNamed: #gtExample) and: [ each selector isUnary ] ]
		  thenCollect: [ :each | each selector ]
]

{ #category : #private }
BlExamplesTest >> performTest [ 

	| testMethod |
	testMethod := self class methodNamed: testSelector asSymbol.
	(testMethod hasPragmaNamed: #noTest)
		ifTrue: [ self skip ].

	^ super performTest
]
