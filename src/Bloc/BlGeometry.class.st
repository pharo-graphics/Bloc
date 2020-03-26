"
The geometry is used to define the geometry to be drawn and the interaction area.
"
Class {
	#name : #BlGeometry,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'extent',
		'pathCache'
	],
	#category : #'Bloc-Basic'
}

{ #category : #converting }
BlGeometry >> asElement [
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
BlGeometry >> containsPoint: aPoint in: aBlElement [
	"Note: we have to pass BlElement in order to give geometry a chance to use element properties
	as as border during the testing process"
	<return: #Boolean>

	^ self
		containsPoint: aPoint
		in: aBlElement
		on: Bloc preferableSpartaCanvas offscreen
]

{ #category : #'geometry testing' }
BlGeometry >> containsPoint: aPoint in: anElement on: aSpartaCanvas [
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
BlGeometry >> extent [
	^ extent
]

{ #category : #accessing }
BlGeometry >> extent: aPoint [
	"The argument has to be a Point of numbers (integer or float).
	Do not try to provide a fraction as x or y of the point!
	aPoint must not be nil
	aPoint must be positive"

	self
		assert: [ aPoint x >= 0 and: [ aPoint y >= 0 ] ]
		description: [ 'Geometry extent must be non-negative!' ].

	extent := aPoint
]

{ #category : #'geometry bounds' }
BlGeometry >> geometryBounds [
	"Return my geometry bounds.
	This property is different from #visualBounds in the sense that I don't take stroke into account.
	Override geometryBounds: to customize computation"
	<return: #Rectangle>

	^ (self geometryBounds: BlBounds new) asRectangle
]

{ #category : #'geometry bounds' }
BlGeometry >> geometryBounds: aBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>

	^ aBounds
		origin: 0@0
		extent: self extent
]

{ #category : #initialization }
BlGeometry >> initialize [
	super initialize.
	
	extent := 150@100.
	pathCache := BlPathCache on: self
]

{ #category : #geometry }
BlGeometry >> matchElement: anElement [
	self matchExtent: anElement extent
]

{ #category : #geometry }
BlGeometry >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	self subclassResponsibility
]

{ #category : #copying }
BlGeometry >> postCopy [
	pathCache := BlPathCache on: self.
	self releaseCache
]

{ #category : #cache }
BlGeometry >> releaseCache [
	pathCache releaseCache
]

{ #category : #cache }
BlGeometry >> releaseStrokedBoundsCache [
	pathCache releaseStrokedBoundsCache
]

{ #category : #'visual bounds' }
BlGeometry >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	"Return stroked bounds of a geometry if it would be stroked according to element's border configuration.
	Dispatch through outskirts first"
	<return: #BlBounds>

	^ aBlBounds rectangle: (pathCache strokedBounds: aBlBounds of: anElement on: aCanvas)
]

{ #category : #'visual bounds' }
BlGeometry >> strokedBoundsCentered: aBlBounds of: anElement on: aCanvas [
	| spartaPath strokeOptions strokedBounds |

	spartaPath := anElement geometry pathOnSpartaCanvas: aCanvas.
	strokeOptions := aCanvas stroke
		width: (anElement border width max: 1);
		in: [ :aPainter | anElement border style applyOn: aPainter ];
		strokeOptions.

	strokedBounds := spartaPath strokedBoundsOn: aCanvas with: strokeOptions.
	^ aBlBounds rectangle: strokedBounds
]

{ #category : #'visual bounds' }
BlGeometry >> strokedBoundsInside: aBlBounds of: anElement on: aCanvas [
	"Stroked inside bounds property is equal to geometry bounds"
	<return: #BlBounds>

	^ self geometryBounds: aBlBounds
]

{ #category : #'visual bounds' }
BlGeometry >> strokedBoundsOutside: aBlBounds of: anElement on: aCanvas [
	| spartaPath strokeOptions strokedBounds |

	spartaPath := anElement geometry pathOnSpartaCanvas: aCanvas.
	strokeOptions := aCanvas stroke
		in: [ :aPainter | anElement border style applyOn: aPainter ];
		width: ((anElement border width * 2.0) max: 1);
		strokeOptions.

	strokedBounds := spartaPath strokedBoundsOn: aCanvas with: strokeOptions.
	^ aBlBounds rectangle: strokedBounds
]
