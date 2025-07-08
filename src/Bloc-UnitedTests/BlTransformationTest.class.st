"
I have been automatically converted and probably manually tweaked from BlTransformationExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlTransformationTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Math'
}

{ #category : #'test seeds' }
BlTransformationTest >> element [

	^ BlElement new
		  background: Color blue;
		  extent: self extent;
		  position: self position;
		  "to compute extent and position"forceLayout
]

{ #category : #hooks }
BlTransformationTest >> extent [
	^ 100 @ 100
]

{ #category : #hooks }
BlTransformationTest >> position [
	^ 100 @ 100
]

{ #category : #tests }
BlTransformationTest >> testElTxBoundsWithScale [

	| g n |
	n := BlElement new
		     extent: 100 @ 100;
		     position: 10 @ 10;
		     yourself.

	g := BlElement new
		     extent: 200 @ 200;
		     position: 10 @ 10;
		     addChild: n;
		     yourself.

	n transform
		scaleBy: 2 @ 2;
		apply.
	g transform
		scaleBy: 2 @ 2;
		apply.

	g forceLayout.

	self assert: g position equals: 10 @ 10.
	self assert: n position equals: 10 @ 10.
	self assert: g positionInSpace equals: (90 @ 90) negated.
	self assert: n positionInSpace equals: (170 @ 170) negated.
	self
		assert: n transformedBounds
		equals: ((50 @ 50) negated extent: 200 @ 200).
	self
		assert: g transformedBounds
		equals: ((100 @ 100) negated extent: 400 @ 400)
]

{ #category : #tests }
BlTransformationTest >> testInheritFromIdentity [

	| n |
	n := BlElement new
		     extent: 100 @ 100;
		     position: 10 @ 10;
		     yourself.

	n transform
		inherit;
		scaleBy: 2 @ 2;
		apply.

	n forceLayout.
	self assert: n position equals: 10 @ 10.
	self assert: n positionInSpace equals: (40 @ 40) negated.
	self
		assert: n transformedBounds
		equals: ((50 @ 50) negated corner: 150 @ 150)
]

{ #category : #tests }
BlTransformationTest >> testReflection [
	
	| element |
	self skip.
	"opacity tests should be revisited comparing float was never a good idea."
	element := BlBasicTest new testRectangleWithImage.
	element position: self position.
	element transform
		flipX;
		flipY;
		apply.
	self flag: #noAssertion.
	^ element
]

{ #category : #tests }
BlTransformationTest >> testRotate [
	
	| element expectedOrigin expectedExtent |
	element := self element.
	element transform
		rotateBy: 45;
		apply.
	self assert: element extent equals: self extent.
	self assert: element position equals: self position.
	expectedOrigin := self extent / 2.0 * (1 - 2 sqrt).
	expectedExtent := self extent * 2 sqrt.
	self
		assert:
			(element bounds transformed bounds
				closeTo: (expectedOrigin extent: expectedExtent)).
	"transformed bounds, are local bounds with applied transformation matrix on top"
	self
		assert:
			(element bounds inParent bounds
				closeTo: (expectedOrigin + self position extent: expectedExtent)).
	"bounds in parent are transformed bounds additionally translated by #position in parent"
	^ element
]

{ #category : #tests }
BlTransformationTest >> testScale [
	
	| element expectedOrigin expectedExtent |
	element := self element.
	element transform
		scaleBy: 2 @ 2;
		apply.
	expectedOrigin := (self extent / 2.0) negated.
	expectedExtent := self extent * 2.
	self
		assert:
			(element bounds transformed bounds
				closeTo: (expectedOrigin extent: expectedExtent)).
	"transformed bounds, are local bounds with applied transformation matrix on top"
	self
		assert:
			(element bounds inParent bounds
				closeTo: (expectedOrigin + self position extent: expectedExtent)).
	"bounds in parent are transformed bounds additionally translated by #position in parent"
	^ element
]

{ #category : #tests }
BlTransformationTest >> testScaleBy [

	| n |
	n := BlElement new
		     extent: 100 @ 100;
		     position: 10 @ 10;
		     yourself.

	n transform
		scaleBy: 2 @ 2;
		apply.

	n forceLayout.
	self assert: n position equals: 10 @ 10.
	self assert: n positionInSpace equals: (40 @ 40) negated.
	self
		assert: n transformedBounds
		equals: ((50 @ 50) negated corner: 150 @ 150).

	n transform
		inherit;
		scaleBy: 0.5 @ 0.5;
		apply.
	n forceLayout.
	self assert: n transformedBounds equals: (0 @ 0 corner: 100 @ 100)
]

{ #category : #tests }
BlTransformationTest >> testScaleTo [

	| n |
	n := BlElement new
		     extent: 100 @ 100;
		     position: 10 @ 10;
		     yourself.

	n transform
		scaleBy: 2 @ 2;
		apply.
	n forceLayout.
	self assert: n position equals: 10 @ 10.
	self assert: n positionInSpace equals: (40 @ 40) negated.
	self
		assert: n transformedBounds
		equals: ((50 @ 50) negated corner: 150 @ 150).

	n transform
		scaleBy: 0.5 @ 0.5;
		apply.
	n forceLayout.
	self assert: n transformedBounds equals: (25 @ 25 corner: 75 @ 75)
]

{ #category : #tests }
BlTransformationTest >> testTranslate [

	| element expectedOrigin expectedExtent |
	element := self element.
	element transform
		translateBy: 50 @ 50;
		apply.
	expectedOrigin := 50 @ 50.
	expectedExtent := self extent.
	self
		assert:
			(element bounds transformed bounds
				closeTo: (expectedOrigin extent: expectedExtent)).
	"transformed bounds, are local bounds with applied transformation matrix on top"
	self
		assert:
			(element bounds inParent bounds
				closeTo: (expectedOrigin + self position extent: expectedExtent)).
	"bounds in parent are transformed bounds additionally translated by #position in parent"
	^ element
]

{ #category : #tests }
BlTransformationTest >> testTranslateTo [

	| n |
	n := BlElement new
		     extent: 100 @ 100;
		     position: 10 @ 10;
		     yourself.

	n transform
		translateBy: 10 @ 10;
		apply.

	n forceLayout.
	self assert: n position equals: 10 @ 10.
	self assert: n positionInSpace equals: 20 @ 20.
	self assert: n transformedBounds equals: (10 @ 10 corner: 110 @ 110).

	n transform
		translateBy: 30 @ 30;
		apply.
	n forceLayout.
	self assert: n position equals: 10 @ 10.
	self assert: n positionInSpace equals: 40 @ 40.
	self assert: n transformedBounds equals: (30 @ 30 corner: 130 @ 130)
]
