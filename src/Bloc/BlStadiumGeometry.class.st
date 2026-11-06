"
I am a stadium filling the extent of my element: a rectangle whose two shortest sides are replaced by half circles.

### Responsibility
- Build a horizontal stadium when the element is wider than high, a vertical one when it is higher than wide, and a circle when it is square.
- Contain the points inside this shape.

### Collaborators
- `BlRoundedRectangleGeometry` gives a similar shape with explicit radii; I always use half the shortest side.
- Toplo uses me for buttons, switches and scrollbar thumbs.

### Public API
```
anElement geometry: BlStadiumGeometry new.
```
See `BlStadiumGeometry class >> #exampleStadium`, and run `BlStadiumGeometry class >> #scriptStadiumExtents`.

### Implementation Points
- I have no state besides my extent. I do not redefine `=`.
"
Class {
	#name : #BlStadiumGeometry,
	#superclass : #BlElementVectorGeometry,
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #examples }
BlStadiumGeometry class >> exampleStadium [
	"Answer a stadium geometry: a rectangle capped with half circles on its shortest sides."

	<sampleInstance>
	^ self new
]

{ #category : #script }
BlStadiumGeometry class >> scriptStadiumExtents [
	"Show that a stadium is rounded on its shortest sides: horizontal when the element is wider,
	vertical when it is taller, and a circle when it is square."

	<script>
	self demoOpen: ({ 120 @ 50. 50 @ 100. 70 @ 70 } collect: [ :extent | 
			 self
				 demoCellFor: (self demoElementFor: self new extent: extent)
				 caption: extent printString ])
]

{ #category : #'geometry testing' }
BlStadiumGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry.
	Assume aPoint is already inside the geometry bounds rectangle."

	extent x > extent y ifTrue: [
		^ self containsPointHorizontalStadium: aPoint ].

	extent x < extent y ifTrue: [
		^ self containsPointVerticalStadium: aPoint ].

	^ self containsPointCircle: aPoint
]

{ #category : #'geometry testing' }
BlStadiumGeometry >> containsPointCircle: aPoint [
	"We assume extent x = extent y"

	| radius |
	radius := extent x / 2.
	^ ((aPoint x - radius) squared + (aPoint y - radius) squared) < radius squared
]

{ #category : #'geometry testing' }
BlStadiumGeometry >> containsPointHorizontalStadium: aPoint [

	| radius x1 x2 |
	radius := extent y / 2.0.
	x1 := radius.
	x2 := extent x - radius.

	"First semicircle?"
	aPoint x < x1 ifTrue: [
		^ (aPoint distanceTo: radius asPoint) <= radius ].

	"Last semicircle?"
	aPoint x > x2 ifTrue: [
		^ (aPoint distanceTo: (x2 @ radius)) <= radius ].

	"Then, it's in the middle"
	^ true
]

{ #category : #'geometry testing' }
BlStadiumGeometry >> containsPointVerticalStadium: aPoint [

	| radius y1 y2 |
	radius := extent x / 2.0.
	y1 := radius.
	y2 := extent y - radius.

	"First semicircle?"
	aPoint y < y1 ifTrue: [
		^ (aPoint distanceTo: radius asPoint) <= radius ].

	"Last semicircle?"
	aPoint y > y2 ifTrue: [
		^ (aPoint distanceTo: (radius @ y2)) <= radius ].

	"Then, it's in the middle"
	^ true
]

{ #category : #testing }
BlStadiumGeometry >> hasCaps [
	"Answer whether my path has caps, i.e. if I include an open line."

	^ false
]

{ #category : #testing }
BlStadiumGeometry >> hasJoins [
	"Answer whether I have joins, i.e. my path presents edges between a segment and another."

	^ false
]

{ #category : #geometry }
BlStadiumGeometry >> matchExtent: aPoint [

	extent := aPoint
]
