"
I have been automatically converted and probably manually tweaked from BlElementLayoutBoundaryExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlElementLayoutBoundaryTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests'
}

{ #category : #metadata }
BlElementLayoutBoundaryTest >> originClassName [
	"This test was generated from..."
	^ 'BlElementLayoutBoundaryExamples'
]

{ #category : #tests }
BlElementLayoutBoundaryTest >> testExactLayoutBoundary01Pulse [
	<gtExample>
	| aSpace |
	aSpace := self testSpaceWithExactLayoutBoundary.
	self assert: aSpace isLayoutRequested.
	self assert: aSpace elementsNeedingLayout isEmpty.
	aSpace pulse.
	self assert: aSpace root extent equals: 500 @ 400.
	self
		assert: (aSpace root childNamed: #container) extent
		equals: 400 @ 300.
	self
		assert: (aSpace root childNamed: #boundary) extent
		equals: 300 @ 200.
	self
		assert: (aSpace root childNamed: #child) extent
		equals: 300 @ 200.
	self assert: aSpace isLayoutRequested not.
	self assert: aSpace elementsNeedingLayout isEmpty.
	^ aSpace
]

{ #category : #tests }
BlElementLayoutBoundaryTest >> testExactLayoutBoundary02RequestLayoutChild [
	<gtExample>
	| aSpace |
	aSpace := self testExactLayoutBoundary01Pulse.
	(aSpace root childNamed: #child) requestLayout.
	self assert: aSpace isLayoutRequested.
	self
		assert: aSpace elementsNeedingLayout
		equals: {(aSpace root childNamed: #boundary)} asSet.
	aSpace pulse.
	self assert: aSpace root extent equals: 500 @ 400.
	self
		assert: (aSpace root childNamed: #container) extent
		equals: 400 @ 300.
	self
		assert: (aSpace root childNamed: #boundary) extent
		equals: 300 @ 200.
	self
		assert: (aSpace root childNamed: #child) extent
		equals: 300 @ 200.
	self assert: aSpace isLayoutRequested not.
	self assert: aSpace elementsNeedingLayout isEmpty.
	^ aSpace
]

{ #category : #tests }
BlElementLayoutBoundaryTest >> testSpaceWithExactLayoutBoundary [
	<gtExample>
	| aSpace aContainer aLayoutBoundary aChild |
	aSpace := BlSpace new.
	aSpace extent: 500 @ 400.
	aContainer := BlElement new size: 400 @ 300.
	aLayoutBoundary := BlElement new size: 300 @ 200.
	aChild := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	self assert: aLayoutBoundary isLayoutBoundary.
	self assert: aChild isLayoutBoundary.
	aLayoutBoundary addChild: aChild as: #child.
	aContainer addChild: aLayoutBoundary as: #boundary.
	aSpace root addChild: aContainer as: #container.
	^ aSpace
]
