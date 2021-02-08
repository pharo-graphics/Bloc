Class {
	#name : #BlBoundsMatcherExamplesMigrated,
	#superclass : #Object,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #'examples - matcher' }
BlBoundsMatcherExamplesMigrated >> childStartEqualParentStartWhenEquals [
	<gtExample>
	| aMatcher |
	
	aMatcher := BlBoundsMatcher new
		constraints: (BlBoundsMatcherConstraints new addChildStartEqualParentStart).
	
	aMatcher
		childStart: 30;
		parentStart: 30.
	self assert: aMatcher matches.
	
	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamplesMigrated >> childStartEqualParentStartWhenGreater [
	<gtExample>
	| aMatcher |
	
	aMatcher := BlBoundsMatcher new
		constraints: (BlBoundsMatcherConstraints new addChildStartEqualParentStart).
	
	aMatcher
		childStart: 40;
		parentStart: 30.
	self assert: aMatcher matches not.
	
	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamplesMigrated >> childStartEqualParentStartWhenLess [
	<gtExample>
	| aMatcher |
	
	aMatcher := BlBoundsMatcher new
		constraints: (BlBoundsMatcherConstraints new addChildStartEqualParentStart).
		
	aMatcher
		childStart: 20;
		parentStart: 30.
	self assert: aMatcher matches not.
	
	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamplesMigrated >> childStartGreaterThanParentStartWhenEquals [
	<gtExample>
	| aMatcher |
	
	aMatcher := BlBoundsMatcher new
		constraints: (BlBoundsMatcherConstraints new addChildStartGreaterThanParentStart).
	
	aMatcher
		childStart: 30;
		parentStart: 30.
	self assert: aMatcher matches not.
	
	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamplesMigrated >> childStartGreaterThanParentStartWhenGreater [
	<gtExample>
	| aMatcher |
	
	aMatcher := BlBoundsMatcher new
		constraints: (BlBoundsMatcherConstraints new addChildStartGreaterThanParentStart).
	
	aMatcher
		childStart: 40;
		parentStart: 30.
	self assert: aMatcher matches.
	
	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamplesMigrated >> childStartGreaterThanParentStartWhenLess [
	<gtExample>
	| aMatcher |
	
	aMatcher := BlBoundsMatcher new
		constraints: (BlBoundsMatcherConstraints new addChildStartGreaterThanParentStart).
	
	aMatcher
		childStart: 20;
		parentStart: 30.
	self assert: aMatcher matches not.
	
	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamplesMigrated >> childStartLessThanParentStartWhenEquals [
	<gtExample>
	| aMatcher |
	
	aMatcher := BlBoundsMatcher new
		constraints: (BlBoundsMatcherConstraints new addChildStartLessThanParentStart).
	
	aMatcher
		childStart: 30;
		parentStart: 30.
	self assert: aMatcher matches not.
	
	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamplesMigrated >> childStartLessThanParentStartWhenGreater [
	<gtExample>
	| aMatcher |
	
	aMatcher := BlBoundsMatcher new
		constraints: (BlBoundsMatcherConstraints new addChildStartLessThanParentStart).
	
	aMatcher
		childStart: 40;
		parentStart: 30.
	self assert: aMatcher matches not.
	
	^ aMatcher
]

{ #category : #'examples - matcher' }
BlBoundsMatcherExamplesMigrated >> childStartLessThanParentStartWhenLess [
	<gtExample>
	| aMatcher |
	
	aMatcher := BlBoundsMatcher new
		constraints: (BlBoundsMatcherConstraints new addChildStartLessThanParentStart).
	
	aMatcher
		childStart: 20;
		parentStart: 30.
	self assert: aMatcher matches.
	
	^ aMatcher
]
