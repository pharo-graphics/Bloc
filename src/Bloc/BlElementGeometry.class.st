Class {
	#name : #BlElementGeometry,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Basic'
}

{ #category : #converting }
BlElementGeometry >> asElement [
	"Create an appropriate element with me as its geometry.
	By default create an instance of the basic BlElement simply setting its
	geometry to me. Subclasses may be converted to more specific elements"
	<return: #BlElement>

	^ BlElement new
		size: self extent;
		background: (Color gray alpha: 0.4);
		border: (BlBorder builder paint: Color gray; width: 2; build);
		geometry: self
]

{ #category : #'geometry testing' }
BlElementGeometry >> containsPoint: aPoint in: aBlElement [
	"Note: we have to pass BlElement in order to give geometry a chance to use element properties
	as as border during the testing process"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'api - bounds' }
BlElementGeometry >> geometryBounds: aBounds of: aBlElement [
	"Load my geometry bounds for a given element in a mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
BlElementGeometry >> matchElement: anElement [
	"Adapt me to match the size of a given element"

	self subclassResponsibility
]

{ #category : #'api - cache' }
BlElementGeometry >> releaseCache [
	self subclassResponsibility
]

{ #category : #'api - cache' }
BlElementGeometry >> releaseStrokedBoundsCache [
	self subclassResponsibility
]

{ #category : #serialization }
BlElementGeometry >> storeOn: aStream [
	aStream nextPutAll: self class name; space; nextPutAll: 'new'
]

{ #category : #'api - bounds' }
BlElementGeometry >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	"Return stroked bounds of a geometry if it would be stroked according to element's border configuration.
	Dispatch through outskirts first"
	<return: #BlBounds>
	
	^ self subclassResponsibility
]
