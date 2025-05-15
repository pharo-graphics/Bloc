Class {
	#name : #BlElementLocalBounds,
	#superclass : #BlElementBounds,
	#instVars : [
		'extent',
		'position'
	],
	#category : #'Bloc-Basic-Bounds'
}

{ #category : #converting }
BlElementLocalBounds >> asRectangle [
	<return: #Rectangle>
	
	 ^ self position extent: self extent
]

{ #category : #accessing }
BlElementLocalBounds >> bounds [
	"Answer a `BlBounds`"

	^ BlBounds origin: self position extent: self extent
]

{ #category : #'geometry - accessing' }
BlElementLocalBounds >> center [
	"Return a point representing a geometrical center of this bounds"
	<return: #Point>
	
	^ self position + (self extent / 2.0)
]

{ #category : #accessing }
BlElementLocalBounds >> extent [
	<return: #Point>

	^ extent
]

{ #category : #accessing }
BlElementLocalBounds >> extent: aPoint [
	"aPoint should satisfy isBlocFiniteFloatPoint and isBlocPositivePoint"

	extent := aPoint
]

{ #category : #accessing }
BlElementLocalBounds >> height [
	<return: #Number>

	^ self extent y
]

{ #category : #'geometry bounds' }
BlElementLocalBounds >> inChild: anElement [

	^ BlElementBoundsInChild new
		originalElement: self referenceElement;
		referenceElement: anElement;
		bounds: (anElement globalBoundsToMine: (BlBounds left: 0.0 top: 0.0 corner: self extent) fromParent: self referenceElement);
		yourself
]

{ #category : #'geometry bounds' }
BlElementLocalBounds >> inLocal [

	^ BlElementBoundsInLocal new
		referenceElement: self referenceElement;
		bounds: (BlBounds left: 0.0 top: 0.0 corner: self extent);
		yourself
]

{ #category : #'geometry bounds' }
BlElementLocalBounds >> inParent [

	^ BlElementBoundsInParent new
		originalElement: self referenceElement;
		referenceElement: self referenceElement;
		bounds: (self localBoundsToParent: (BlBounds left: 0.0 top: 0.0 corner: self extent));
		yourself
]

{ #category : #'geometry bounds' }
BlElementLocalBounds >> inParent: anElement [

	| subParent |
	subParent := self referenceElement.

	self referenceElement withAllParentsDo: [ :aParentElement |
		(aParentElement hasParent and: [ aParentElement parent == anElement ])
			ifTrue: [ subParent := aParentElement ] ].

	^ BlElementBoundsInParent new
		originalElement: self referenceElement;
		referenceElement: subParent;
		bounds: (anElement localBoundsToMine: (BlBounds left: 0.0 top: 0.0 corner: self extent) fromChild: self referenceElement);
		yourself
]

{ #category : #'geometry bounds' }
BlElementLocalBounds >> inSpace [
	
	^ BlElementBoundsInSpace new
		referenceElement: self referenceElement;
		bounds: (self localBoundsToSpace: (BlBounds left: 0.0 top: 0.0 corner: self extent));
		yourself
]

{ #category : #initialization }
BlElementLocalBounds >> initialize [
	super initialize.

	position := 0.0@0.0.
	extent := 0.0@0.0
]

{ #category : #accessing }
BlElementLocalBounds >> position [
	"Return bounds position (an origin) as a Point"
	<return: #Point>
	
	^ position
]

{ #category : #accessing }
BlElementLocalBounds >> position: aPoint [
	"aPoint should satisfy #isBlocFiniteFloatPoint"
	
	position := aPoint
]

{ #category : #'geometry bounds' }
BlElementLocalBounds >> transformed [
	<return: #BlElementBounds>

	^ self inLocal transformed
]

{ #category : #accessing }
BlElementLocalBounds >> width [
	<return: #Number>

	^ self extent x
]
