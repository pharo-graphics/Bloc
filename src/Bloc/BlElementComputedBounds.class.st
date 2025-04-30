"
I am a special type of element bounds with an ability to be in-place converted between coordinate systems (local <-> parent <-> global <-> window)

"
Class {
	#name : #BlElementComputedBounds,
	#superclass : #BlElementBounds,
	#instVars : [
		'bounds'
	],
	#category : #'Bloc-Basic-Bounds'
}

{ #category : #converting }
BlElementComputedBounds >> asRectangle [
	
	 ^ self bounds asRectangle
]

{ #category : #asserting }
BlElementComputedBounds >> assertNotOriginal [
	self
		assert: [ self referenceElement bounds ~~ self ]
		description: [ 'Can not modify original reference element bounds' ]
]

{ #category : #accessing }
BlElementComputedBounds >> bounds [
	"Answer a `BlBounds`"

	^ bounds
]

{ #category : #accessing }
BlElementComputedBounds >> bounds: aBlBounds [
	
	bounds := aBlBounds
]

{ #category : #accessing }
BlElementComputedBounds >> center [
	"Return a point representing a geometrical center of this bounds.
	I am an optimised version that benefits by optimisations of underlying bounds object"
	<return: #Point>
	
	^ self bounds center
]

{ #category : #accessing }
BlElementComputedBounds >> extent [
	"Return extent of current bounds"
	<return: #Point>

	^ self bounds extent
]

{ #category : #'geometry bounds' }
BlElementComputedBounds >> inChild: anElement [
	<return: #BlElementBounds>

	^ BlElementBoundsInChild new
		originalElement: self referenceElement;
		referenceElement: anElement;
		bounds: (anElement globalBoundsToMine: self bounds copy fromParent: self referenceElement);
		yourself
]

{ #category : #'geometry bounds' }
BlElementComputedBounds >> inLocal [

	^ self
]

{ #category : #'geometry bounds' }
BlElementComputedBounds >> inParent [
	self assertNotOriginal.
	
	"If reference element does not have parent local bounds can
	be treated as bounds in parent, so just return self"
	self referenceElement hasParent
		ifFalse: [ ^ self ].

	self localBoundsToParent: bounds.

	"Update our reference element to be a parent of the current reference element"
	referenceElement := self referenceElement parent
]

{ #category : #'geometry bounds' }
BlElementComputedBounds >> inParent: anElement [
	<return: #BlElementBounds>
	| subParent |
	
	subParent := self referenceElement.
	self referenceElement withAllParentsDo: [ :aParentElement |
		(aParentElement hasParent and: [ aParentElement parent == anElement ])
			ifTrue: [ subParent := aParentElement ] ].

	^ BlElementBoundsInParent new
		originalElement: self referenceElement;
		referenceElement: subParent;
		bounds: (anElement localBoundsToMine: self bounds copy fromChild: self referenceElement);
		yourself
]

{ #category : #'geometry bounds' }
BlElementComputedBounds >> inSpace [
	self assertNotOriginal.
	
	"If reference element does not have parent local bounds can
	be treated as bounds in parent, so just return self"
	self referenceElement hasParent
		ifFalse: [ ^ self ].

	self localBoundsToSpace: bounds.

	"Update our reference element to be a parent of the current reference element"
	referenceElement := self referenceElement topMostParent
]

{ #category : #accessing }
BlElementComputedBounds >> position [
	"Return bounds position (an origin) as a Point"
	<return: #Point>
	
	^ self bounds origin
]

{ #category : #'geometry bounds' }
BlElementComputedBounds >> transformed [
	self assertNotOriginal.
	
	self localBoundsToTransformed: bounds
]
