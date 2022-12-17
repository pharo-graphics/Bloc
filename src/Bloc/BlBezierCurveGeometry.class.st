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

{ #category : #accessing }
BlBezierCurveGeometry >> controlPoints [

	^ controlPoints
]

{ #category : #accessing }
BlBezierCurveGeometry >> controlPoints: aCollection [
	"The collection can have between 2 and 4 points."

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
