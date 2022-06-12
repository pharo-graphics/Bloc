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
	#category : #'Bloc-Basic-Geometry'
}

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
	<return: #Rectangle>

	^ (self geometryBounds: BlBounds new) asRectangle
]

{ #category : #'api - bounds' }
BlElementVectorGeometry >> geometryBounds: aBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>

	^ aBounds
		origin: 0.0@0.0
		extent: self extent
]

{ #category : #'api - bounds' }
BlElementVectorGeometry >> geometryBounds: aBounds of: aBlElement [
	"Load my geometry bounds for a given element in a mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>
	
	^ self geometryBounds: aBounds
]

{ #category : #initialization }
BlElementVectorGeometry >> initialize [
	super initialize.
	
	extent := 150@100.
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
