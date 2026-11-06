"
I am a circle centered in my element, with the largest radius that fits in it.

### Responsibility
- Compute my radius (half the smallest side of the element) and the origin that centers me, in `matchExtent:`.
- Build a circle path, and specific paths for an inside or outside border.
- Answer my bounds (the square around the circle), contain the points inside the circle,
  and answer the point of my perimeter in a given direction (`pointOnPerimeterOfElement:atRadians:`).

### Collaborators
- `BlEllipseGeometry` fills the whole element instead, so it is a circle only in a square element.

### Public API
```
anElement geometry: BlCircleGeometry new.
```
See `BlCircleGeometry class >> #exampleCircle`, and run `BlCircleGeometry class >> #scriptCircleVersusEllipse`.

### Implementation Points
- My radius and origin are computed from the extent; they cannot be set directly.
- Two circle geometries are equal, whatever their radius: the element gives them their size.

**Instance Variables**
- radius: half the smallest side of my extent.
- origin: the top-left corner of the square around me, so that I am centered.
"
Class {
	#name : #BlCircleGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'radius',
		'origin'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #examples }
BlCircleGeometry class >> exampleCircle [
	"Answer a circle geometry; it is centered in its element, with the largest radius that fits."

	<sampleInstance>
	^ self new
]

{ #category : #script }
BlCircleGeometry class >> scriptCircleVersusEllipse [
	"Show that in an element that is not square, a circle is centered with the diameter of the
	smallest side, while an ellipse fills the whole element."

	<script>
	self demoOpen: { 
			(self
				 demoCellFor: (self demoElementFor: self new extent: 120 @ 60)
				 caption: 'circle in 120 x 60').
			(self
				 demoCellFor: (self demoElementFor: BlEllipseGeometry new extent: 120 @ 60)
				 caption: 'ellipse in 120 x 60') }
]

{ #category : #comparing }
BlCircleGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #'geometry testing' }
BlCircleGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [

	| centerX centerY |
	centerX := origin x + radius.
	centerY := origin y + radius.
	^ ((aPoint x - centerX) squared + (aPoint y - centerY) squared) < radius squared
]

{ #category : #'geometry bounds' }
BlCircleGeometry >> geometryBounds: aBlBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"

	| ext |
	ext := self radius * 2.0.
	^ aBlBounds
		origin: self origin
		extent: ext @ ext
]

{ #category : #testing }
BlCircleGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlCircleGeometry >> hasJoins [

	^ false
]

{ #category : #comparing }
BlCircleGeometry >> hash [
	^ self class hash
]

{ #category : #initialization }
BlCircleGeometry >> initialize [
	super initialize.
	
	radius := 0.
	origin := 0@0
]

{ #category : #geometry }
BlCircleGeometry >> matchExtent: anExtent [
	radius := anExtent min / 2.0.
	origin := (anExtent - anExtent min asPoint) / 2.0.

	self extent: anExtent
]

{ #category : #accessing }
BlCircleGeometry >> origin [
	^ origin
]

{ #category : #geometry }
BlCircleGeometry >> pointOnPerimeterOfElement: anElement atRadians: anAngle [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	| adjustedRectangle prevRadius prevOrigin pt |
	prevRadius := radius.
	prevOrigin := origin.
	adjustedRectangle := anElement margin expand:
		                     anElement measuredBounds.
	self matchExtent: adjustedRectangle extent.
	pt := radius * anAngle cos @ (radius * anAngle sin).
	radius := prevRadius.
	origin := prevOrigin.
	^ pt + adjustedRectangle center
]

{ #category : #accessing }
BlCircleGeometry >> radius [
	^ radius
]
