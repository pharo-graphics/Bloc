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
FensterLogicalPositionTest >> testAsLogicalFromPhysical [

	| aLogicalPosition |
	aLogicalPosition := ((FensterLogicalPosition fromPoint: 100 @ 200) asPhysical: 2)
		asLogical: 2.
	self assert: aLogicalPosition asPoint equals: 100 @ 200.

]

{ #category : #tests }
FensterLogicalPositionTest >> testAsPhysical [

	| aLogicalPosition aPhysicalPosition |
	aLogicalPosition := FensterLogicalPosition fromPoint: 100 @ 200.
	aPhysicalPosition := aLogicalPosition asPhysical: 2.
	self assert: aPhysicalPosition asPoint equals: 200 @ 400.

]

{ #category : #tests }
FensterLogicalPositionTest >> testDefault [

	| aPosition |
	aPosition := FensterLogicalPosition new.
	self assert: aPosition isZero.
	self assert: aPosition x equals: 0.
	self assert: aPosition y equals: 0.

]

{ #category : #tests }
FensterLogicalPositionTest >> testFromPoint [

	| aPosition aPoint |
	aPoint := 100@200. 
	aPosition := FensterLogicalPosition fromPoint: aPoint.
	self assert: aPosition isZero not.
	self assert: aPosition x equals: aPoint x.
	self assert: aPosition y equals: aPoint y.
	self assert: aPosition asPoint equals: aPoint.

]
