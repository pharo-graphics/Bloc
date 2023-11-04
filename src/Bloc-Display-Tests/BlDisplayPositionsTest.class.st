"
I have been automatically converted and probably manually tweaked from FensterLogicalPositionExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : 'BlDisplayPositionsTest',
	#superclass : 'TestCase',
	#category : 'Bloc-Display-Tests',
	#package : 'Bloc-Display-Tests'
}

{ #category : 'tests' }
BlDisplayPositionsTest >> testAsLogicalFromPhysical [

	| aLogicalPosition |
	aLogicalPosition := ((BlLogicalDisplayPosition fromPoint: 100 @ 200) asPhysical: 2)
		asLogical: 2.
	self assert: aLogicalPosition asPoint equals: 100 @ 200.

]

{ #category : 'tests' }
BlDisplayPositionsTest >> testAsPhysical [

	| aLogicalPosition aPhysicalPosition |
	aLogicalPosition := BlLogicalDisplayPosition fromPoint: 100 @ 200.
	aPhysicalPosition := aLogicalPosition asPhysical: 2.
	self assert: aPhysicalPosition asPoint equals: 200 @ 400.

]

{ #category : 'tests' }
BlDisplayPositionsTest >> testDefault [

	| aPosition |
	aPosition := BlLogicalDisplayPosition new.
	self assert: aPosition isZero.
	self assert: aPosition x equals: 0.
	self assert: aPosition y equals: 0.

]

{ #category : 'tests' }
BlDisplayPositionsTest >> testFromPoint [

	| aPosition aPoint |
	aPoint := 100@200. 
	aPosition := BlLogicalDisplayPosition fromPoint: aPoint.
	self assert: aPosition isZero not.
	self assert: aPosition x equals: aPoint x.
	self assert: aPosition y equals: aPoint y.
	self assert: aPosition asPoint equals: aPoint.

]

{ #category : 'tests' }
BlDisplayPositionsTest >> testPointAsLogicalPosition [
	
	| logical |
	logical := (100@300) asLogicalPosition.
	self assert: logical class equals: BlLogicalDisplayPosition.
	self assert: logical y equals: 300.
	self assert: logical x equals: 100.

]

{ #category : 'tests' }
BlDisplayPositionsTest >> testPointAsLogicalSize [
	
	| logical |
	logical := (100@300) asLogicalSize.
	self assert: logical class equals: BlLogicalDisplaySize.
	self assert: logical height equals: 300.
	self assert: logical width equals: 100.

]

{ #category : 'tests' }
BlDisplayPositionsTest >> testPointAsPhysicalPosition [
	
	| logical |
	logical := (100@300) asPhysicalPosition.
	self assert: logical class equals: BlPhysicalDisplayPosition.
	self assert: logical y equals: 300.
	self assert: logical x equals: 100.

]

{ #category : 'tests' }
BlDisplayPositionsTest >> testPointAsPhysicalSize [
	
	| logical |
	logical := (100@300) asPhysicalSize.
	self assert: logical class equals: BlPhysicalDisplaySize.
	self assert: logical height equals: 300.
	self assert: logical width equals: 100.

]
