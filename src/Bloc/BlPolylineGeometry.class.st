"
I am an open path made of straight segments through a list of points, in the coordinates of my element.

### Responsibility
- Know my vertices; they do not change when the extent of the element changes.
- Build an open path, so I have caps: the border of the element draws me, the background has nothing to fill.
- Answer the rectangle around my vertices as my bounds, and contain the points closer to one of my segments than half the border width.

### Collaborators
- `BlPolygonGeometry` closes the same kind of path and fills it.
- `BlLineGeometry` is the case of two points.

### Public API
```
BlPolylineGeometry vertices: { 10 @ 60. 30 @ 10. 50 @ 60. 70 @ 10. 90 @ 60 }.
```
See `BlPolylineGeometry class >> #exampleZigZag`, and run `BlPolylineGeometry class >> #scriptOpenVersusClosed`.

### Implementation Points
- `vertices:` sets my extent to the largest coordinates of the vertices (`vertices max`) and releases the path cache.
- Two polylines are equal when they have the same vertices.

**Instance Variables**
- vertices: the points I go through, in order.
"
Class {
	#name : #BlPolylineGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'vertices'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #examples }
BlPolylineGeometry class >> exampleZigZag [
	"Answer an open zig-zag line through five points, in the coordinates of its element."

	<sampleInstance>
	^ self vertices: { 
			  (10 @ 60).
			  (30 @ 10).
			  (50 @ 60).
			  (70 @ 10).
			  (90 @ 60) }
]

{ #category : #script }
BlPolylineGeometry class >> scriptOpenVersusClosed [
	"Show the same points as a polyline, an open path that is only stroked, and as a polygon,
	which closes the path from the last point back to the first one and is filled."

	<script>
	| points |
	points := BlPolylineGeometry exampleZigZag vertices.
	self demoOpen: { 
			(self
				 demoCellFor: (self demoElementFor: (self vertices: points) extent: 100 @ 70)
				 caption: 'polyline').
			(self
				 demoCellFor: (self demoElementFor: (BlPolygonGeometry vertices: points) extent: 100 @ 70)
				 caption: 'polygon') }
]

{ #category : #'instance creation' }
BlPolylineGeometry class >> vertices: aCollection [
	^ self new vertices: aCollection
]

{ #category : #comparing }
BlPolylineGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self vertices = anObject vertices
]

{ #category : #'geometry testing' }
BlPolylineGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry.
	
	Based on RSPolyline>>#basicIncludesPoint:"

	vertices overlappingPairsDo: [ :a :b | 
		(aPoint onLineFrom: a to: b within: aBlElement border width / 2) 
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'geometry bounds' }
BlPolylineGeometry >> geometryBounds: aBlBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"

	^ aBlBounds
		origin: self vertices min
		corner: self vertices max
]

{ #category : #testing }
BlPolylineGeometry >> hasCaps [

	^ true
]

{ #category : #testing }
BlPolylineGeometry >> hasJoins [

	^ vertices size > 2
]

{ #category : #geometry }
BlPolylineGeometry >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #accessing }
BlPolylineGeometry >> vertices [
	<return: #SequenceableCollection of: #Point>

	^ vertices
]

{ #category : #accessing }
BlPolylineGeometry >> vertices: aCollectionOfPoints [

	vertices := aCollectionOfPoints.
	extent := vertices max.
	self releaseCache
]
