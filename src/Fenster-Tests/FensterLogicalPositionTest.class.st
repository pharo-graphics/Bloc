"
I have been automatically converted and probably manually tweaked from FensterLogicalPositionExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #FensterLogicalPositionTest,
	#superclass : #TestCase,
	#category : #'Fenster-Tests'
}

{ #category : #tests }
FensterLogicalPositionTest >> fromPoint: aPoint [

	^ FensterLogicalPosition fromPoint: aPoint.
	
]

{ #category : #metadata }
FensterLogicalPositionTest >> originClassName [
	"This test was generated from..."
	^ 'FensterLogicalPositionExamples'
]

{ #category : #tests }
FensterLogicalPositionTest >> testAsLogicalFromPhysical [
	<gtExample>
	| aLogicalPosition |
	aLogicalPosition := ((self fromPoint: 100 @ 200) asPhysical: 2)
		asLogical: 2.
	self assert: aLogicalPosition asPoint equals: 100 @ 200.
	^ aLogicalPosition
]

{ #category : #tests }
FensterLogicalPositionTest >> testAsPhysical [
	<gtExample>
	| aLogicalPosition aPhysicalPosition |
	aLogicalPosition := self fromPoint: 100 @ 200.
	aPhysicalPosition := aLogicalPosition asPhysical: 2.
	self assert: aPhysicalPosition asPoint equals: 200 @ 400.
	^ aPhysicalPosition
]

{ #category : #tests }
FensterLogicalPositionTest >> testDefault [
	<gtExample>
	| aPosition |
	aPosition := FensterLogicalPosition new.
	self assert: aPosition isZero.
	self assert: aPosition x equals: 0.
	self assert: aPosition y equals: 0.
	^ aPosition
]

{ #category : #tests }
FensterLogicalPositionTest >> testFromPoint [
	<gtExample>
	| aPosition aPoint |
	aPoint := 100@200. 
	aPosition := self fromPoint: aPoint.
	self assert: aPosition isZero not.
	self assert: aPosition x equals: aPoint x.
	self assert: aPosition y equals: aPoint y.
	self assert: aPosition asPoint equals: aPoint.
	^ aPosition
]
