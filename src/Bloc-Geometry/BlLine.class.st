"
I define a geometry of a straight line
"
Class {
	#name : #BlLine,
	#superclass : #BlGeometry,
	#instVars : [
		'width',
		'from',
		'to'
	],
	#category : 'Bloc-Geometry-Curves'
}

{ #category : #'instance creation' }
BlLine class >> from: aFromPoint to: aToPoint [
	<return: #BlLine>
	
	^ self new from: aFromPoint to: aToPoint
]

{ #category : #converting }
BlLine >> asElement [
	<return: #BlElement>

	^ BlLineElement new
		border: (BlBorder builder paint: Color gray; width: 2; build);
		fromAnchor: (BlAbsolutePositionAnchor position: self from);
		toAnchor: (BlAbsolutePositionAnchor position: self to);
		yourself
]

{ #category : #'geometry testing' }
BlLine >> containsPoint: aPoint in: anElement on: aSpartaCanvas [
	"Note: I am a fallback method to determine if a point lies within a geometry path
	when geometry is complex and it is mathematically difficult to compute manually"
	<return: #Boolean>
	| aPath |
	
	aPath := pathCache pathOnSpartaCanvas: aSpartaCanvas.
	^ aSpartaCanvas stroke
		path: aPath;
		width: (anElement border width max: 6);
		containsPoint: aPoint
]

{ #category : #accessing }
BlLine >> from [
	"Return start location of the line in owner element's local coordinate system"
	<return: #Point>

	^ from
]

{ #category : #accessing }
BlLine >> from: aPoint [
	self from: aPoint to: to
]

{ #category : #initialization }
BlLine >> from: aFromPoint to: aToPoint [

	(from = aFromPoint and: [ to = aToPoint ])
		ifFalse: [ self releaseCache ].

	from := aFromPoint.
	to := aToPoint
]

{ #category : #geometry }
BlLine >> geometryBounds: aBounds [
	^ (aBounds rectangle: (Rectangle encompassing: { self from . self to}))
]

{ #category : #initialization }
BlLine >> initialize [
	super initialize.

	from := 0@0.
	to := 0@0
]

{ #category : #geometry }
BlLine >> matchExtent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
BlLine >> to [
	"Return end location of the line in owner element's local coordinate system"
	<return: #Point>

	^ to
]

{ #category : #accessing }
BlLine >> to: aPoint [
	self from: from to: aPoint
]
