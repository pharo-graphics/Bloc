"
I define a geometry of a bezier curve with N control points (of order N)
"
Class {
	#name : #BlBezierCurveGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'controlPoints'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'instance creation' }
BlBezierCurveGeometry class >> controlPoints: aCollection [
	^ self new controlPoints: aCollection
]

{ #category : #'geometry testing' }
BlBezierCurveGeometry >> containsPoint: aPoint in: anElement on: aSpartaCanvas [
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
BlBezierCurveGeometry >> controlPoints [
	<return: #SequenceableCollection of: #Point>

	^ controlPoints
]

{ #category : #accessing }
BlBezierCurveGeometry >> controlPoints: aCollection [
	controlPoints := aCollection.
	self releaseCache
]

{ #category : #'geometry bounds' }
BlBezierCurveGeometry >> geometryBounds: aBounds [
	^ (aBounds rectangle: (self controlPoints
			ifEmpty: [ 0@0 extent: 0@0 ]
			ifNotEmpty: [ :theControlPoints | Rectangle encompassing: theControlPoints ]))
]

{ #category : #initialization }
BlBezierCurveGeometry >> initialize [
	super initialize.

	controlPoints := #()
]

{ #category : #accessing }
BlBezierCurveGeometry >> matchExtent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
BlBezierCurveGeometry >> order [
	"Return an order of a bezier curve (how many control points it has)
	(https://en.wikipedia.org/wiki/B%C3%A9zier_curve#Specific_cases)"
	<return: #Number>

	^ self controlPoints size
]
