"
I am the abstract class of the geometries that keep their own extent and cache their path.

### Responsibility
- Remember the extent I must fill (150 x 100 by default, see `DefaultExtent`), set by `matchExtent:`
  when the extent of the element changes.
- Answer my geometry bounds from my extent (`geometryBounds:`), unless my subclass computes them from its points.
- Cache my path and my stroked bounds in a `BlPathCache`; `releaseCache` empties it when one of my properties changes.

### Collaborators
- `BlElement` sends me `matchElement:` (and so `matchExtent:`) when its extent changes.
- `BlPathCache` keeps my stroked bounds and, for some subclasses, my computed vertices.
- My subclasses fall in two families:
  - the shapes that fill the extent of the element: `BlEllipseGeometry`, `BlCircleGeometry`, `BlSquareGeometry`,
    `BlRoundedRectangleGeometry`, `BlStadiumGeometry`, `BlTriangleGeometry`, `BlAnnulusSectorGeometry`, `BlHistogramGeometry`;
  - the shapes defined by points in the coordinates of the element, which keep their points when the extent changes:
    `BlLineGeometry`, `BlPolylineGeometry`, `BlPolygonGeometry`, `BlBezierCurveGeometry`, `BlSigmoidGeometry`, `BlSvgPath`.

### Public API
I am abstract: use my subclasses.
```
(BlEllipseGeometry new matchExtent: 100 @ 50; yourself) geometryBounds.
aGeometry asElement. ""an element with my extent and a default look""
```
Run `BlElementVectorGeometry class >> #scriptMatchExtent`.

### Implementation Points
- My subclasses implement `matchExtent:` and `aeApplyTo:element:`, and send `releaseCache` after changing what defines their path.
- `extent:` expects a positive point of integers or floats, not fractions.
- `postCopy` gives the copy its own path cache.

**Instance Variables**
- extent: the `Point` I fill.
- pathCache: the `BlPathCache` of my path and stroked bounds.
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

{ #category : #script }
BlElementVectorGeometry class >> scriptMatchExtent [
	"Show that a vector geometry follows the extent of its element: the same kinds of geometry
	on elements of 60 x 60, 120 x 60 and 60 x 90. The element sends `matchExtent:` to its geometry
	whenever its extent changes. Geometries defined by points, like polygons, keep their points."

	<script>
	| extents |
	extents := { 60 @ 60. 120 @ 60. 60 @ 90 }.
	self demoOpen: (({ 
			  BlEllipseGeometry new.
			  BlTriangleGeometry new.
			  BlStadiumGeometry new.
			  BlPolygonGeometry exampleArrow } collect: [ :geometry | 
			 extents collect: [ :extent | 
				 self
					 demoCellFor: (self demoElementFor: geometry copy extent: extent)
					 caption: extent printString ] ]) flatCollect: [ :each | each ])
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
	"Adapt me to match the extent of a given element"

	self matchExtent: anElement extent
]

{ #category : #geometry }
BlElementVectorGeometry >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	self subclassResponsibility
]

{ #category : #accessing }
BlElementVectorGeometry >> pathCache [

	^ pathCache
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
