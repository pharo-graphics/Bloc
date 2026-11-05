"
I am a closed shape made of straight segments through a list of points, in the coordinates of my element.

### Responsibility
- Know my vertices, converted to float points; they do not change when the extent of the element changes.
- Build a closed path (the last vertex is joined to the first one), so the background fills me.
- Answer the rectangle around my vertices as my bounds, and contain the points inside the shape (`BlPolygonHitTester`).

### Collaborators
- `BlPolylineGeometry` draws the same points as an open path.
- `BlRoundedPolygonGeometry` rounds my corners; `ToAdjacentRectanglesGeometry` computes my vertices from rectangles.
- `BlTriangleGeometry` and `BlHistogramGeometry` compute their vertices from the extent of the element instead.

### Public API
```
BlPolygonGeometry vertices: { 10 @ 25. 60 @ 25. 60 @ 10. 90 @ 35. 60 @ 60. 60 @ 45. 10 @ 45 }.
anElement geometry: (BlPolygonGeometry vertices: { 0 @ 0. 50 @ 0. 25 @ 40 }).
```
See `BlPolygonGeometry class >> #exampleArrow`, and run `BlPolylineGeometry class >> #scriptOpenVersusClosed`.

### Implementation Points
- `vertices:` does nothing when the new vertices are equal to the current ones; otherwise it sets my extent
  to the largest coordinates of the vertices and releases the path cache.
- Two polygons are equal when they have the same vertices.

**Instance Variables**
- vertices: the corners of the shape, in order.
"
Class {
	#name : #BlPolygonGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'vertices'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #examples }
BlPolygonGeometry class >> exampleArrow [
	"Answer a closed arrow pointing to the right, in the coordinates of its element.
	The class is named explicitly so that subclasses inheriting this method still answer a plain polygon."

	<sampleInstance>
	^ BlPolygonGeometry vertices: { 
			  (10 @ 25).
			  (60 @ 25).
			  (60 @ 10).
			  (90 @ 35).
			  (60 @ 60).
			  (60 @ 45).
			  (10 @ 45) }
]

{ #category : #'instance creation' }
BlPolygonGeometry class >> vertices: aCollection [
	^ self new vertices: aCollection
]

{ #category : #comparing }
BlPolygonGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self vertices = anObject vertices
]

{ #category : #'geometry testing' }
BlPolygonGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry."

	^ BlPolygonHitTester doPolygonBy: self vertices include: aPoint
]

{ #category : #'api - bounds' }
BlPolygonGeometry >> geometryBounds: aBlBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"

	^ aBlBounds
		origin: (self vertices ifEmpty: [0@0] ifNotEmpty: [self vertices min])
		corner: (self vertices ifEmpty: [0@0] ifNotEmpty: [self vertices max])
]

{ #category : #testing }
BlPolygonGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlPolygonGeometry >> hasJoins [

	^ true
]

{ #category : #initialization }
BlPolygonGeometry >> initialize [ 

	super initialize.
	vertices := #()
]

{ #category : #geometry }
BlPolygonGeometry >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #accessing }
BlPolygonGeometry >> vertices [

	^ vertices
]

{ #category : #accessing }
BlPolygonGeometry >> vertices: aCollectionOfPoints [
	| theNewVertices |
	theNewVertices := aCollectionOfPoints collect: [ :eachPoint | eachPoint asFloatPoint ].
	
	theNewVertices = vertices
		ifTrue: [ ^ self ].
	
	vertices := theNewVertices.
	extent := vertices ifEmpty: [ 0@0 ] ifNotEmpty: [vertices max].
	self releaseCache
]
