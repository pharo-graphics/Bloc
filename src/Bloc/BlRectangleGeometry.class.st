"
I am the default geometry of an element: a rectangle covering the whole element.

### Responsibility
- Build a rectangle path from 0 @ 0 to the extent of the element, with specific paths for an inside or outside border.
- Answer the bounds of the element as my geometry bounds, and contain every point of these bounds.
- Answer the point of my perimeter in a given direction from the center (`pointOnPerimeterOfElement:atRadians:`), used by anchors.

### Collaborators
- `BlElement` uses me when no other geometry is set.
- `BlRoundedRectangleGeometry` adds rounded corners; `BlSquareGeometry` keeps the sides equal.

### Public API
```
anElement geometry: BlRectangleGeometry new.
```
See `BlRectangleGeometry class >> #exampleRectangle`, and run `BlSquareGeometry class >> #scriptSquareVersusRectangle`.

### Implementation Points
- I keep no state: I read the extent of the element each time, so `matchElement:` does nothing. Two rectangle geometries are equal.
- I am a direct subclass of `BlElementGeometry`, not of `BlElementVectorGeometry`: I need no extent and no path cache.
"
Class {
	#name : #BlRectangleGeometry,
	#superclass : #BlElementGeometry,
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #examples }
BlRectangleGeometry class >> exampleRectangle [
	"Answer a rectangle geometry, the default geometry of an element."

	<sampleInstance>
	^ self new
]

{ #category : #comparing }
BlRectangleGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #'geometry testing' }
BlRectangleGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Note: we have to pass BlElement in order to give geometry a chance to use element properties
	as as border during the testing process"
	
	(aPoint x < 0 and: [ aPoint y < 0 ])
		ifTrue: [ ^ false ].

	^ aPoint x < aBlElement width
		and: [ aPoint y < aBlElement height ]
]

{ #category : #'api - bounds' }
BlRectangleGeometry >> geometryBounds: aBlBounds of: aBlElement [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	
	^ aBlBounds
		left: 0
		top: 0
		right: aBlElement width
		bottom: aBlElement height
]

{ #category : #testing }
BlRectangleGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlRectangleGeometry >> hasJoins [

	^ true
]

{ #category : #geometry }
BlRectangleGeometry >> matchElement: anElement [
	"Adapt me to match the size of a given element"
]

{ #category : #geometry }
BlRectangleGeometry >> pointOnPerimeterOfElement: anElement atRadians: anAngleInRadians [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	| adjustedRect dx dy scale x y halfWidth halfHeight usedCenter insets bnds |
	insets := anElement margin.
	bnds := anElement measuredBounds asRectangle.

	adjustedRect := Rectangle
		                origin: bnds topLeft + insets topLeft negated
		                corner: bnds bottomRight + insets bottomRight.

	usedCenter := adjustedRect center.
	dx := anAngleInRadians cos.
	dy := anAngleInRadians sin.

	halfWidth := adjustedRect width / 2.
	halfHeight := adjustedRect height / 2.

	scale := 1 / (dx abs / halfWidth max: dy abs / halfHeight).

	x := usedCenter x + (dx * scale).
	y := usedCenter y + (dy * scale).

	^ x @ y
]

{ #category : #'api - cache' }
BlRectangleGeometry >> releaseStrokedBoundsCache [
]

{ #category : #'visual bounds' }
BlRectangleGeometry >> strokedBounds: aBlBounds of: anElement [
	"Return stroked bounds of a geometry if it would be stroked according to element's outskirts."

	^ anElement outskirts strokedBounds: aBlBounds of: anElement
]

{ #category : #'visual bounds' }
BlRectangleGeometry >> strokedBoundsCentered: aBlBounds of: aBlElement [

	| aHalfWidth |
	aHalfWidth := aBlElement border width / 2.0.

	^ aBlBounds
		left: aHalfWidth negated
		top: aHalfWidth negated
		right: aBlElement width + aHalfWidth
		bottom: aBlElement height + aHalfWidth
]

{ #category : #'visual bounds' }
BlRectangleGeometry >> strokedBoundsInside: aBlBounds of: aBlElement [
	"Stroked inside bounds property is equal to geometry bounds"

	^ aBlBounds
		left: 0
		top: 0
		right: aBlElement width
		bottom: aBlElement height
]

{ #category : #'visual bounds' }
BlRectangleGeometry >> strokedBoundsOutside: aBlBounds of: aBlElement [

	| aBorderWidth |
	aBorderWidth := aBlElement border width.

	^ aBlBounds
		left: aBorderWidth negated
		top: aBorderWidth negated
		right: aBlElement width + aBorderWidth
		bottom: aBlElement height + aBorderWidth
]
