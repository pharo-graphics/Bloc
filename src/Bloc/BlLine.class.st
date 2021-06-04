"
I define a geometry of a straight line

"
Class {
	#name : #BlLine,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'from',
		'to'
	],
	#category : #'Bloc-Basic'
}

{ #category : #'instance creation' }
BlLine class >> from: aFromPoint to: aToPoint [
	<return: #BlLine>
	
	^ self new from: aFromPoint to: aToPoint
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

{ #category : #accessing }
BlLine >> intersectionWith: anotherSegment [
	"Copied from LineSegment>>intersectionWith:"
	| det deltaPt alpha beta pt1Dir pt2Dir |
	pt1Dir := to - from.
	pt2Dir := anotherSegment to - anotherSegment from.
	det := (pt1Dir x * pt2Dir y) - (pt1Dir y * pt2Dir x).
	deltaPt := anotherSegment from - from.
	alpha := (deltaPt x * pt2Dir y) - (deltaPt y * pt2Dir x).
	beta := (deltaPt x * pt1Dir y) - (deltaPt y * pt1Dir x).
	det = 0 ifTrue:[^nil]. "no intersection"
	alpha * det < 0 ifTrue:[^nil].
	beta * det < 0 ifTrue:[^nil].
	det > 0 
		ifTrue:[(alpha > det or:[beta > det]) ifTrue:[^nil]]
		ifFalse:[(alpha < det or:[beta < det]) ifTrue:[^nil]].
	"And compute intersection"
	^from + (alpha * pt1Dir / (det@det))
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
