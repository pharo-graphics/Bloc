"
The geometry is used to define the geometry to be drawn and the interaction area.
"
Class {
	#name : #BlElementVectorGeometry,
	#superclass : #BlElementGeometry,
	#instVars : [
		'extent',
		'pathCache'
	],
	#classVars : [
		'DefaultExtent'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'class initialization' }
BlElementVectorGeometry class >> initialize [

	DefaultExtent := 150@100
]

{ #category : #converting }
BlElementVectorGeometry >> asElement [

	^ super asElement
		extent: self extent;
		yourself
]

{ #category : #accessing }
BlElementVectorGeometry >> extent [

	^ extent
]

{ #category : #accessing }
BlElementVectorGeometry >> extent: aPoint [
	"The argument has to be a Point of numbers (integer or float).
	Do not try to provide a fraction as x or y of the point!
	aPoint must be positive (#isBlocFiniteFloatPoint and #isBlocPositivePoint)"

	extent := aPoint
]

{ #category : #'api - bounds' }
BlElementVectorGeometry >> geometryBounds [
	"Return my pure geometry bounds (fill bounds).
	This property is different from #visualBounds in the sense that I don't take stroke into account.
	Override geometryBounds: to customize computation"

	^ (self geometryBounds: BlBounds new) asRectangle
]

{ #category : #'api - bounds' }
BlElementVectorGeometry >> geometryBounds: aBlBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"

	^ aBlBounds
		origin: 0.0@0.0
		extent: self extent
]

{ #category : #'api - bounds' }
BlElementVectorGeometry >> geometryBounds: aBounds of: aBlElement [
	"Load my geometry bounds for a given element in a mutable rectangle.
	@see #geometryBounds for more info"
	
	^ self geometryBounds: aBounds
]

{ #category : #initialization }
BlElementVectorGeometry >> initialize [

	super initialize.

	extent := DefaultExtent.
	pathCache := BlPathCache on: self
]

{ #category : #geometry }
BlElementVectorGeometry >> matchElement: anElement [
	"Adapt me to match the size of a given element"

	self matchExtent: anElement extent
]

{ #category : #geometry }
BlElementVectorGeometry >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	self subclassResponsibility
]

{ #category : #copying }
BlElementVectorGeometry >> postCopy [

	pathCache := BlPathCache on: self.
	self releaseCache
]

{ #category : #'api - cache' }
BlElementVectorGeometry >> releaseCache [

	pathCache releaseCache
]

{ #category : #'api - cache' }
BlElementVectorGeometry >> releaseStrokedBoundsCache [

	pathCache releaseStrokedBoundsCache
]

{ #category : #'visual bounds' }
BlElementVectorGeometry >> strokedBounds: aBlBounds of: anElement [
	"Return stroked bounds of a geometry if it would be stroked according to element's border configuration.
	Dispatch through outskirts first"

	^ aBlBounds rectangle:
		  (pathCache strokedBounds: aBlBounds of: anElement)
]

{ #category : #'visual bounds' }
BlElementVectorGeometry >> strokedBoundsCentered: aBlBounds of: aBlElement [
	"Answer my bounds as if the border with centered outskirts.
	Particular geometries may answer a more precise answer."

	^ (self geometryBounds: aBlBounds) expandBy: aBlElement border width / 2.0
]

{ #category : #'visual bounds' }
BlElementVectorGeometry >> strokedBoundsInside: aBlBounds of: anElement [
	"Stroked inside bounds property is equal to geometry bounds"

	^ self geometryBounds: aBlBounds
]

{ #category : #'visual bounds' }
BlElementVectorGeometry >> strokedBoundsOutside: aBlBounds of: aBlElement [
	"Answer my bounds as if the border outside. 
	Particular geometries may answer a more precise answer."

	^ (self geometryBounds: aBlBounds) expandBy: aBlElement border width
]
