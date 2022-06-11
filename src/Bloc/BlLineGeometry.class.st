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
BlLineGeometry >> geometryBounds: aBounds [
	^ (aBounds rectangle: (Rectangle encompassing: { self from . self to}))
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
