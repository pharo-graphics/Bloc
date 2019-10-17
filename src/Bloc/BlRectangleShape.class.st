Class {
	#name : #BlRectangleShape,
	#superclass : #BlCompositeShape,
	#classVars : [
		'RectangleCornerAttribute',
		'RectangleEdgeAttribute'
	],
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #'class initialization' }
BlRectangleShape class >> initialize [
	RectangleEdgeAttribute := #rectangleEdge.
	RectangleCornerAttribute := #rectangleCorner.
]

{ #category : #accessing }
BlRectangleShape class >> rectangle: aRectangle [
	| aShape topLeft topRight bottomLeft bottomRight topEdge rightEdge bottomEdge leftEdge |

	aShape := self new.

	topLeft := BlConnectionPointShape new point: aRectangle topLeft.
	topLeft attributes at: RectangleCornerAttribute put: #topLeft.

	topRight := BlConnectionPointShape new point: aRectangle topRight.
	topRight attributes at: RectangleCornerAttribute put: #topRight.
	
	bottomRight := BlConnectionPointShape new point: aRectangle bottomRight.
	bottomRight attributes at: RectangleCornerAttribute put: #bottomRight.
	
	bottomLeft := BlConnectionPointShape new point: aRectangle bottomLeft.
	bottomLeft attributes at: RectangleCornerAttribute put: #bottomLeft.

	topEdge := BlLineShape new
		fromPoint: topLeft;
		toPoint: topRight.
	topEdge attributes at: RectangleEdgeAttribute put: #top.

	rightEdge := BlLineShape new
		fromPoint: topRight;
		toPoint: bottomRight.
	rightEdge attributes at: RectangleEdgeAttribute put: #right.
		
	bottomEdge := BlLineShape new
		fromPoint: bottomRight;
		toPoint: bottomLeft.
	bottomEdge attributes at: RectangleEdgeAttribute put: #bottom.
		
	leftEdge := BlLineShape new
		fromPoint: bottomLeft;
		toPoint: topLeft.
	leftEdge attributes at: RectangleEdgeAttribute put: #left.
		
	^ aShape shapes: { topEdge . rightEdge . bottomEdge . leftEdge }
]

{ #category : #accessing }
BlRectangleShape >> appendPathTo: aPathBuilder [
	self topEdge appendPathTo: aPathBuilder.
	self topRightCorner appendPathTo: aPathBuilder.
	self rightEdge appendPathTo: aPathBuilder.
	self bottomRightCorner appendPathTo: aPathBuilder.
	self bottomEdge appendPathTo: aPathBuilder.
	self bottomLeftCorner appendPathTo: aPathBuilder.
	self leftEdge appendPathTo: aPathBuilder.
	self topLeftCorner appendPathTo: aPathBuilder
]

{ #category : #'api - geometry' }
BlRectangleShape >> bottomEdge [
	^ self shapeWithAttribute: RectangleEdgeAttribute value: #bottom
]

{ #category : #'api - geometry' }
BlRectangleShape >> bottomLeftCorner [
	^ self shapeWithAttribute: RectangleCornerAttribute value: #bottomLeft
]

{ #category : #'api - geometry' }
BlRectangleShape >> bottomRightCorner [
	^ self shapeWithAttribute: RectangleCornerAttribute value: #bottomRight
]

{ #category : #'api - geometry' }
BlRectangleShape >> leftEdge [
	^ self shapeWithAttribute: RectangleEdgeAttribute value: #left
]

{ #category : #'api - geometry' }
BlRectangleShape >> rightEdge [
	^ self shapeWithAttribute: RectangleEdgeAttribute value: #right
]

{ #category : #'api - geometry' }
BlRectangleShape >> topEdge [
	^ self shapeWithAttribute: RectangleEdgeAttribute value: #top
]

{ #category : #'api - geometry' }
BlRectangleShape >> topLeftCorner [
	^ self shapeWithAttribute: RectangleCornerAttribute value: #topLeft
]

{ #category : #'api - geometry' }
BlRectangleShape >> topRightCorner [
	^ self shapeWithAttribute: RectangleCornerAttribute value: #topRight
]
