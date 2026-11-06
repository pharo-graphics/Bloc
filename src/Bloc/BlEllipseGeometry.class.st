"
I am an ellipse filling the extent of my element.

### Responsibility
- Build an ellipse path inscribed in my extent; I am a circle when the element is square.
- Contain the points inside this ellipse.
- Answer the point of my perimeter in a given direction from the center (`pointOnPerimeterOfElement:atRadians:`), used by anchors.

### Collaborators
- `BlCircleGeometry` stays a circle, centered in the element, whatever its extent.

### Public API
```
anElement geometry: BlEllipseGeometry new.
BlEllipseGeometry new extent: 50 @ 30; yourself. ""the element sets my extent anyway""
```
See `BlEllipseGeometry class >> #exampleEllipse`, and run `BlCircleGeometry class >> #scriptCircleVersusEllipse`.

### Implementation Points
- I have no state besides my extent, so two ellipse geometries are equal.
"
Class {
	#name : #BlEllipseGeometry,
	#superclass : #BlElementVectorGeometry,
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #examples }
BlEllipseGeometry class >> exampleEllipse [
	"Answer an ellipse geometry; it fills the extent of its element."

	<sampleInstance>
	^ self new
]

{ #category : #comparing }
BlEllipseGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #'geometry testing' }
BlEllipseGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	| w h x y center xRadius yRadius normalized |
	
	w := self extent x.
	h := self extent y.
	x := 0.
	y := 0.
	
	xRadius := w / 2.0.
	yRadius := h / 2.0.
	center := (x + xRadius) @ (y + yRadius).

	(xRadius <= 0 or: [ yRadius <= 0 ])
		ifTrue: [ ^ false ].

	normalized := (aPoint x - center x) @ (aPoint y - center y).
	^ ((normalized x squared / xRadius squared) + (normalized y squared / yRadius squared)) <= 1
]

{ #category : #testing }
BlEllipseGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlEllipseGeometry >> hasJoins [

	^ false
]

{ #category : #geometry }
BlEllipseGeometry >> matchExtent: anExtent [
	self extent: anExtent
]

{ #category : #geometry }
BlEllipseGeometry >> pointOnPerimeterOfElement: anElement atRadians: radians [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	| usedRectangle radiusX radiusY |
	usedRectangle := anElement margin expand:
		                 anElement measuredBounds asRectangle.
	radiusX := usedRectangle extent x / 2.0.
	radiusY := usedRectangle extent y / 2.0.
	^ radiusX * radians cos @ (radiusY * radians sin)
	  + anElement measuredBounds center
]
