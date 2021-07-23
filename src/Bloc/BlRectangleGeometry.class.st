Class {
	#name : 'BlRectangleGeometry',
	#superclass : 'BlElementGeometry',
	#category : 'Bloc-Basic'
}

{ #category : 'geometry testing' }
BlRectangleGeometry >> containsPoint: aPoint in: aBlElement [
	"Note: we have to pass BlElement in order to give geometry a chance to use element properties
	as as border during the testing process"
	<return: #Boolean>
	
	(aPoint x < 0 and: [ aPoint y < 0 ])
		ifTrue: [ ^ false ].

	^ aPoint x < aBlElement width
		and: [ aPoint y < aBlElement height ]
]

{ #category : 'api - bounds' }
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

{ #category : 'geometry' }
BlRectangleGeometry >> matchElement: anElement [
	"Adapt me to match the size of a given element"
]

{ #category : 'api - cache' }
BlRectangleGeometry >> releaseCache [
]

{ #category : 'api - cache' }
BlRectangleGeometry >> releaseStrokedBoundsCache [
]

{ #category : 'api - bounds' }
BlRectangleGeometry >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	"Return stroked bounds of a geometry if it would be stroked according to element's border configuration.
	Dispatch through outskirts first"
	<return: #BlBounds>
	
	^ anElement outskirts strokedBounds: aBlBounds of: anElement on: aCanvas
]

{ #category : 'private - bounds' }
BlRectangleGeometry >> strokedBoundsCentered: aBlBounds of: aBlElement on: aCanvas [
	<return: #BlBounds>
	| aHalfWidth |

	aHalfWidth := aBlElement border width / 2.0.

	^ aBlBounds
		left: aHalfWidth negated
		top: aHalfWidth negated
		right: aBlElement width + aHalfWidth
		bottom: aBlElement height + aHalfWidth
]

{ #category : 'private - bounds' }
BlRectangleGeometry >> strokedBoundsInside: aBlBounds of: aBlElement on: aCanvas [
	"Stroked inside bounds property is equal to geometry bounds"
	<return: #BlBounds>

	^ aBlBounds
		left: 0
		top: 0
		right: aBlElement width
		bottom: aBlElement height
]

{ #category : 'private - bounds' }
BlRectangleGeometry >> strokedBoundsOutside: aBlBounds of: aBlElement on: aCanvas [
	<return: #BlBounds>
	| aBorderWidth |

	aBorderWidth := aBlElement border width.

	^ aBlBounds
		left: aBorderWidth negated
		top: aBorderWidth negated
		right: aBlElement width + aBorderWidth
		bottom: aBlElement height + aBorderWidth
]
