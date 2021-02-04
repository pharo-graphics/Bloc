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
	#category : #'Bloc-Basic'
}

{ #category : #'geometry testing' }
BlElementVectorGeometry >> containsPoint: aPoint in: aBlElement [
	"Note: we have to pass BlElement in order to give geometry a chance to use element properties
	as as border during the testing process"
	<return: #Boolean>

	^ self
		containsPoint: aPoint
		in: aBlElement
		on: Bloc preferableSpartaCanvas offscreen
]

{ #category : #'geometry testing' }
BlElementVectorGeometry >> containsPoint: aPoint in: anElement on: aSpartaCanvas [
	"Note: I am a fallback method to determine if a point lies within a geometry path
	when geometry is complex and it is mathematically difficult to compute manually"
	<return: #Boolean>
	| aPath |

	aPath := pathCache pathOnSpartaCanvas: aSpartaCanvas.
	^ aSpartaCanvas fill
		path: aPath;
		containsPoint: aPoint
]

{ #category : #accessing }
BlElementVectorGeometry >> extent [
	^ extent
]

{ #category : #accessing }
BlElementVectorGeometry >> extent: aPoint [
	"The argument has to be a Point of numbers (integer or float).
	Do not try to provide a fraction as x or y of the point!
	aPoint must not be nil
	aPoint must be positive"
	<argument: #aPoint satisfies: #isBlocFiniteFloatPoint>
	<argument: #aPoint satisfies: #isBlocPositivePoint>

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

{ #category : #'api - bounds' }
BlElementVectorGeometry >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	"Return stroked bounds of a geometry if it would be stroked according to element's border configuration.
	Dispatch through outskirts first"
	<return: #BlBounds>

	^ aBlBounds rectangle: (pathCache strokedBounds: aBlBounds of: anElement on: aCanvas)
]

{ #category : #'private - bounds' }
BlElementVectorGeometry >> strokedBoundsCentered: aBlBounds of: anElement on: aCanvas [
	| spartaPath strokeOptions strokedBounds |

	spartaPath := anElement geometry pathOnSpartaCanvas: aCanvas of: anElement.
	strokeOptions := aCanvas stroke
		width: (anElement border width max: 1);
		in: [ :aPainter | anElement border style applyOn: aPainter ];
		strokeOptions.

	strokedBounds := spartaPath strokedBoundsOn: aCanvas with: strokeOptions.
	^ aBlBounds rectangle: strokedBounds
]

{ #category : #'private - bounds' }
BlElementVectorGeometry >> strokedBoundsInside: aBlBounds of: anElement on: aCanvas [
	"Stroked inside bounds property is equal to geometry bounds"
	<return: #BlBounds>

	^ self geometryBounds: aBlBounds
]

{ #category : #'private - bounds' }
BlElementVectorGeometry >> strokedBoundsOutside: aBlBounds of: anElement on: aCanvas [
	| spartaPath strokeOptions strokedBounds |

	spartaPath := anElement geometry pathOnSpartaCanvas: aCanvas of: anElement.
	strokeOptions := aCanvas stroke
		in: [ :aPainter | anElement border style applyOn: aPainter ];
		width: ((anElement border width * 2.0) max: 1);
		strokeOptions.

	strokedBounds := spartaPath strokedBoundsOn: aCanvas with: strokeOptions.
	^ aBlBounds rectangle: strokedBounds
]
