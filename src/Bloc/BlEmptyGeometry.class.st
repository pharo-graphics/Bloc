Class {
	#name : #BlEmptyGeometry,
	#superclass : #BlElementGeometry,
	#category : #'Bloc-Basic'
}

{ #category : #'geometry testing' }
BlEmptyGeometry >> containsPoint: aPoint in: aBlElement [
	"Note: we have to pass BlElement in order to give geometry a chance to use element properties
	as as border during the testing process"
	<return: #Boolean>
	
	^ false
]

{ #category : #'api - bounds' }
BlEmptyGeometry >> geometryBounds: aBlBounds of: aBlElement [
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
BlEmptyGeometry >> matchElement: anElement [
	"Adapt me to match the size of a given element"
]

{ #category : #'api - cache' }
BlEmptyGeometry >> releaseCache [
]

{ #category : #'api - cache' }
BlEmptyGeometry >> releaseStrokedBoundsCache [
]

{ #category : #'api - bounds' }
BlEmptyGeometry >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	"Return stroked bounds of a geometry if it would be stroked according to element's border configuration.
	Dispatch through outskirts first"
	<return: #BlBounds>
	
	^ aBlBounds
		left: 0
		top: 0
		right: anElement width
		bottom: anElement height
]
