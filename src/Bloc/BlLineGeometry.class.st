"
I define a geometry of a straight line
"
Class {
	#name : #BlLineGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'from',
		'to'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'instance creation' }
BlLineGeometry class >> from: aFromPoint to: aToPoint [
	<return: #BlLineGeometry>
	
	^ self new from: aFromPoint to: aToPoint
]

{ #category : #comparing }
BlLineGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self from = anObject from and: [ self to = anObject to ]
]

{ #category : #'as yet unclassified' }
BlLineGeometry >> anchorLayoutBoundsOfElement: anElement [
	
	^ self geometryBounds: BlBounds new
]

{ #category : #'geometry testing' }
BlLineGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry"

	^ aPoint
		onLineFrom: from
		to: to
		within: aBlElement border width / 2
]

{ #category : #accessing }
BlLineGeometry >> from [
	"Return start location of the line in owner element's local coordinate system"
	<return: #Point>

	^ from
]

{ #category : #accessing }
BlLineGeometry >> from: aPoint [
	self from: aPoint to: to
]

{ #category : #initialization }
BlLineGeometry >> from: aFromPoint to: aToPoint [

	(from = aFromPoint and: [ to = aToPoint ])
		ifFalse: [ self releaseCache ].

	from := aFromPoint.
	to := aToPoint
]

{ #category : #geometry }
BlLineGeometry >> geometryBounds: aBlBounds [

	^ aBlBounds rectangle: 
		(Rectangle encompassing: { 
			self from.
			self to })
]

{ #category : #testing }
BlLineGeometry >> hasCaps [

	^ true
]

{ #category : #testing }
BlLineGeometry >> hasJoins [

	^ false
]

{ #category : #initialization }
BlLineGeometry >> initialize [
	super initialize.

	from := 0@0.
	to := 0@0
]

{ #category : #geometry }
BlLineGeometry >> matchExtent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
BlLineGeometry >> to [
	"Return end location of the line in owner element's local coordinate system"
	<return: #Point>

	^ to
]

{ #category : #accessing }
BlLineGeometry >> to: aPoint [
	self from: from to: aPoint
]
