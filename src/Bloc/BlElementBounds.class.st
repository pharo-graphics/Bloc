"
I represent rectangular bounds in a context of a reference element.
I define an API to convert element bounds from one coordinate system to other coordinate systems.

The reference element always corresponds to the element which was used to compute the bounds.

"
Class {
	#name : #BlElementBounds,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'referenceElement'
	],
	#category : #'Bloc-Basic-Bounds'
}

{ #category : #converting }
BlElementBounds >> asRectangle [
	<return: #Rectangle>
	
	^ self subclassResponsibility
]

{ #category : #'geometry - accessing' }
BlElementBounds >> bottom [
	<return: #Number>

	^ self bounds bottom
]

{ #category : #'geometry - accessing' }
BlElementBounds >> bottomCenter [
	<return: #Point>

	^ self bounds bottomCenter
]

{ #category : #'geometry - accessing' }
BlElementBounds >> bottomLeft [
	<return: #Point>

	^ self bounds bottomLeft
]

{ #category : #'geometry - accessing' }
BlElementBounds >> bottomRight [
	"Return the bottom right point of the receiver."

	^ self right @ self bottom
]

{ #category : #accessing }
BlElementBounds >> bounds [
	"Answer a `BlBounds`"
	
	^ self subclassResponsibility
]

{ #category : #'bounds conversion' }
BlElementBounds >> boundsInLocal: aBlBounds [
	"Load my local bounds in the given mutable bounds and return it.
	I do not rely on cache and always provide actual bounds.
	Local Bounds is nothing else than the bounds with origin point set to 0@0
	and with extent equal to my pure extent.
	Local Bounds property does not take effect or border into account.
	I am a part of internal api, use me with caution"

	^ aBlBounds
		left: 0.0
		top: 0.0
		corner: self extent;
		yourself
]

{ #category : #'geometry - accessing' }
BlElementBounds >> center [
	"Return a point representing a geometrical center of this bounds"
	<return: #Point>
	
	^ self bounds center
]

{ #category : #'geometry - accessing' }
BlElementBounds >> centerLeft [
	<return: #Point>

	^ self bounds centerLeft
]

{ #category : #'geometry - accessing' }
BlElementBounds >> centerRight [
	<return: #Point>

	^ self bounds centerRight
]

{ #category : #accessing }
BlElementBounds >> extent [
	"Return extent of current bounds"
	<return: #Point>
	
	^ self subclassResponsibility
]

{ #category : #'geometry - accessing' }
BlElementBounds >> height [
	<return: #Number>

	^ self extent y
]

{ #category : #'geometry bounds' }
BlElementBounds >> inChild: anElement [
	<return: #BlElementBounds>

	^ self subclassResponsibility
]

{ #category : #'geometry bounds' }
BlElementBounds >> inLocal [
	"Return a `BlElementBounds` in local coordinates."

	^ self subclassResponsibility
]

{ #category : #'geometry bounds' }
BlElementBounds >> inParent [
	"Return a `BlElementBounds` in parent coordinates."

	^ self subclassResponsibility
]

{ #category : #'geometry bounds' }
BlElementBounds >> inParent: anElement [
	<return: #BlElementBounds>

	^ self subclassResponsibility
]

{ #category : #'geometry bounds' }
BlElementBounds >> inSpace [
	"Return a `BlElementBounds` in space coordinates."

	^ self subclassResponsibility
]

{ #category : #'geometry - accessing' }
BlElementBounds >> left [
	<return: #Number>

	^ self bounds left
]

{ #category : #'bounds conversion' }
BlElementBounds >> localBoundsToParent: aBounds [
	"In-place transform bounds from local coordinates to my parent's coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."

	"first apply transformation if we have one"
	self referenceElement transformation transformBounds: aBounds.

	"then translate according to my position within the parent.
	Note, that an element might have a position even if it does not have a parent"
	aBounds translateBy: self referenceElement position.
	
	^ aBounds
]

{ #category : #'bounds conversion' }
BlElementBounds >> localBoundsToSpace: aBounds [
	"In-place transform bounds from local coordinates to space coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."

	| aCurrentElement |
	aCurrentElement := self referenceElement.

	[
		"first apply transformation if we have one"
		aCurrentElement transformation transformBounds: aBounds.

		"then translate according to my position within the parent.
		Note, that an element might have a position even if it does not have a parent"
		aBounds translateBy: aCurrentElement position.
	]
	"we must evaluate a transformation block at least once even if there is no parent"
	doWhileTrue: [
		| hasParent |
		hasParent := aCurrentElement hasParent.
		hasParent ifTrue: [ aCurrentElement := aCurrentElement parent ].
		hasParent ].

	^ aBounds
]

{ #category : #'bounds conversion' }
BlElementBounds >> localBoundsToTransformed: aBounds [
	"In-place transform bounds from local coordinates to my parent's coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."

	"first apply transformation if we have one"
	self referenceElement transformation transformBounds: aBounds.

	^ aBounds
]

{ #category : #'geometry - accessing' }
BlElementBounds >> perimeter [
	^ (self width + self height) * 2
]

{ #category : #accessing }
BlElementBounds >> position [
	"Return bounds position (an origin) as a Point"
	<return: #Point>
	
	^ self subclassResponsibility
	

]

{ #category : #printing }
BlElementBounds >> printOn: aStream [
	aStream print: self asRectangle
]

{ #category : #accessing }
BlElementBounds >> referenceElement [
	"Return a reference element that defines a coordinate system in which bounds are local.
	Reference element can not be nil"
	<return: #BlElement>
	self
		assert: [ referenceElement isNotNil ]
		description: [ 'Can not access not existing reference element' ].

	^ referenceElement
]

{ #category : #accessing }
BlElementBounds >> referenceElement: aBlElement [
	referenceElement := aBlElement
]

{ #category : #'geometry - accessing' }
BlElementBounds >> right [
	<return: #Number>

	^ self bounds right
]

{ #category : #'geometry - accessing' }
BlElementBounds >> top [
	<return: #Number>

	^ self bounds top
]

{ #category : #'geometry - accessing' }
BlElementBounds >> topCenter [
	<return: #Point>

	^ self bounds topCenter
]

{ #category : #'geometry - accessing' }
BlElementBounds >> topLeft [
	<return: #Point>

	^ self bounds topLeft
]

{ #category : #'geometry - accessing' }
BlElementBounds >> topRight [
	<return: #Point>

	^ self bounds topRight
]

{ #category : #'geometry bounds' }
BlElementBounds >> transformed [
	<return: #BlElementBounds>

	^ self subclassResponsibility
]

{ #category : #'geometry - accessing' }
BlElementBounds >> width [
	<return: #Number>

	^ self extent x
]
