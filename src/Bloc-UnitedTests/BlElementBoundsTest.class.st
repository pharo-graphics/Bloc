"
I have been automatically converted and probably manually tweaked from BlElementBoundsExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlElementBoundsTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests'
}

{ #category : #'test seed' }
BlElementBoundsTest >> child [
	<gtExample>
	^ BlElement new
		size: self childExtent;
		position: self childPosition;
		background: Color red
]

{ #category : #helpers }
BlElementBoundsTest >> childExtent [
	^ 100 @ 50
]

{ #category : #helpers }
BlElementBoundsTest >> childPosition [
	^ 200 @ 150
]

{ #category : #metadata }
BlElementBoundsTest >> originClassName [
	"This test was generated from..."
	^ 'BlElementBoundsExamples'
]

{ #category : #'test seed' }
BlElementBoundsTest >> parent [
	<gtExample>
	^ BlElement new
		size: self parentExtent;
		position: self parentPosition;
		background: (Color gray alpha: 0.3)
]

{ #category : #helpers }
BlElementBoundsTest >> parentExtent [
	^ 500 @ 400
]

{ #category : #helpers }
BlElementBoundsTest >> parentPosition [
	^ 100 @ 75
]

{ #category : #'test seed' }
BlElementBoundsTest >> parentWithChild [
	<gtExample>
	^ self parent
		addChild: self child;
		forceLayout
]

{ #category : #tests }
BlElementBoundsTest >> testBounds [
	"Element bounds consist of position and extent"

	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.
	self
		assert: child bounds asRectangle
		equals: (self childPosition extent: self childExtent).
	self
		assert: parent bounds asRectangle
		equals: (self parentPosition extent: self parentExtent).
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInLocal [
	"Bounds in local always have position 0@0"

	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.
	self
		assert: child bounds inLocal asRectangle
		equals: (0.0 @ 0.0 extent: self childExtent).
	self
		assert: parent bounds inLocal asRectangle
		equals: (0.0 @ 0.0 extent: self parentExtent).
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInLocalInLocal [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.
	self
		assert: child bounds inLocal inLocal asRectangle
		equals: (0 @ 0 extent: self childExtent).
	self
		assert: parent bounds inLocal inLocal asRectangle
		equals: (0 @ 0 extent: self parentExtent).
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInLocalInParent [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.
	self
		assert: child bounds inLocal inParent asRectangle
		equals: (self childPosition extent: self childExtent).
	self
		assert: child bounds inLocal inParent referenceElement
		equals: child.
	self
		assert: parent bounds inLocal inParent asRectangle
		equals: (self parentPosition extent: self parentExtent).
	self
		assert: parent bounds inLocal inParent referenceElement
		equals: parent.
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInLocalInSpace [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.
	self
		assert: child bounds inLocal inSpace asRectangle
		equals: (self childPosition + self parentPosition extent: self childExtent).
	self
		assert: child bounds inLocal inSpace referenceElement
		equals: child.
	self
		assert: parent bounds inLocal inSpace asRectangle
		equals: (self parentPosition extent: self parentExtent).
	self
		assert: parent bounds inLocal inSpace referenceElement
		equals: parent.
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInParent [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.
	self
		assert: child bounds inParent asRectangle
		equals: (self childPosition extent: self childExtent).
	self assert: child bounds inParent referenceElement equals: child.
	self
		assert: parent bounds inParent asRectangle
		equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inParent referenceElement equals: parent.
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInParentInLocal [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.
	self
		assert: child bounds inParent inLocal asRectangle
		equals: (self childPosition extent: self childExtent).
	self
		assert: child bounds inParent inLocal referenceElement
		equals: child.
	self
		assert: parent bounds inParent inLocal asRectangle
		equals: (self parentPosition extent: self parentExtent).
	self
		assert: parent bounds inParent inLocal referenceElement
		equals: parent.
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInParentInParent [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.
	self
		assert: child bounds inParent inParent asRectangle
		equals: (self childPosition + self parentPosition extent: self childExtent).
	self
		assert: child bounds inParent inParent referenceElement
		equals: parent.
	self
		assert: parent bounds inParent inParent asRectangle
		equals: (self parentPosition extent: self parentExtent).
	self
		assert: parent bounds inParent inParent referenceElement
		equals: parent.
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInParentInParentInParent [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.
	self
		assert: child bounds inParent inParent inParent asRectangle
		equals: (self childPosition + self parentPosition extent: self childExtent).
	self
		assert: child bounds inParent inParent inParent referenceElement
		equals: parent.
	self
		assert: parent bounds inParent inParent inParent asRectangle
		equals: (self parentPosition extent: self parentExtent).
	self
		assert: parent bounds inParent inParent inParent referenceElement
		equals: parent.
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInSpace [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.
	self
		assert: child bounds inSpace asRectangle
		equals: (self childPosition + self parentPosition extent: self childExtent).
	self assert: child bounds inSpace referenceElement equals: child.
	self
		assert: parent bounds inSpace asRectangle
		equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inSpace referenceElement equals: parent.
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInSpaceInLocal [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.
	self
		assert: child bounds inSpace inLocal asRectangle
		equals: (self childPosition + self parentPosition extent: self childExtent).
	self
		assert: child bounds inSpace inLocal referenceElement
		equals: child.
	self
		assert: parent bounds inSpace inLocal asRectangle
		equals: (self parentPosition extent: self parentExtent).
	self
		assert: parent bounds inSpace inLocal referenceElement
		equals: parent.
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInSpaceInParent [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.
	self
		assert: child bounds inSpace inParent asRectangle
		equals: (self childPosition + self parentPosition extent: self childExtent).
	self
		assert: child bounds inSpace inParent referenceElement
		equals: child.
	self
		assert: parent bounds inSpace inParent asRectangle
		equals: (self parentPosition extent: self parentExtent).
	self
		assert: parent bounds inSpace inParent referenceElement
		equals: parent.
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInSpecificChild [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.

	"(child bounds inChild: child) === (child bounds inLocal)"
	self
		assert: (child bounds inChild: child) asRectangle
		equals: (0 @ 0 extent: self childExtent).
	self
		assert: (child bounds inChild: child) referenceElement
		equals: child.
	self
		assert: (parent bounds inChild: child) asRectangle
		equals: (self childPosition negated extent: self parentExtent).
	self
		assert: (parent bounds inChild: child) referenceElement
		equals: child.
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInSpecificChildInSpecificParent [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.

	"((child bounds inChild: child) inParent: child) === (child bounds inLocal)"
	self
		assert: ((child bounds inChild: child) inParent: child) asRectangle
		equals: (0 @ 0 extent: self childExtent).
	self
		assert: ((child bounds inChild: child) inParent: child) referenceElement
		equals: child.

	"((parent bounds inChild: child) inParent: parent) === (parent bounds)"
	self
		assert: ((parent bounds inChild: child) inParent: parent) asRectangle
		equals: (0 @ 0 extent: self parentExtent).

	"the reason why reference element is `child` is because bounds in parent have a child as a reference element"
	self
		assert: ((parent bounds inChild: child) inParent: parent) referenceElement
		equals: child.
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInSpecificParent [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.
	self
		assert: (child bounds inParent: parent) asRectangle
		equals: (self childPosition extent: self childExtent).
	self
		assert: (child bounds inParent: parent) referenceElement
		equals: child.

	"(parent bounds inParent: parent) === (parent bounds inLocal)"
	self
		assert: (parent bounds inParent: parent) asRectangle
		equals: (0 @ 0 extent: self parentExtent).
	self
		assert: (parent bounds inParent: parent) referenceElement
		equals: parent.
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testBoundsInSpecificParentInSpecificChild [
	<gtExample>
	| parent child |
	parent := self parentWithChild.
	child := parent children first.

	"((child bounds inParent: parent) inChild: child) === (child bounds inLocal)"
	self
		assert: ((child bounds inParent: parent) inChild: child) asRectangle
		equals: (0 @ 0 extent: self childExtent).
	self
		assert: ((child bounds inParent: parent) inChild: child) referenceElement
		equals: child.

	"((parent bounds inParent: parent) inChild: parent) === (parent bounds inLocal)"
	self
		assert: ((parent bounds inParent: parent) inChild: parent) asRectangle
		equals: (0 @ 0 extent: self parentExtent).

	"the reason why reference element is `child` is because bounds in parent have a child as a reference element"
	self
		assert: ((parent bounds inParent: parent) inChild: parent) referenceElement
		equals: parent.
	^ parent
]

{ #category : #tests }
BlElementBoundsTest >> testShadowEffectBoundsWithoutOffset [
	<gtExample>
	| parent child shadowWidth |
	shadowWidth := 20.
	parent := self parentWithChild.
	child := parent children first.
	child
		effect:
			(BlGaussianShadowEffect
				color: Color black
				width: shadowWidth
				offset: 0 @ 0).
	self
		assert: child effectBounds
		equals:
			(shadowWidth * 3 asPoint negated
				corner: self childExtent + (shadowWidth * 3 asPoint)).
	child size: self childExtent * 2.
	child forceLayout.
	self
		assert: child effectBounds
		equals:
			(shadowWidth * 3 asPoint negated
				corner: self childExtent * 2 + (shadowWidth * 3 asPoint)).
	^ parent
]
