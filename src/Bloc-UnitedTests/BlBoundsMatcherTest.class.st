"
I have been automatically converted and probably manually tweaked from BlBoundsMatcherExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlBoundsMatcherTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests'
}

{ #category : #tests }
BlBoundsMatcherTest >> testChildStartEqualParentStartWhenEquals [
	
	| aMatcher |
	aMatcher := BlBoundsMatcher new
		constraints: BlBoundsMatcherConstraints new addChildStartEqualParentStart.
	aMatcher
		childStart: 30;
		parentStart: 30.
	self assert: aMatcher matches.
	^ aMatcher
]

{ #category : #tests }
BlBoundsMatcherTest >> testChildStartEqualParentStartWhenGreater [
	
	| aMatcher |
	aMatcher := BlBoundsMatcher new
		constraints: BlBoundsMatcherConstraints new addChildStartEqualParentStart.
	aMatcher
		childStart: 40;
		parentStart: 30.
	self deny: aMatcher matches.
	^ aMatcher
]

{ #category : #tests }
BlBoundsMatcherTest >> testChildStartEqualParentStartWhenLess [
	
	| aMatcher |
	aMatcher := BlBoundsMatcher new
		constraints: BlBoundsMatcherConstraints new addChildStartEqualParentStart.
	aMatcher
		childStart: 20;
		parentStart: 30.
	self deny: aMatcher matches.
	^ aMatcher
]

{ #category : #tests }
BlBoundsMatcherTest >> testChildStartGreaterThanParentStartWhenEquals [
	
	| aMatcher |
	aMatcher := BlBoundsMatcher new
		constraints: BlBoundsMatcherConstraints new addChildStartGreaterThanParentStart.
	aMatcher
		childStart: 30;
		parentStart: 30.
	self deny: aMatcher matches.
	^ aMatcher
]

{ #category : #tests }
BlBoundsMatcherTest >> testChildStartGreaterThanParentStartWhenGreater [
	
	| aMatcher |
	aMatcher := BlBoundsMatcher new
		constraints: BlBoundsMatcherConstraints new addChildStartGreaterThanParentStart.
	aMatcher
		childStart: 40;
		parentStart: 30.
	self assert: aMatcher matches.
	^ aMatcher
]

{ #category : #tests }
BlBoundsMatcherTest >> testChildStartGreaterThanParentStartWhenLess [
	
	| aMatcher |
	aMatcher := BlBoundsMatcher new
		constraints: BlBoundsMatcherConstraints new addChildStartGreaterThanParentStart.
	aMatcher
		childStart: 20;
		parentStart: 30.
	self deny: aMatcher matches.
	^ aMatcher
]

{ #category : #tests }
BlBoundsMatcherTest >> testChildStartLessThanParentStartWhenEquals [
	
	| aMatcher |
	aMatcher := BlBoundsMatcher new
		constraints: BlBoundsMatcherConstraints new addChildStartLessThanParentStart.
	aMatcher
		childStart: 30;
		parentStart: 30.
	self deny: aMatcher matches.
	^ aMatcher
]

{ #category : #tests }
BlBoundsMatcherTest >> testChildStartLessThanParentStartWhenGreater [
	
	| aMatcher |
	aMatcher := BlBoundsMatcher new
		constraints: BlBoundsMatcherConstraints new addChildStartLessThanParentStart.
	aMatcher
		childStart: 40;
		parentStart: 30.
	self deny: aMatcher matches.
	^ aMatcher
]

{ #category : #tests }
BlBoundsMatcherTest >> testChildStartLessThanParentStartWhenLess [

	| aMatcher |
	aMatcher := BlBoundsMatcher new
		constraints: BlBoundsMatcherConstraints new addChildStartLessThanParentStart.
	aMatcher
		childStart: 20;
		parentStart: 30.
	self assert: aMatcher matches.
	^ aMatcher
]
