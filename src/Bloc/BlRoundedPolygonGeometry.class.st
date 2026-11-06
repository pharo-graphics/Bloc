"
I am a polygon whose corners are all rounded with the same radius.

### Responsibility
- Know the radius of my corners.
- Build a closed path where each corner is replaced by an arc tangent to its two segments.

### Collaborators
- `BlPolygonGeometry`, my superclass, holds the vertices.
- `AlbPrimarySelectionElement` (Album) uses me to draw the text selection.

### Public API
```
BlRoundedPolygonGeometry vertices: { 50 @ 5. 95 @ 65. 5 @ 65 } radius: 10.
```
See `BlRoundedPolygonGeometry class >> #exampleRoundedTriangle`, and run `BlRoundedPolygonGeometry class >> #scriptRadius`.

### Implementation Points
- The radius of a corner is reduced when its arc would need more than half of one of its two segments.
- `radius:` releases the path cache. `=` is inherited: the radius is not compared.
- The drawing is based on `RSAthensRenderer>>#applyRadius:on:from:to:` from Roassal.

**Instance Variables**
- radius: the radius of every corner.
"
Class {
	#name : #BlRoundedPolygonGeometry,
	#superclass : #BlPolygonGeometry,
	#instVars : [
		'radius'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #examples }
BlRoundedPolygonGeometry class >> exampleRoundedTriangle [
	"Answer a triangle whose corners are rounded with a radius of 10."

	<sampleInstance>
	^ self
		  vertices: { 
				  (50 @ 5).
				  (95 @ 65).
				  (5 @ 65) }
		  radius: 10
]

{ #category : #script }
BlRoundedPolygonGeometry class >> scriptRadius [
	"Show the same triangle with its corners rounded with a radius of 0, 5 and 15."

	<script>
	| points |
	points := self exampleRoundedTriangle vertices.
	self demoOpen: (#( 0 5 15 ) collect: [ :radius | 
			 self
				 demoCellFor: (self demoElementFor: (self vertices: points radius: radius) extent: 100 @ 70)
				 caption: 'radius: ' , radius printString ])
]

{ #category : #'instance creation' }
BlRoundedPolygonGeometry class >> vertices: aCollection radius: aNumber [

	^ self new
		vertices: aCollection;
		radius: aNumber;
		yourself
]

{ #category : #accessing }
BlRoundedPolygonGeometry >> radius [

	^ radius
]

{ #category : #accessing }
BlRoundedPolygonGeometry >> radius: aNumber [

	radius := aNumber.
	self releaseCache
]
