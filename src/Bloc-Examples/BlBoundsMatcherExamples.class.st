Class {
	#name : #BlBoundsMatcherExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #'examples - matcher' }
BlBoundsMatcherExamples >> childStartEqualParentStartWhenEquals [
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
BlBoundsMatcherExamples >> childStartEqualParentStartWhenGreater [
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
BlBoundsMatcherExamples >> childStartEqualParentStartWhenLess [
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
BlBoundsMatcherExamples >> childStartGreaterThanParentStartWhenEquals [
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
BlBoundsMatcherExamples >> childStartGreaterThanParentStartWhenGreater [
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
BlBoundsMatcherExamples >> childStartGreaterThanParentStartWhenLess [
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
BlBoundsMatcherExamples >> childStartLessThanParentStartWhenEquals [
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
BlBoundsMatcherExamples >> childStartLessThanParentStartWhenGreater [
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
BlBoundsMatcherExamples >> childStartLessThanParentStartWhenLess [
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
