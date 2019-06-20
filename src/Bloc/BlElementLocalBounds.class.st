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
	<return: #BlBounds>

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
	^ extent
]

{ #category : #accessing }
BlElementLocalBounds >> extent: anObject [
	extent := anObject
]

{ #category : #accessing }
BlElementLocalBounds >> height [
	^ self extent y
]

{ #category : #'geometry bounds' }
BlElementLocalBounds >> inChild: anElement [
	<return: #BlElementBounds>

	^ BlElementBoundsInChild new
		originalElement: self referenceElement;
		referenceElement: anElement;
		bounds: (anElement globalBoundsToMine: (BlBounds new left: 0 top: 0 corner: self extent) fromParent: self referenceElement);
		yourself
]

{ #category : #'geometry bounds' }
BlElementLocalBounds >> inLocal [
	<return: #BlElementBounds>

	^ BlElementBoundsInLocal new
		referenceElement: self referenceElement;
		bounds: (BlBounds new left: 0 top: 0 corner: self extent);
		yourself
]

{ #category : #'geometry bounds' }
BlElementLocalBounds >> inParent [
	<return: #BlElementBounds>
	
	^ BlElementBoundsInParent new
		originalElement: self referenceElement;
		referenceElement: self referenceElement;
		bounds: (self localBoundsToParent: (BlBounds new left: 0 top: 0 corner: self extent));
		yourself
]

{ #category : #'geometry bounds' }
BlElementLocalBounds >> inParent: anElement [
	<return: #BlElementBounds>
	| subParent |
	
	subParent := self referenceElement.
	self referenceElement withAllParentsDo: [ :aParentElement |
		(aParentElement hasParent and: [ aParentElement parent == anElement ])
			ifTrue: [ subParent := aParentElement ] ].

	^ BlElementBoundsInParent new
		originalElement: self referenceElement;
		referenceElement: subParent;
		bounds: (anElement localBoundsToMine: (BlBounds new left: 0 top: 0 corner: self extent) fromChild: self referenceElement);
		yourself
]

{ #category : #'geometry bounds' }
BlElementLocalBounds >> inSpace [
	<return: #BlElementBounds>
	
	^ BlElementBoundsInSpace new
		referenceElement: self referenceElement;
		bounds: (self localBoundsToSpace: (BlBounds new left: 0 top: 0 corner: self extent));
		yourself
]

{ #category : #initialization }
BlElementLocalBounds >> initialize [
	super initialize.

	position := 0@0.
	extent := 0@0
]

{ #category : #accessing }
BlElementLocalBounds >> position [
	"Return bounds position (an origin) as a Point"
	<return: #Point>
	
	^ position
]

{ #category : #accessing }
BlElementLocalBounds >> position: anObject [
	position := anObject
]

{ #category : #accessing }
BlElementLocalBounds >> seamlessDefaultTransferStrategy [ 
	^SeamlessTransferStrategy defaultByDeepCopy
]

{ #category : #'geometry bounds' }
BlElementLocalBounds >> transformed [
	<return: #BlElementBounds>

	^ self inLocal transformed
]

{ #category : #accessing }
BlElementLocalBounds >> width [
	^ self extent x
]
