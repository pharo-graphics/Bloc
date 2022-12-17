Class {
	#name : #BlRectangleGeometry,
	#superclass : #BlElementGeometry,
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'geometry testing' }
BlRectangleGeometry >> containsPoint: aPoint in: aBlElement [
	"Note: we have to pass BlElement in order to give geometry a chance to use element properties
	as as border during the testing process"
	<return: #Boolean>
	
	(aPoint x < 0 and: [ aPoint y < 0 ])
		ifTrue: [ ^ false ].

	^ aPoint x < aBlElement width
		and: [ aPoint y < aBlElement height ]
]

{ #category : #'api - bounds' }
BlRectangleGeometry >> geometryBounds: aBlBounds of: aBlElement [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>
	
	^ aBlBounds
		left: 0
		top: 0
		right: aBlElement width
		bottom: aBlElement height
]

{ #category : #geometry }
BlRectangleGeometry >> matchElement: anElement [
	"Adapt me to match the size of a given element"
]

{ #category : #'api - cache' }
BlRectangleGeometry >> releaseCache [
]

{ #category : #'api - cache' }
BlRectangleGeometry >> releaseStrokedBoundsCache [
]
