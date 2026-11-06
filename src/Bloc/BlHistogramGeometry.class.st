"
I am a histogram-like shape filling the extent of my element: a closed outline of bars of equal width.

### Responsibility
- Know my values, numbers between 0 and 1: each one is the length of a bar, as a fraction of my extent.
- Know my orientation: bars growing upwards from the bottom (`beHorizontal`, the default), downwards from the top
  (`beHorizontalInverted`), to the right from the left side (`beVertical`) or to the left from the right side (`beVerticalInverted`).
- Compute the vertices of the outline from my values, orientation and extent, and build the closed path through them.

### Collaborators
- `BlPolygonGeometry` draws any closed outline from explicit points.

### Public API
```
anElement geometry: (BlHistogramGeometry values: #( 0.3 0.7 0.5 1.0 )).
(BlHistogramGeometry values: #( 0.3 0.7 0.5 1.0 )) beVertical; yourself.
```
See `BlHistogramGeometry class >> #exampleHistogram`, and run `BlHistogramGeometry class >> #scriptOrientations`.

### Implementation Points
- The orientation names refer to the axis along which the bars are placed: horizontal bars are side by side along the x axis.
- The vertices are cached in the path cache; `values:` and the orientation setters release it.
- I do not redefine `=`.

**Instance Variables**
- values: the lengths of the bars, between 0 and 1.
- orientation: one of the symbols held by the class variables `Horizontal`, `HorizontalInverted`, `Vertical` and `VerticalInverted`.
"
Class {
	#name : #BlHistogramGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'values',
		'orientation'
	],
	#classVars : [
		'Horizontal',
		'HorizontalInverted',
		'Vertical',
		'VerticalInverted'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #examples }
BlHistogramGeometry class >> exampleHistogram [
	"Answer a histogram of six values between 0 and 1, with bars growing upwards."

	<sampleInstance>
	^ self values: #( 0.3 0.7 0.5 1.0 0.6 0.2 )
]

{ #category : #'class initialization' }
BlHistogramGeometry class >> initialize [

	Vertical := #Vertical.
	VerticalInverted := #VerticalInverted.
	Horizontal := #Horizontal.
	HorizontalInverted := #HorizontalInverted
]

{ #category : #script }
BlHistogramGeometry class >> scriptOrientations [
	"Show the same values with the four orientations of a histogram:
	bars growing upwards (the default), downwards, to the right and to the left."

	<script>
	self demoOpen: (#( #beHorizontal #beHorizontalInverted #beVertical #beVerticalInverted ) collect: [ :selector | 
			 self
				 demoCellFor: (self
						  demoElementFor: (self exampleHistogram
								   perform: selector;
								   yourself)
						  extent: 100 @ 70)
				 caption: selector ])
]

{ #category : #accessing }
BlHistogramGeometry class >> values: aCollection [

	^ self new
		values: aCollection;
		yourself
]

{ #category : #accessing }
BlHistogramGeometry >> beHorizontal [

	orientation := Horizontal.
	self releaseCache
]

{ #category : #accessing }
BlHistogramGeometry >> beHorizontalInverted [

	orientation := HorizontalInverted.
	self releaseCache
]

{ #category : #accessing }
BlHistogramGeometry >> beVertical [

	orientation := Vertical.
	self releaseCache
]

{ #category : #accessing }
BlHistogramGeometry >> beVerticalInverted [

	orientation := VerticalInverted.
	self releaseCache
]

{ #category : #'geometry testing' }
BlHistogramGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry.
	Assume aPoint is already inside the geometry bounds rectangle."
	
	^ BlPolygonHitTester doPolygonBy: self vertices include: aPoint
]

{ #category : #private }
BlHistogramGeometry >> delta [

	(self isVertical or: [ self isVerticalInverted ]) ifTrue: [
		^ 0 @ (self extent y / self values size) asFloat ].
	
	^ (self extent x / self values size) asFloat @ 0
]

{ #category : #private }
BlHistogramGeometry >> direction [

	self isVertical ifTrue: [ ^ 1.0 @ 0.0 ].
	self isVerticalInverted ifTrue: [ ^ -1.0 @ 0.0 ].
	self isHorizontalInverted ifTrue: [ ^ 0.0 @ 1.0 ].
	^ 0.0 @ -1.0
]

{ #category : #testing }
BlHistogramGeometry >> hasCaps [
	"Answer whether my path has caps, i.e. if I include an open line."

	^ false
]

{ #category : #testing }
BlHistogramGeometry >> hasJoins [
	"Answer whether I have joins, i.e. my path presents edges between a segment and another."

	^ true
]

{ #category : #initialization }
BlHistogramGeometry >> initialize [

	super initialize.
	
	values := #(0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1).
	orientation := Horizontal
]

{ #category : #testing }
BlHistogramGeometry >> isHorizontal [

	^ orientation = Horizontal
]

{ #category : #testing }
BlHistogramGeometry >> isHorizontalInverted [

	^ orientation = HorizontalInverted
]

{ #category : #testing }
BlHistogramGeometry >> isVertical [

	^ orientation = Vertical
]

{ #category : #testing }
BlHistogramGeometry >> isVerticalInverted [

	^ orientation = VerticalInverted
]

{ #category : #geometry }
BlHistogramGeometry >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : #private }
BlHistogramGeometry >> origin [

	self isVertical ifTrue: [ ^ 0.0 @ 0.0 ].
	self isVerticalInverted ifTrue: [ ^ self extent x asFloat @ 0.0 ].
	self isHorizontalInverted ifTrue: [ ^ 0.0 @ 0.0 ].
	^ 0.0 @ self extent y asFloat
]

{ #category : #accessing }
BlHistogramGeometry >> values [

	^ values
]

{ #category : #accessing }
BlHistogramGeometry >> values: aCollectionOfFloats [

	values := aCollectionOfFloats.
	self releaseCache
]

{ #category : #private }
BlHistogramGeometry >> vertices [

	^ pathCache geometryPath ifNil: [

		| origin delta direction vertices |
		origin := self origin.
		delta := self delta.
		direction := self direction.

		vertices := Array streamContents: [ :stream |
			stream nextPut: origin.

			self values inject: origin into: [ :currentPoint :each |
				| aNewY |
				aNewY := currentPoint + delta.
				stream
					nextPut: currentPoint + (direction * each * self extent);
					nextPut: aNewY + (direction * each * self extent).
				aNewY ].

			stream nextPut: origin + (delta normalized * self extent) ].

		pathCache geometryPath: vertices.

		vertices ]
]
