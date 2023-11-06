Class {
	#name : #BlElementBoundsTestDemo,
	#superclass : #BlExampleTest,
	#category : #'Bloc-Demo-Classes'
}

{ #category : #'test seed - demo' }
BlElementBoundsTestDemo >> child [
	<sampleInstance>
	^ BlElement new
		  size: self childExtent;
		  position: self childPosition;
		  background: Color red
]

{ #category : #helpers }
BlElementBoundsTestDemo >> childExtent [
	^ 100 @ 50
]

{ #category : #helpers }
BlElementBoundsTestDemo >> childPosition [
	^ 200 @ 150
]

{ #category : #'test seed - demo' }
BlElementBoundsTestDemo >> parent [
	<sampleInstance>
	^ BlElement new
		  size: self parentExtent;
		  position: self parentPosition;
		  background: (Color gray alpha: 0.3)
]

{ #category : #helpers }
BlElementBoundsTestDemo >> parentExtent [
	^ 500 @ 400
]

{ #category : #helpers }
BlElementBoundsTestDemo >> parentPosition [
	^ 100 @ 75
]

{ #category : #'test seed - demo' }
BlElementBoundsTestDemo >> parentWithChild [
	<sampleInstance>
	^ self parent
		addChild: self child;
		forceLayout
]

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBounds [
	"Element bounds consist of position and extent"
	<sampleInstance>
	
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInLocal [
	"Bounds in local always have position 0@0"

	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInLocalInLocal [
	<sampleInstance>
	
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInLocalInParent [
	
	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInLocalInSpace [

	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInParent [
	
	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInParentInLocal [
	
	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInParentInParent [
	
	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInParentInParentInParent [
	
	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInSpace [
	
	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInSpaceInLocal [
	
	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInSpaceInParent [
	
	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInSpecificChild [
	
	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInSpecificChildInSpecificParent [
	
	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInSpecificParent [
	
	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testBoundsInSpecificParentInSpecificChild [
	
	<sampleInstance>
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

{ #category : #'tests - demo' }
BlElementBoundsTestDemo >> testShadowEffectBoundsWithoutOffset [
	
	<sampleInstance>
	| parent child shadowWidth shadowMultiplier |
	shadowWidth := 20.
	shadowMultiplier := 1.5.
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
			(shadowWidth * shadowMultiplier asPoint negated
				corner: self childExtent + (shadowWidth * shadowMultiplier asPoint)).
	child size: self childExtent * 2.
	child forceLayout.
	self
		assert: child effectBounds
		equals:
			(shadowWidth * shadowMultiplier asPoint negated
				corner: self childExtent * 2 + (shadowWidth * shadowMultiplier asPoint)).
	^ parent
]
