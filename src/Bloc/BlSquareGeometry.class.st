"
I am a square centered in my element, with the largest side that fits in it.

### Responsibility
- Compute my size and the origin that centers me from the extent of the element, in `matchExtent:`.
- Build a square path, answer my bounds and contain the points inside them.

### Collaborators
- `BlRectangleGeometry` fills the whole element instead.

### Public API
```
anElement geometry: BlSquareGeometry new.
```
See `BlSquareGeometry class >> #exampleSquare`, and run `BlSquareGeometry class >> #scriptSquareVersusRectangle`.

### Implementation Points
- Despite its name, `length` answers half the side of the square (half the smallest side of the element).
- My path is the geometry bounds of the element, which are my own bounds.
- Two square geometries are equal: the element gives them their size.

**Instance Variables**
- length: half the side of the square.
- origin: my top-left corner, so that I am centered.
"
Class {
	#name : #BlSquareGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'length',
		'origin'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #examples }
BlSquareGeometry class >> exampleSquare [
	"Answer a square geometry; it is centered in its element, with the largest side that fits."

	<sampleInstance>
	^ self new
]

{ #category : #script }
BlSquareGeometry class >> scriptSquareVersusRectangle [
	"Show that in an element that is not square, a square is centered with the length of the
	smallest side, while a rectangle fills the whole element."

	<script>
	self demoOpen: { 
			(self
				 demoCellFor: (self demoElementFor: self new extent: 120 @ 60)
				 caption: 'square in 120 x 60').
			(self
				 demoCellFor: (self demoElementFor: BlRectangleGeometry new extent: 120 @ 60)
				 caption: 'rectangle in 120 x 60') }
]

{ #category : #comparing }
BlSquareGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #'geometry testing' }
BlSquareGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [

	^ true
]

{ #category : #'geometry bounds' }
BlSquareGeometry >> geometryBounds: aBlBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"

	^ aBlBounds
		origin: self origin
		extent: (self length * 2.0) asPoint
]

{ #category : #testing }
BlSquareGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlSquareGeometry >> hasJoins [

	^ true
]

{ #category : #accessing }
BlSquareGeometry >> length [
	^ length
]

{ #category : #geometry }
BlSquareGeometry >> matchExtent: anExtent [
	length := anExtent min / 2.0.
	origin := (anExtent - anExtent min asPoint) / 2.0.

	self extent: anExtent
]

{ #category : #accessing }
BlSquareGeometry >> origin [
	^ origin
]
