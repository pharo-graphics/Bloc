"
I define a geometry of a bezier curve with N control points (of order N)
"
Class {
	#name : #BlBezierCurve,
	#superclass : #BlGeometry,
	#instVars : [
		'controlPoints'
	],
	#category : 'Bloc-Geometry-Curves'
}

{ #category : #'instance creation' }
BlBezierCurve class >> controlPoints: aCollection [
	^ self new controlPoints: aCollection
]

{ #category : #converting }
BlBezierCurve >> asElement [
	<return: #BlElement>

	self
		assert: [ self order >= 2 ]
		description: [ 'Only Bezier curve of order 2 or higher can be converted to an element' ].

	^ BlBezierElement new
		border: (BlBorder builder paint: Color gray; width: 2; build);
		fromAnchor: (BlAbsolutePositionAnchor position: self controlPoints first);
		toAnchor: (BlAbsolutePositionAnchor position: self controlPoints last);
		in: [ :anElement | 2 to: self controlPoints size - 1 do: [ :anIndex | 
				anElement viaAnchor: (BlAbsolutePositionAnchor position: (self controlPoints at: anIndex)) ] ];
		yourself
]

{ #category : #'geometry testing' }
BlBezierCurve >> containsPoint: aPoint in: anElement on: aSpartaCanvas [
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
BlBezierCurve >> controlPoints [
	<return: #SequenceableCollection of: #Point>

	^ controlPoints
]

{ #category : #accessing }
BlBezierCurve >> controlPoints: aCollection [
	controlPoints := aCollection.
	self releaseCache
]

{ #category : #'geometry bounds' }
BlBezierCurve >> geometryBounds: aBounds [
	^ (aBounds rectangle: (self controlPoints
			ifEmpty: [ 0@0 extent: 0@0 ]
			ifNotEmpty: [ :theControlPoints | Rectangle encompassing: theControlPoints ]))
]

{ #category : #initialization }
BlBezierCurve >> initialize [
	super initialize.

	controlPoints := #()
]

{ #category : #accessing }
BlBezierCurve >> matchExtent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
BlBezierCurve >> order [
	"Return an order of a bezier curve (how many control points it has)
	(https://en.wikipedia.org/wiki/B%C3%A9zier_curve#Specific_cases)"
	<return: #Number>

	^ self controlPoints size
]
